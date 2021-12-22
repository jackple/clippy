import 'package:drift/drift.dart';

import 'package:clippy/database/type/record.dart';

/// 粘贴板记录表
class RecordEntity extends Table {
  @override
  String get tableName => 'record';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get type => intEnum<RECORD_TYPE>()();

  TextColumn get value => text()();

  /// 图片缩略图
  TextColumn get thumbnail => text().nullable()();

  /// 文件大小
  IntColumn get size => integer().nullable()();

  /// 图片尺寸, 例: 100x100
  @JsonKey('img_size')
  TextColumn get imgSize => text().nullable()();

  @JsonKey('create_at')
  IntColumn get createAt => integer()();

  @JsonKey('update_at')
  IntColumn get updateAt => integer()();
}
