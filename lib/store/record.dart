import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:mobx/mobx.dart';
import 'package:image/image.dart';
import 'package:clippy/database/database.dart';
import 'package:clippy/database/type/record.dart';
import 'package:clippy/utils/logger.dart';
import 'package:clippy/utils/common.dart';
import './record_type.dart';

part 'record.g.dart';

class RecordStore = _RecordStore with _$RecordStore;

RecordStore recordStore = RecordStore();

abstract class _RecordStore with Store {
  /// 选中的记录id
  @observable
  int? selectedId;

  /// 添加记录
  @action
  void setSelectedId(int? id) {
    selectedId = id;
  }

  /// 搜索关键词
  @observable
  bool searching = false;

  /// 搜索关键词
  @observable
  String? searchKW;

  /// 同步搜索关键词
  @action
  void setSearchKW(String? text) {
    searchKW = text;
  }

  /// 记录列表
  @observable
  ObservableList<RecordEntityData> records = ObservableList.of([]);

  /// 记录列表(关键词匹配)
  @observable
  ObservableList<RecordEntityData> searchedRecords = ObservableList.of([]);

  /// 清空记录列表(关键词匹配)
  @action
  void clearSearchedRecords() {
    searchedRecords = ObservableList.of([]);
  }

  /// 查找记录
  @action
  Future<void> getRecords() async {
    if (searching) {
      return logger.i('正在请求, 本次被拦截');
    }
    searching = true;
    final _records = isEmptyString(searchKW) ? records : searchedRecords;
    final oldestUpdateAt = _records.isNotEmpty ? _records.last.updateAt : null;
    try {
      final list = await recordDao.get(
          keyword: searchKW, oldestUpdateAt: oldestUpdateAt);
      // 第一次时默认选中第一个
      if (oldestUpdateAt == null && list.isNotEmpty) {
        setSelectedId(list.first.id);
      }
      _records.addAll(list);
    } finally {
      searching = false;
    }
  }

  /// 添加记录前检查
  @action
  Future<void> addRecord(RecordType type, String value) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    // 先从内存数据中查找
    final indexInMemory =
        records.indexWhere((r) => r.value == value && r.type == type);
    if (indexInMemory == 0) {
      return;
    }
    if (indexInMemory > -1) {
      final item = records[indexInMemory];
      records[indexInMemory] = item.copyWith(updateAt: now);
      // 先删除原本的位置
      _addRecordInMemory(records[indexInMemory]);
      records.removeAt(indexInMemory + 1);
      await _updateRecordInDB(item.id, now);
      return logger.i('已在内存');
    }
    // 从数据库查找
    final item = await recordDao.getOne(type, value);
    if (item != null) {
      _addRecordInMemory(item);
      await _updateRecordInDB(item.id, now);
      return logger.i('已在数据库');
    }
    // 内存&数据库都没有, 才执行添加
    final imgSizeAndthumbnail =
        type == RecordType.image ? getSizeAndThumbnail(value) : null;
    final imgSize = imgSizeAndthumbnail != null
        ? '${imgSizeAndthumbnail.width}x${imgSizeAndthumbnail.height}'
        : null;
    final size = type == RecordType.file ? await getFileSize(value) : null;
    final recordEntityCompanion = RecordEntityCompanion(
        type: Value(type),
        value: Value(value),
        thumbnail: Value(imgSizeAndthumbnail?.thumbnail),
        imgSize: Value(imgSize),
        size: Value(size),
        createAt: Value(now),
        updateAt: Value(now));
    final id = await recordDao.insertOne(recordEntityCompanion);
    final record = db.recordEntity
        .mapFromCompanion(recordEntityCompanion.copyWith(id: Value(id)));
    _addRecordInMemory(record);
    logger.i('新增');
  }

  Future<void> _updateRecordInDB(int id, int now) async {
    await (recordDao.update(recordDao.recordEntity)
          ..where((tbl) => tbl.id.equals(id)))
        .write(RecordEntityCompanion(updateAt: Value(now)));
  }

  void _addRecordInMemory(RecordEntityData item) {
    records.insert(0, item);
    const maxLen = 60;
    if (isEmptyString(searchKW)) {
      setSelectedId(item.id);
    } else if (item.value.contains(searchKW!)) {
      searchedRecords.insert(0, item);
      setSelectedId(item.id);
      if (searchedRecords.length > maxLen) {
        searchedRecords.removeRange(maxLen, searchedRecords.length);
      }
    }
    if (records.length > maxLen) {
      records.removeRange(maxLen, records.length);
    }
  }

  ImgSizeAndThumbnail? getSizeAndThumbnail(String value) {
    Image? thumbnail;
    final originImage = decodeImage(base64Decode(value));
    if (originImage != null) {
      if (originImage.width > 750) {
        thumbnail = copyResize(originImage, width: 300);
      } else if (originImage.height > 750) {
        thumbnail = copyResize(originImage, height: 300);
      }
      return ImgSizeAndThumbnail(
          originImage.width,
          originImage.height,
          thumbnail != null
              ? base64Encode(encodeJpg(thumbnail, quality: 30))
              : null);
    }
    return null;
  }
}
