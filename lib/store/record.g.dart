// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RecordStore on _RecordStore, Store {
  final _$selectedIdAtom = Atom(name: '_RecordStore.selectedId');

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

  final _$searchingAtom = Atom(name: '_RecordStore.searching');

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

  final _$searchKWAtom = Atom(name: '_RecordStore.searchKW');

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

  final _$recordsAtom = Atom(name: '_RecordStore.records');

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

  final _$searchedRecordsAtom = Atom(name: '_RecordStore.searchedRecords');

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

  final _$getRecordsAsyncAction = AsyncAction('_RecordStore.getRecords');

  @override
  Future<void> getRecords() {
    return _$getRecordsAsyncAction.run(() => super.getRecords());
  }

  final _$addRecordAsyncAction = AsyncAction('_RecordStore.addRecord');

  @override
  Future<void> addRecord(RECORD_TYPE type, String value) {
    return _$addRecordAsyncAction.run(() => super.addRecord(type, value));
  }

  final _$_RecordStoreActionController = ActionController(name: '_RecordStore');

  @override
  void setSelectedId(int? id) {
    final _$actionInfo = _$_RecordStoreActionController.startAction(
        name: '_RecordStore.setSelectedId');
    try {
      return super.setSelectedId(id);
    } finally {
      _$_RecordStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchKW(String? text) {
    final _$actionInfo = _$_RecordStoreActionController.startAction(
        name: '_RecordStore.setSearchKW');
    try {
      return super.setSearchKW(text);
    } finally {
      _$_RecordStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSearchedRecords() {
    final _$actionInfo = _$_RecordStoreActionController.startAction(
        name: '_RecordStore.clearSearchedRecords');
    try {
      return super.clearSearchedRecords();
    } finally {
      _$_RecordStoreActionController.endAction(_$actionInfo);
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
