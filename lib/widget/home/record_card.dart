import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:clippy/database/database.dart';
import 'package:clippy/store/index.dart';

import 'render.dart';
import 'list.dart';

class TapTime {
  int? id;
  int? time;
}

var _tapTime = TapTime();

class RecordCard extends StatelessWidget {
  final RecordEntityData item;
  final int index;

  const RecordCard({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final isSelected = item.id == recordStore.selectedId;

      return GestureDetector(
          onTap: () {
            final now = DateTime.now().millisecondsSinceEpoch;
            if (_tapTime.id == item.id && now - _tapTime.time! < 300) {
              copy(item);
            }
            _tapTime.time = now;
            _tapTime.id = item.id;
            recordStore.setSelectedId(item.id);
          },
          child: Container(
            margin: EdgeInsets.only(
                left: index == 0 ? 16 : 8,
                right: index == recordStore.records.length - 1 ? 16 : 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    width: 3)),
            width: 270,
            height: 290,
            child: Container(
              margin: const EdgeInsets.all(1.5),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
              ),
              child: Render(item: item),
            ),
          ));
    });
  }
}
