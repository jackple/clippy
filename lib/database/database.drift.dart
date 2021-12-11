// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class RecordEntityData extends DataClass
    implements Insertable<RecordEntityData> {
  final int id;
  final RECORD_TYPE type;
  final String value;
  final int createAt;
  final int updateAt;
  RecordEntityData(
      {required this.id,
      required this.type,
      required this.value,
      required this.createAt,
      required this.updateAt});
  factory RecordEntityData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return RecordEntityData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      type: $RecordEntityTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type']))!,
      value: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value'])!,
      createAt: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}create_at'])!,
      updateAt: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}update_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      final converter = $RecordEntityTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type)!);
    }
    map['value'] = Variable<String>(value);
    map['create_at'] = Variable<int>(createAt);
    map['update_at'] = Variable<int>(updateAt);
    return map;
  }

  RecordEntityCompanion toCompanion(bool nullToAbsent) {
    return RecordEntityCompanion(
      id: Value(id),
      type: Value(type),
      value: Value(value),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory RecordEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecordEntityData(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<RECORD_TYPE>(json['type']),
      value: serializer.fromJson<String>(json['value']),
      createAt: serializer.fromJson<int>(json['create_at']),
      updateAt: serializer.fromJson<int>(json['update_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<RECORD_TYPE>(type),
      'value': serializer.toJson<String>(value),
      'create_at': serializer.toJson<int>(createAt),
      'update_at': serializer.toJson<int>(updateAt),
    };
  }

  RecordEntityData copyWith(
          {int? id,
          RECORD_TYPE? type,
          String? value,
          int? createAt,
          int? updateAt}) =>
      RecordEntityData(
        id: id ?? this.id,
        type: type ?? this.type,
        value: value ?? this.value,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );
  @override
  String toString() {
    return (StringBuffer('RecordEntityData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, value, createAt, updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecordEntityData &&
          other.id == this.id &&
          other.type == this.type &&
          other.value == this.value &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class RecordEntityCompanion extends UpdateCompanion<RecordEntityData> {
  final Value<int> id;
  final Value<RECORD_TYPE> type;
  final Value<String> value;
  final Value<int> createAt;
  final Value<int> updateAt;
  const RecordEntityCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.value = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
  });
  RecordEntityCompanion.insert({
    this.id = const Value.absent(),
    required RECORD_TYPE type,
    required String value,
    required int createAt,
    required int updateAt,
  })  : type = Value(type),
        value = Value(value),
        createAt = Value(createAt),
        updateAt = Value(updateAt);
  static Insertable<RecordEntityData> custom({
    Expression<int>? id,
    Expression<RECORD_TYPE>? type,
    Expression<String>? value,
    Expression<int>? createAt,
    Expression<int>? updateAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (value != null) 'value': value,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
    });
  }

  RecordEntityCompanion copyWith(
      {Value<int>? id,
      Value<RECORD_TYPE>? type,
      Value<String>? value,
      Value<int>? createAt,
      Value<int>? updateAt}) {
    return RecordEntityCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      value: value ?? this.value,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      final converter = $RecordEntityTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type.value)!);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<int>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<int>(updateAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecordEntityCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }
}

class $RecordEntityTable extends RecordEntity
    with TableInfo<$RecordEntityTable, RecordEntityData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $RecordEntityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumnWithTypeConverter<RECORD_TYPE, int?> type =
      GeneratedColumn<int?>('type', aliasedName, false,
              typeName: 'INTEGER', requiredDuringInsert: true)
          .withConverter<RECORD_TYPE>($RecordEntityTable.$converter0);
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  late final GeneratedColumn<String?> value = GeneratedColumn<String?>(
      'value', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _createAtMeta = const VerificationMeta('createAt');
  late final GeneratedColumn<int?> createAt = GeneratedColumn<int?>(
      'create_at', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _updateAtMeta = const VerificationMeta('updateAt');
  late final GeneratedColumn<int?> updateAt = GeneratedColumn<int?>(
      'update_at', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, type, value, createAt, updateAt];
  @override
  String get aliasedName => _alias ?? 'record';
  @override
  String get actualTableName => 'record';
  @override
  VerificationContext validateIntegrity(Insertable<RecordEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    } else if (isInserting) {
      context.missing(_createAtMeta);
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    } else if (isInserting) {
      context.missing(_updateAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecordEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return RecordEntityData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $RecordEntityTable createAlias(String alias) {
    return $RecordEntityTable(_db, alias);
  }

  static TypeConverter<RECORD_TYPE, int> $converter0 =
      const EnumIndexConverter<RECORD_TYPE>(RECORD_TYPE.values);
}

abstract class _$DB extends GeneratedDatabase {
  _$DB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  _$DB.connect(DatabaseConnection c) : super.connect(c);
  late final $RecordEntityTable recordEntity = $RecordEntityTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [recordEntity];
}
