// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'base_entity.dart';

class BaseEntityMapper extends ClassMapperBase<BaseEntity> {
  BaseEntityMapper._();

  static BaseEntityMapper? _instance;
  static BaseEntityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BaseEntityMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BaseEntity';

  static String _$id(BaseEntity v) => v.id;
  static const Field<BaseEntity, String> _f$id = Field('id', _$id);

  @override
  final MappableFields<BaseEntity> fields = const {
    #id: _f$id,
  };

  static BaseEntity _instantiate(DecodingData data) {
    return BaseEntity(id: data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static BaseEntity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BaseEntity>(map);
  }

  static BaseEntity fromJson(String json) {
    return ensureInitialized().decodeJson<BaseEntity>(json);
  }
}

mixin BaseEntityMappable {
  String toJson() {
    return BaseEntityMapper.ensureInitialized()
        .encodeJson<BaseEntity>(this as BaseEntity);
  }

  Map<String, dynamic> toMap() {
    return BaseEntityMapper.ensureInitialized()
        .encodeMap<BaseEntity>(this as BaseEntity);
  }

  BaseEntityCopyWith<BaseEntity, BaseEntity, BaseEntity> get copyWith =>
      _BaseEntityCopyWithImpl(this as BaseEntity, $identity, $identity);
  @override
  String toString() {
    return BaseEntityMapper.ensureInitialized()
        .stringifyValue(this as BaseEntity);
  }

  @override
  bool operator ==(Object other) {
    return BaseEntityMapper.ensureInitialized()
        .equalsValue(this as BaseEntity, other);
  }

  @override
  int get hashCode {
    return BaseEntityMapper.ensureInitialized().hashValue(this as BaseEntity);
  }
}

extension BaseEntityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BaseEntity, $Out> {
  BaseEntityCopyWith<$R, BaseEntity, $Out> get $asBaseEntity =>
      $base.as((v, t, t2) => _BaseEntityCopyWithImpl(v, t, t2));
}

abstract class BaseEntityCopyWith<$R, $In extends BaseEntity, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id});
  BaseEntityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BaseEntityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BaseEntity, $Out>
    implements BaseEntityCopyWith<$R, BaseEntity, $Out> {
  _BaseEntityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BaseEntity> $mapper =
      BaseEntityMapper.ensureInitialized();
  @override
  $R call({String? id}) => $apply(FieldCopyWithData({if (id != null) #id: id}));
  @override
  BaseEntity $make(CopyWithData data) =>
      BaseEntity(id: data.get(#id, or: $value.id));

  @override
  BaseEntityCopyWith<$R2, BaseEntity, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BaseEntityCopyWithImpl($value, $cast, t);
}
