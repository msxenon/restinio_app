import 'package:dart_mappable/dart_mappable.dart';
import 'package:restinio_app/src/core/domain/entities/base_entity.dart';
part 'food_entity.mapper.dart';

@MappableClass()
class FoodEntity extends BaseEntity with FoodEntityMappable {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int proteins;
  final int kcal;
  final int fats;
  final int carbs;

  const FoodEntity({
    required super.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.proteins,
    required this.kcal,
    required this.fats,
    required this.carbs,
  });

  static const fromMap = FoodEntityMapper.fromMap;
}

extension FoodEntityX on FoodEntity {
  String get fatsUnitValue => 'g fats';
  String get proteinsUnitValue => 'g proteins';
  String get carbsUnitValue => 'g carbs';
  String get kcalUnitValue => ' kcal';
}
