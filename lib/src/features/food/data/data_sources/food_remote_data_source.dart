import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restinio_app/src/features/food/domain/entities/food_entity.dart';

class FoodRemoteDataSource {
  final CollectionReference<Map<String, dynamic>> _foodCollection;

  FoodRemoteDataSource(FirebaseFirestore firestore)
      : _foodCollection = firestore.collection('food_collection');

  Future<List<FoodEntity>> getAll() async {
    final snapshot = await _foodCollection.get();
    return snapshot.docs.map((doc) {
      return FoodEntity.fromMap(doc.data());
    }).toList();
  }

  Future<FoodEntity?> get(String foodId) async {
    final doc = await _foodCollection.doc(foodId).get();
    if (doc.exists) {
      return FoodEntity.fromMap(doc.data()!);
    }
    return null;
  }
}
