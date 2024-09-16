// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'reservation_entity.dart';

class ReservationEntityMapper extends ClassMapperBase<ReservationEntity> {
  ReservationEntityMapper._();

  static ReservationEntityMapper? _instance;
  static ReservationEntityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReservationEntityMapper._());
      BaseEntityMapper.ensureInitialized();
      MapperContainer.globals.useAll([TimestampMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'ReservationEntity';

  static String _$id(ReservationEntity v) => v.id;
  static const Field<ReservationEntity, String> _f$id = Field('id', _$id);
  static DateTime _$createdAt(ReservationEntity v) => v.createdAt;
  static const Field<ReservationEntity, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt);
  static String _$createdBy(ReservationEntity v) => v.createdBy;
  static const Field<ReservationEntity, String> _f$createdBy =
      Field('createdBy', _$createdBy);
  static String _$bookedName(ReservationEntity v) => v.bookedName;
  static const Field<ReservationEntity, String> _f$bookedName =
      Field('bookedName', _$bookedName);
  static String _$tableId(ReservationEntity v) => v.tableId;
  static const Field<ReservationEntity, String> _f$tableId =
      Field('tableId', _$tableId);

  @override
  final MappableFields<ReservationEntity> fields = const {
    #id: _f$id,
    #createdAt: _f$createdAt,
    #createdBy: _f$createdBy,
    #bookedName: _f$bookedName,
    #tableId: _f$tableId,
  };

  static ReservationEntity _instantiate(DecodingData data) {
    return ReservationEntity(
        id: data.dec(_f$id),
        createdAt: data.dec(_f$createdAt),
        createdBy: data.dec(_f$createdBy),
        bookedName: data.dec(_f$bookedName),
        tableId: data.dec(_f$tableId));
  }

  @override
  final Function instantiate = _instantiate;

  static ReservationEntity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ReservationEntity>(map);
  }

  static ReservationEntity fromJson(String json) {
    return ensureInitialized().decodeJson<ReservationEntity>(json);
  }
}

mixin ReservationEntityMappable {
  String toJson() {
    return ReservationEntityMapper.ensureInitialized()
        .encodeJson<ReservationEntity>(this as ReservationEntity);
  }

  Map<String, dynamic> toMap() {
    return ReservationEntityMapper.ensureInitialized()
        .encodeMap<ReservationEntity>(this as ReservationEntity);
  }

  ReservationEntityCopyWith<ReservationEntity, ReservationEntity,
          ReservationEntity>
      get copyWith => _ReservationEntityCopyWithImpl(
          this as ReservationEntity, $identity, $identity);
  @override
  String toString() {
    return ReservationEntityMapper.ensureInitialized()
        .stringifyValue(this as ReservationEntity);
  }

  @override
  bool operator ==(Object other) {
    return ReservationEntityMapper.ensureInitialized()
        .equalsValue(this as ReservationEntity, other);
  }

  @override
  int get hashCode {
    return ReservationEntityMapper.ensureInitialized()
        .hashValue(this as ReservationEntity);
  }
}

extension ReservationEntityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ReservationEntity, $Out> {
  ReservationEntityCopyWith<$R, ReservationEntity, $Out>
      get $asReservationEntity =>
          $base.as((v, t, t2) => _ReservationEntityCopyWithImpl(v, t, t2));
}

abstract class ReservationEntityCopyWith<$R, $In extends ReservationEntity,
    $Out> implements BaseEntityCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      DateTime? createdAt,
      String? createdBy,
      String? bookedName,
      String? tableId});
  ReservationEntityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ReservationEntityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ReservationEntity, $Out>
    implements ReservationEntityCopyWith<$R, ReservationEntity, $Out> {
  _ReservationEntityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ReservationEntity> $mapper =
      ReservationEntityMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          DateTime? createdAt,
          String? createdBy,
          String? bookedName,
          String? tableId}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (createdAt != null) #createdAt: createdAt,
        if (createdBy != null) #createdBy: createdBy,
        if (bookedName != null) #bookedName: bookedName,
        if (tableId != null) #tableId: tableId
      }));
  @override
  ReservationEntity $make(CopyWithData data) => ReservationEntity(
      id: data.get(#id, or: $value.id),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      createdBy: data.get(#createdBy, or: $value.createdBy),
      bookedName: data.get(#bookedName, or: $value.bookedName),
      tableId: data.get(#tableId, or: $value.tableId));

  @override
  ReservationEntityCopyWith<$R2, ReservationEntity, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ReservationEntityCopyWithImpl($value, $cast, t);
}
