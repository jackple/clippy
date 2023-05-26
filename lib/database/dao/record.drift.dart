// ignore_for_file: type=lint
part of 'record.dart';

mixin _$RecordDaoMixin on DatabaseAccessor<DB> {
  $RecordEntityTable get recordEntity => attachedDatabase.recordEntity;
}
