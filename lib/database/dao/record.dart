import 'package:drift/drift.dart';
import 'package:clippy/utils/common.dart';

import '../database.dart';
import '../entity/record.dart';
import '../type/record.dart';

part 'record.drift.dart';

@DriftAccessor(tables: [RecordEntity])
class RecordDao extends DatabaseAccessor<DB> with _$RecordDaoMixin {
  RecordDao(DB db) : super(db);

  Future<List<RecordEntityData>> get({int? oldestUpdateAt, String? keyword}) {
    var query = select(recordEntity);
    if (oldestUpdateAt != null) {
      query = query
        ..where((tbl) => tbl.updateAt.isSmallerThanValue(oldestUpdateAt));
    }
    if (!isEmptyString(keyword)) {
      query = query
        ..where((tbl) =>
            tbl.value.like('%${keyword!}%') &
            // 只允许搜索文本类型
            tbl.type.equalsValue(RecordType.text));
    }
    query = query
      ..orderBy([
        (tbl) => OrderingTerm(expression: tbl.updateAt, mode: OrderingMode.desc)
      ])
      ..limit(30);
    return query.get();
  }

  Future<RecordEntityData?> getOne(RecordType type, String value) => (select(
          recordEntity)
        ..where((tbl) => tbl.type.equalsValue(type) & tbl.value.equals(value)))
      .getSingleOrNull();

  Future<int> insertOne(RecordEntityCompanion item) =>
      into(recordEntity).insert(item);
}
