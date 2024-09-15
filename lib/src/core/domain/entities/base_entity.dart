import 'package:dart_mappable/dart_mappable.dart';
part 'base_entity.mapper.dart';

@MappableClass()
class BaseEntity with BaseEntityMappable {
  final String id;

  const BaseEntity({
    required this.id,
  });

  static const fromMap = BaseEntityMapper.fromMap;
  static const fromJson = BaseEntityMapper.fromJson;
}
