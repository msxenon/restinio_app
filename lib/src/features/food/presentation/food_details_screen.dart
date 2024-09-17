import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restinio_app/src/core/async_bloc_builder.dart';
import 'package:restinio_app/src/features/food/domain/entities/food_entity.dart';
import 'package:restinio_app/src/features/food/domain/repositories/food_repository.dart';
import 'package:restinio_app/src/features/food/presentation/blocs/food_details_bloc.dart';

class FoodDetailsScreen extends StatelessWidget {
  final String foodId;

  const FoodDetailsScreen(this.foodId, {super.key});
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Food Details'),
      ),
      child: BlocProvider<FoodDetailsBloc>(
        create: (context) => FoodDetailsBloc(foodId, FoodRepository.instance),
        child: AsyncBlocBuilder<FoodDetailsBloc, FoodEntity?>(
          (context, state) {
            return Container();
          },
        ),
      ),
    );
  }
}
