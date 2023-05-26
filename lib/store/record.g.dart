// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RecordStore on RecordStoreBase, Store {
  late final _$selectedIdAtom =
      Atom(name: 'RecordStoreBase.selectedId', context: context);

  @override
  int? get selectedId {
    _$selectedIdAtom.reportRead();
    return super.selectedId;
  }

  @override
  set selectedId(int? value) {
    _$selectedIdAtom.reportWrite(value, super.selectedId, () {
      super.selectedId = value;
    });
  }

  late final _$searchingAtom =
      Atom(name: 'RecordStoreBase.searching', context: context);

  @override
  bool get searching {
    _$searchingAtom.reportRead();
    return super.searching;
  }

  @override
  set searching(bool value) {
    _$searchingAtom.reportWrite(value, super.searching, () {
      super.searching = value;
    });
  }

  late final _$searchKWAtom =
      Atom(name: 'RecordStoreBase.searchKW', context: context);

  @override
  String? get searchKW {
    _$searchKWAtom.reportRead();
    return super.searchKW;
  }

  @override
  set searchKW(String? value) {
    _$searchKWAtom.reportWrite(value, super.searchKW, () {
      super.searchKW = value;
    });
  }

  late final _$recordsAtom =
      Atom(name: 'RecordStoreBase.records', context: context);

  @override
  ObservableList<RecordEntityData> get records {
    _$recordsAtom.reportRead();
    return super.records;
  }

  @override
  set records(ObservableList<RecordEntityData> value) {
    _$recordsAtom.reportWrite(value, super.records, () {
      super.records = value;
    });
  }

  late final _$searchedRecordsAtom =
      Atom(name: 'RecordStoreBase.searchedRecords', context: context);

  @override
  ObservableList<RecordEntityData> get searchedRecords {
    _$searchedRecordsAtom.reportRead();
    return super.searchedRecords;
  }

  @override
  set searchedRecords(ObservableList<RecordEntityData> value) {
    _$searchedRecordsAtom.reportWrite(value, super.searchedRecords, () {
      super.searchedRecords = value;
    });
  }

  late final _$getRecordsAsyncAction =
      AsyncAction('RecordStoreBase.getRecords', context: context);

  @override
  Future<void> getRecords({bool? fromInputSearch}) {
    return _$getRecordsAsyncAction
        .run(() => super.getRecords(fromInputSearch: fromInputSearch));
  }

  late final _$addRecordAsyncAction =
      AsyncAction('RecordStoreBase.addRecord', context: context);

  @override
  Future<void> addRecord(RecordType type, String value) {
    return _$addRecordAsyncAction.run(() => super.addRecord(type, value));
  }

  late final _$RecordStoreBaseActionController =
      ActionController(name: 'RecordStoreBase', context: context);

  @override
  void setSelectedId(int? id) {
    final _$actionInfo = _$RecordStoreBaseActionController.startAction(
        name: 'RecordStoreBase.setSelectedId');
    try {
      return super.setSelectedId(id);
    } finally {
      _$RecordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchKW(String? text) {
    final _$actionInfo = _$RecordStoreBaseActionController.startAction(
        name: 'RecordStoreBase.setSearchKW');
    try {
      return super.setSearchKW(text);
    } finally {
      _$RecordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedId: ${selectedId},
searching: ${searching},
searchKW: ${searchKW},
records: ${records},
searchedRecords: ${searchedRecords}
    ''';
  }
}
