import 'dart:io';
import 'dart:isolate';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift/isolate.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:clippy/utils/logger.dart';

// daos
import 'dao/record.dart';
// entitys
import 'entity/record.dart';
// types 作用于database.g.dart
import 'type/record.dart';

part 'database.drift.dart';

/// 当前数据库实例
late DB db;

/// daos
late RecordDao recordDao;

void initDaos(DB database) {
  recordDao = RecordDao(database);
}

@DriftDatabase(tables: [RecordEntity], daos: [])
class DB extends _$DB {
  DB(super.e);
  // https://drift.simonbinder.eu/docs/advanced-features/migrations/
  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        return m.createAll();
      }, onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1) {
          await m.addColumn(recordEntity, recordEntity.thumbnail);
          await m.addColumn(recordEntity, recordEntity.size);
        }
        if (from == 2) {
          await m.addColumn(recordEntity, recordEntity.imgSize);
        }
      });
}

/// 创建isolate
/// https://drift.simonbinder.eu/docs/advanced-features/isolates/#initialization-on-the-main-thread
Future<DriftIsolate> _createDriftIsolate() async {
  final token = RootIsolateToken.instance;
  final receiveIsolate = ReceivePort('receive drift isolate handle');

  await Isolate.spawn<SendPort>((message) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(token!);

    final dbFolder = await getApplicationDocumentsDirectory();
    String dbPath = join(dbFolder.path, 'data.db');
    logger.i('数据库地址: $dbPath');
    final executor = NativeDatabase(File(dbPath));
    final server = DriftIsolate.inCurrent(() => DatabaseConnection(executor));

    // Now, inform the original isolate about the created server:
    message.send(server);
  }, receiveIsolate.sendPort);

  final server = await receiveIsolate.first as DriftIsolate;
  receiveIsolate.close();
  return server;
}

/// 创建数据库实例
Future<DB> createDBInstance() async {
  // 使用isolate创建db
  DriftIsolate isolate = await _createDriftIsolate();
  db = DB(await isolate.connect(singleClientMode: true));

  initDaos(db);
  await recordDao.removeOldRecords();
  logger.i('已清除30天前的数据');
  return db;
}
