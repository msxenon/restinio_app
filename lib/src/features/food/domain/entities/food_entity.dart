import 'package:dart_mappable/dart_mappable.dart';
part 'food_entity.mapper.dart';

@MappableClass()
class FoodEntity with FoodEntityMappable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const FoodEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  static const fromMap = FoodEntityMapper.fromMap;
  static const fromJson = FoodEntityMapper.fromJson;
}
