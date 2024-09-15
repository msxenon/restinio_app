import 'package:dart_mappable/dart_mappable.dart';
import 'package:restinio_app/src/core/domain/entities/base_entity.dart';
part 'food_entity.mapper.dart';

@MappableClass()
class FoodEntity extends BaseEntity with FoodEntityMappable {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const FoodEntity({
    required super.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  static const fromMap = FoodEntityMapper.fromMap;
  static const fromJson = FoodEntityMapper.fromJson;
}
