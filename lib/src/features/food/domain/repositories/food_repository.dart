import 'package:restinio_app/src/core/di/dependencies_container.dart';
import 'package:restinio_app/src/features/food/domain/entities/food_entity.dart';

abstract class FoodRepository {
  static FoodRepository get instance => DependenciesContainer.get<FoodRepository>();
  Future<List<FoodEntity>> getFoods();
}
