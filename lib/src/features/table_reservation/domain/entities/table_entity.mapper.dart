// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'table_entity.dart';

class TableEntityMapper extends ClassMapperBase<TableEntity> {
  TableEntityMapper._();

  static TableEntityMapper? _instance;
  static TableEntityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TableEntityMapper._());
      BaseEntityMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TableEntity';

  static String _$id(TableEntity v) => v.id;
  static const Field<TableEntity, String> _f$id = Field('id', _$id);
  static String _$tag(TableEntity v) => v.tag;
  static const Field<TableEntity, String> _f$tag = Field('tag', _$tag);
  static int _$seats(TableEntity v) => v.seats;
  static const Field<TableEntity, int> _f$seats = Field('seats', _$seats);

  @override
  final MappableFields<TableEntity> fields = const {
    #id: _f$id,
    #tag: _f$tag,
    #seats: _f$seats,
  };

  static TableEntity _instantiate(DecodingData data) {
    return TableEntity(
        id: data.dec(_f$id), tag: data.dec(_f$tag), seats: data.dec(_f$seats));
  }

  @override
  final Function instantiate = _instantiate;

  static TableEntity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TableEntity>(map);
  }

  static TableEntity fromJson(String json) {
    return ensureInitialized().decodeJson<TableEntity>(json);
  }
}

mixin TableEntityMappable {
  String toJson() {
    return TableEntityMapper.ensureInitialized()
        .encodeJson<TableEntity>(this as TableEntity);
  }

  Map<String, dynamic> toMap() {
    return TableEntityMapper.ensureInitialized()
        .encodeMap<TableEntity>(this as TableEntity);
  }

  TableEntityCopyWith<TableEntity, TableEntity, TableEntity> get copyWith =>
      _TableEntityCopyWithImpl(this as TableEntity, $identity, $identity);
  @override
  String toString() {
    return TableEntityMapper.ensureInitialized()
        .stringifyValue(this as TableEntity);
  }

  @override
  bool operator ==(Object other) {
    return TableEntityMapper.ensureInitialized()
        .equalsValue(this as TableEntity, other);
  }

  @override
  int get hashCode {
    return TableEntityMapper.ensureInitialized().hashValue(this as TableEntity);
  }
}

extension TableEntityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TableEntity, $Out> {
  TableEntityCopyWith<$R, TableEntity, $Out> get $asTableEntity =>
      $base.as((v, t, t2) => _TableEntityCopyWithImpl(v, t, t2));
}

abstract class TableEntityCopyWith<$R, $In extends TableEntity, $Out>
    implements BaseEntityCopyWith<$R, $In, $Out> {
  @override
  $R call({String? id, String? tag, int? seats});
  TableEntityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TableEntityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TableEntity, $Out>
    implements TableEntityCopyWith<$R, TableEntity, $Out> {
  _TableEntityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TableEntity> $mapper =
      TableEntityMapper.ensureInitialized();
  @override
  $R call({String? id, String? tag, int? seats}) => $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (tag != null) #tag: tag,
        if (seats != null) #seats: seats
      }));
  @override
  TableEntity $make(CopyWithData data) => TableEntity(
      id: data.get(#id, or: $value.id),
      tag: data.get(#tag, or: $value.tag),
      seats: data.get(#seats, or: $value.seats));

  @override
  TableEntityCopyWith<$R2, TableEntity, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TableEntityCopyWithImpl($value, $cast, t);
}
