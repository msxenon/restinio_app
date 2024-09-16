// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'table_model.dart';

class TableModelMapper extends ClassMapperBase<TableModel> {
  TableModelMapper._();

  static TableModelMapper? _instance;
  static TableModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TableModelMapper._());
      TableEntityMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TableModel';

  static TableEntity _$table(TableModel v) => v.table;
  static const Field<TableModel, TableEntity> _f$table =
      Field('table', _$table);
  static TableStatus _$status(TableModel v) => v.status;
  static const Field<TableModel, TableStatus> _f$status =
      Field('status', _$status);

  @override
  final MappableFields<TableModel> fields = const {
    #table: _f$table,
    #status: _f$status,
  };

  static TableModel _instantiate(DecodingData data) {
    return TableModel(table: data.dec(_f$table), status: data.dec(_f$status));
  }

  @override
  final Function instantiate = _instantiate;

  static TableModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TableModel>(map);
  }

  static TableModel fromJson(String json) {
    return ensureInitialized().decodeJson<TableModel>(json);
  }
}

mixin TableModelMappable {
  String toJson() {
    return TableModelMapper.ensureInitialized()
        .encodeJson<TableModel>(this as TableModel);
  }

  Map<String, dynamic> toMap() {
    return TableModelMapper.ensureInitialized()
        .encodeMap<TableModel>(this as TableModel);
  }

  TableModelCopyWith<TableModel, TableModel, TableModel> get copyWith =>
      _TableModelCopyWithImpl(this as TableModel, $identity, $identity);
  @override
  String toString() {
    return TableModelMapper.ensureInitialized()
        .stringifyValue(this as TableModel);
  }

  @override
  bool operator ==(Object other) {
    return TableModelMapper.ensureInitialized()
        .equalsValue(this as TableModel, other);
  }

  @override
  int get hashCode {
    return TableModelMapper.ensureInitialized().hashValue(this as TableModel);
  }
}

extension TableModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TableModel, $Out> {
  TableModelCopyWith<$R, TableModel, $Out> get $asTableModel =>
      $base.as((v, t, t2) => _TableModelCopyWithImpl(v, t, t2));
}

abstract class TableModelCopyWith<$R, $In extends TableModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  TableEntityCopyWith<$R, TableEntity, TableEntity> get table;
  $R call({TableEntity? table, TableStatus? status});
  TableModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TableModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TableModel, $Out>
    implements TableModelCopyWith<$R, TableModel, $Out> {
  _TableModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TableModel> $mapper =
      TableModelMapper.ensureInitialized();
  @override
  TableEntityCopyWith<$R, TableEntity, TableEntity> get table =>
      $value.table.copyWith.$chain((v) => call(table: v));
  @override
  $R call({TableEntity? table, TableStatus? status}) =>
      $apply(FieldCopyWithData({
        if (table != null) #table: table,
        if (status != null) #status: status
      }));
  @override
  TableModel $make(CopyWithData data) => TableModel(
      table: data.get(#table, or: $value.table),
      status: data.get(#status, or: $value.status));

  @override
  TableModelCopyWith<$R2, TableModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TableModelCopyWithImpl($value, $cast, t);
}
