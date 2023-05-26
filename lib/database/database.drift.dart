// ignore_for_file: type=lint
part of 'database.dart';

class $RecordEntityTable extends RecordEntity
    with TableInfo<$RecordEntityTable, RecordEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecordEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<RecordType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<RecordType>($RecordEntityTable.$convertertype);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _thumbnailMeta =
      const VerificationMeta('thumbnail');
  @override
  late final GeneratedColumn<String> thumbnail = GeneratedColumn<String>(
      'thumbnail', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int> size = GeneratedColumn<int>(
      'size', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _imgSizeMeta =
      const VerificationMeta('imgSize');
  @override
  late final GeneratedColumn<String> imgSize = GeneratedColumn<String>(
      'img_size', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createAtMeta =
      const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<int> createAt = GeneratedColumn<int>(
      'create_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updateAtMeta =
      const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<int> updateAt = GeneratedColumn<int>(
      'update_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, type, value, thumbnail, size, imgSize, createAt, updateAt];
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
    if (data.containsKey('thumbnail')) {
      context.handle(_thumbnailMeta,
          thumbnail.isAcceptableOrUnknown(data['thumbnail']!, _thumbnailMeta));
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size']!, _sizeMeta));
    }
    if (data.containsKey('img_size')) {
      context.handle(_imgSizeMeta,
          imgSize.isAcceptableOrUnknown(data['img_size']!, _imgSizeMeta));
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecordEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      type: $RecordEntityTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      thumbnail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}thumbnail']),
      size: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}size']),
      imgSize: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}img_size']),
      createAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}create_at'])!,
      updateAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}update_at'])!,
    );
  }

  @override
  $RecordEntityTable createAlias(String alias) {
    return $RecordEntityTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RecordType, int, int> $convertertype =
      const EnumIndexConverter<RecordType>(RecordType.values);
}

class RecordEntityData extends DataClass
    implements Insertable<RecordEntityData> {
  final int id;
  final RecordType type;
  final String value;

  /// 图片缩略图
  final String? thumbnail;

  /// 文件大小
  final int? size;

  /// 图片尺寸, 例: 100x100
  final String? imgSize;
  final int createAt;
  final int updateAt;
  const RecordEntityData(
      {required this.id,
      required this.type,
      required this.value,
      this.thumbnail,
      this.size,
      this.imgSize,
      required this.createAt,
      required this.updateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      final converter = $RecordEntityTable.$convertertype;
      map['type'] = Variable<int>(converter.toSql(type));
    }
    map['value'] = Variable<String>(value);
    if (!nullToAbsent || thumbnail != null) {
      map['thumbnail'] = Variable<String>(thumbnail);
    }
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<int>(size);
    }
    if (!nullToAbsent || imgSize != null) {
      map['img_size'] = Variable<String>(imgSize);
    }
    map['create_at'] = Variable<int>(createAt);
    map['update_at'] = Variable<int>(updateAt);
    return map;
  }

  RecordEntityCompanion toCompanion(bool nullToAbsent) {
    return RecordEntityCompanion(
      id: Value(id),
      type: Value(type),
      value: Value(value),
      thumbnail: thumbnail == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnail),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      imgSize: imgSize == null && nullToAbsent
          ? const Value.absent()
          : Value(imgSize),
      createAt: Value(createAt),
      updateAt: Value(updateAt),
    );
  }

  factory RecordEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecordEntityData(
      id: serializer.fromJson<int>(json['id']),
      type: $RecordEntityTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      value: serializer.fromJson<String>(json['value']),
      thumbnail: serializer.fromJson<String?>(json['thumbnail']),
      size: serializer.fromJson<int?>(json['size']),
      imgSize: serializer.fromJson<String?>(json['img_size']),
      createAt: serializer.fromJson<int>(json['create_at']),
      updateAt: serializer.fromJson<int>(json['update_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer
          .toJson<int>($RecordEntityTable.$convertertype.toJson(type)),
      'value': serializer.toJson<String>(value),
      'thumbnail': serializer.toJson<String?>(thumbnail),
      'size': serializer.toJson<int?>(size),
      'img_size': serializer.toJson<String?>(imgSize),
      'create_at': serializer.toJson<int>(createAt),
      'update_at': serializer.toJson<int>(updateAt),
    };
  }

  RecordEntityData copyWith(
          {int? id,
          RecordType? type,
          String? value,
          Value<String?> thumbnail = const Value.absent(),
          Value<int?> size = const Value.absent(),
          Value<String?> imgSize = const Value.absent(),
          int? createAt,
          int? updateAt}) =>
      RecordEntityData(
        id: id ?? this.id,
        type: type ?? this.type,
        value: value ?? this.value,
        thumbnail: thumbnail.present ? thumbnail.value : this.thumbnail,
        size: size.present ? size.value : this.size,
        imgSize: imgSize.present ? imgSize.value : this.imgSize,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
      );
  @override
  String toString() {
    return (StringBuffer('RecordEntityData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('size: $size, ')
          ..write('imgSize: $imgSize, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, type, value, thumbnail, size, imgSize, createAt, updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecordEntityData &&
          other.id == this.id &&
          other.type == this.type &&
          other.value == this.value &&
          other.thumbnail == this.thumbnail &&
          other.size == this.size &&
          other.imgSize == this.imgSize &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class RecordEntityCompanion extends UpdateCompanion<RecordEntityData> {
  final Value<int> id;
  final Value<RecordType> type;
  final Value<String> value;
  final Value<String?> thumbnail;
  final Value<int?> size;
  final Value<String?> imgSize;
  final Value<int> createAt;
  final Value<int> updateAt;
  const RecordEntityCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.value = const Value.absent(),
    this.thumbnail = const Value.absent(),
    this.size = const Value.absent(),
    this.imgSize = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
  });
  RecordEntityCompanion.insert({
    this.id = const Value.absent(),
    required RecordType type,
    required String value,
    this.thumbnail = const Value.absent(),
    this.size = const Value.absent(),
    this.imgSize = const Value.absent(),
    required int createAt,
    required int updateAt,
  })  : type = Value(type),
        value = Value(value),
        createAt = Value(createAt),
        updateAt = Value(updateAt);
  static Insertable<RecordEntityData> custom({
    Expression<int>? id,
    Expression<int>? type,
    Expression<String>? value,
    Expression<String>? thumbnail,
    Expression<int>? size,
    Expression<String>? imgSize,
    Expression<int>? createAt,
    Expression<int>? updateAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (value != null) 'value': value,
      if (thumbnail != null) 'thumbnail': thumbnail,
      if (size != null) 'size': size,
      if (imgSize != null) 'img_size': imgSize,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
    });
  }

  RecordEntityCompanion copyWith(
      {Value<int>? id,
      Value<RecordType>? type,
      Value<String>? value,
      Value<String?>? thumbnail,
      Value<int?>? size,
      Value<String?>? imgSize,
      Value<int>? createAt,
      Value<int>? updateAt}) {
    return RecordEntityCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      value: value ?? this.value,
      thumbnail: thumbnail ?? this.thumbnail,
      size: size ?? this.size,
      imgSize: imgSize ?? this.imgSize,
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
      final converter = $RecordEntityTable.$convertertype;
      map['type'] = Variable<int>(converter.toSql(type.value));
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (thumbnail.present) {
      map['thumbnail'] = Variable<String>(thumbnail.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (imgSize.present) {
      map['img_size'] = Variable<String>(imgSize.value);
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
          ..write('thumbnail: $thumbnail, ')
          ..write('size: $size, ')
          ..write('imgSize: $imgSize, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$DB extends GeneratedDatabase {
  _$DB(QueryExecutor e) : super(e);
  late final $RecordEntityTable recordEntity = $RecordEntityTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [recordEntity];
}
