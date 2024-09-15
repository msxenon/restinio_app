// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'food_entity.dart';

class FoodEntityMapper extends ClassMapperBase<FoodEntity> {
  FoodEntityMapper._();

  static FoodEntityMapper? _instance;
  static FoodEntityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FoodEntityMapper._());
      BaseEntityMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FoodEntity';

  static String _$id(FoodEntity v) => v.id;
  static const Field<FoodEntity, String> _f$id = Field('id', _$id);
  static String _$name(FoodEntity v) => v.name;
  static const Field<FoodEntity, String> _f$name = Field('name', _$name);
  static String _$description(FoodEntity v) => v.description;
  static const Field<FoodEntity, String> _f$description =
      Field('description', _$description);
  static double _$price(FoodEntity v) => v.price;
  static const Field<FoodEntity, double> _f$price = Field('price', _$price);
  static String _$imageUrl(FoodEntity v) => v.imageUrl;
  static const Field<FoodEntity, String> _f$imageUrl =
      Field('imageUrl', _$imageUrl);

  @override
  final MappableFields<FoodEntity> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
    #price: _f$price,
    #imageUrl: _f$imageUrl,
  };

  static FoodEntity _instantiate(DecodingData data) {
    return FoodEntity(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        price: data.dec(_f$price),
        imageUrl: data.dec(_f$imageUrl));
  }

  @override
  final Function instantiate = _instantiate;

  static FoodEntity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FoodEntity>(map);
  }

  static FoodEntity fromJson(String json) {
    return ensureInitialized().decodeJson<FoodEntity>(json);
  }
}

mixin FoodEntityMappable {
  String toJson() {
    return FoodEntityMapper.ensureInitialized()
        .encodeJson<FoodEntity>(this as FoodEntity);
  }

  Map<String, dynamic> toMap() {
    return FoodEntityMapper.ensureInitialized()
        .encodeMap<FoodEntity>(this as FoodEntity);
  }

  FoodEntityCopyWith<FoodEntity, FoodEntity, FoodEntity> get copyWith =>
      _FoodEntityCopyWithImpl(this as FoodEntity, $identity, $identity);
  @override
  String toString() {
    return FoodEntityMapper.ensureInitialized()
        .stringifyValue(this as FoodEntity);
  }

  @override
  bool operator ==(Object other) {
    return FoodEntityMapper.ensureInitialized()
        .equalsValue(this as FoodEntity, other);
  }

  @override
  int get hashCode {
    return FoodEntityMapper.ensureInitialized().hashValue(this as FoodEntity);
  }
}

extension FoodEntityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FoodEntity, $Out> {
  FoodEntityCopyWith<$R, FoodEntity, $Out> get $asFoodEntity =>
      $base.as((v, t, t2) => _FoodEntityCopyWithImpl(v, t, t2));
}

abstract class FoodEntityCopyWith<$R, $In extends FoodEntity, $Out>
    implements BaseEntityCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      String? name,
      String? description,
      double? price,
      String? imageUrl});
  FoodEntityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FoodEntityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FoodEntity, $Out>
    implements FoodEntityCopyWith<$R, FoodEntity, $Out> {
  _FoodEntityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FoodEntity> $mapper =
      FoodEntityMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? name,
          String? description,
          double? price,
          String? imageUrl}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (description != null) #description: description,
        if (price != null) #price: price,
        if (imageUrl != null) #imageUrl: imageUrl
      }));
  @override
  FoodEntity $make(CopyWithData data) => FoodEntity(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      price: data.get(#price, or: $value.price),
      imageUrl: data.get(#imageUrl, or: $value.imageUrl));

  @override
  FoodEntityCopyWith<$R2, FoodEntity, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FoodEntityCopyWithImpl($value, $cast, t);
}
