import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift/isolate.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/open.dart';
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

void initDaos(DB _db) {
  recordDao = RecordDao(_db);
}

@DriftDatabase(tables: [RecordEntity], daos: [])
class DB extends _$DB {
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

  DB.connect(DatabaseConnection connection) : super.connect(connection);
}

DynamicLibrary _openOnWindows() {
  final script = File(Platform.script.toFilePath());
  final libraryNextToScript = File(join(script.path, 'sqlite3.dll'));
  return DynamicLibrary.open(libraryNextToScript.path);
}

/// 创建isolate
/// https://drift.simonbinder.eu/docs/advanced-features/isolates/#initialization-on-the-main-thread
Future<DriftIsolate> _createDriftIsolate() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  String dbPath = join(dbFolder.path, 'data.db');
  logger.i('数据库地址: $dbPath');

  final receivePort = ReceivePort();
  await Isolate.spawn(
    _startBackground,
    _IsolateStartRequest(receivePort.sendPort, dbPath),
  );
  return (await receivePort.first as DriftIsolate);
}

void _startBackground(_IsolateStartRequest request) {
  open.overrideFor(OperatingSystem.windows, _openOnWindows);
  final executor = NativeDatabase(File(request.targetPath));
  final driftIsolate = DriftIsolate.inCurrent(
    () => DatabaseConnection.fromExecutor(executor),
  );
  // inform the starting isolate about this, so that it can call .connect()
  request.sendDriftIsolate.send(driftIsolate);
}

class _IsolateStartRequest {
  final SendPort sendDriftIsolate;
  final String targetPath;

  _IsolateStartRequest(this.sendDriftIsolate, this.targetPath);
}

/// 创建数据库实例
Future<DB> createDBInstance() async {
  // 使用isolate创建db
  DriftIsolate isolate = await _createDriftIsolate();
  DatabaseConnection connection = await isolate.connect();
  db = DB.connect(connection);

  initDaos(db);
  return db;
}
