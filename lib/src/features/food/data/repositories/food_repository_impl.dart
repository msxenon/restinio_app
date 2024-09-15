import 'package:restinio_app/src/features/food/data/data_sources/food_remote_data_source.dart';
import 'package:restinio_app/src/features/food/domain/entities/food_entity.dart';
import 'package:restinio_app/src/features/food/domain/repositories/food_repository.dart';

class FoodRepositoryImpl extends FoodRepository {
  final FoodRemoteDataSource _foodRemoteDataSource;

  FoodRepositoryImpl(this._foodRemoteDataSource);
  @override
  Future<List<FoodEntity>> getFoods() {
    return _foodRemoteDataSource.getFoods();
  }
}
