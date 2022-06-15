import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:collection/collection.dart';
import 'package:clippy/store/index.dart';
import 'package:clippy/utils/hotkey.dart';
import 'package:clippy/utils/common.dart';
import 'package:clippy/utils/logger.dart';
import 'package:clippy/utils/extension.dart';
import 'package:clippy/database/database.dart';
import 'package:clippy/database/type/record.dart';

import 'record_card.dart';

final ItemScrollController itemScrollController = ItemScrollController();
FocusNode _focusNode = FocusNode();

void _handleKey(RawKeyEvent key) {
  if (key.runtimeType.toString() == 'RawKeyDownEvent') {
    final data = key.data as RawKeyEventDataMacOs;
    final keyCode = data.keyCode;
    // 左右键切换
    if (keyCode == 123 || keyCode == 124) {
      final records = isEmptyString(recordStore.searchKW)
          ? recordStore.records
          : recordStore.searchedRecords;
      if (records.isEmpty) {
        return;
      }
      final turnLeft = keyCode == 123;
      final isEnd = turnLeft
          ? recordStore.selectedId == records.first.id
          : recordStore.selectedId == records.last.id;
      if (isEnd) {
        return;
      }
      final currentIndex =
          records.indexWhere((r) => r.id == recordStore.selectedId);
      final newIndex = turnLeft ? currentIndex - 1 : currentIndex + 1;
      recordStore.setSelectedId(records[newIndex].id);
    } else if (keyCode == 36) {
      // 回车复制
      final item = recordStore.records
          .firstWhereOrNull((r) => r.id == recordStore.selectedId);
      if (item != null) {
        copy(item);
      }
    }
  }
}

/// 复制
Future<void> copy(RecordEntityData item) async {
  try {
    item.type == RecordType.file
        ? await setClipboardContent(item.value, false)
        : item.type == RecordType.image
            ? await setClipboardContent(item.value, true)
            : await Clipboard.setData(ClipboardData(text: item.value));
  } catch (e) {
    logger.e('复制时发生错误');
    logger.e(e);
  } finally {
    recordStore.addRecord(item.type, item.value);
    hideWindow();
    _scrollTo(0);
  }
}

void _scrollTo(int index) {
  itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 100),
      alignment: 0.8);
}

Timer? _timer;

class List extends HookWidget {
  const List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);

    return Observer(builder: (_) {
      final records = recordStore.records;
      final selectedId = recordStore.selectedId;
      final searchKW = recordStore.searchKW;
      final searchedRecords = recordStore.searchedRecords;
      final displayRecords =
          isEmptyString(searchKW) ? records : searchedRecords;

      return HookBuilder(builder: (_) {
        useEffect(() {
          if (_timer != null && _timer!.isActive) {
            _timer!.cancel();
          }
          _timer = Timer(const Duration(milliseconds: 50), () {
            final index = displayRecords.indexWhere((r) => r.id == selectedId);
            if (index > -1) {
              _scrollTo(index);
              // 加载下一页
              if (displayRecords.length - index == 5) {
                recordStore.getRecords();
              }
            }
          });
          return;
        }, [selectedId]);

        return Expanded(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: RawKeyboardListener(
              focusNode: _focusNode,
              onKey: _handleKey,
              child: ScrollablePositionedList.builder(
                scrollDirection: Axis.horizontal,
                itemCount: displayRecords.length,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final record = displayRecords[index];
                  return RecordCard(
                    key: Key(record.id.toString()),
                    item: record,
                    index: index,
                  );
                },
                itemScrollController: itemScrollController,
              )),
        ));
      });
    });
  }
}
