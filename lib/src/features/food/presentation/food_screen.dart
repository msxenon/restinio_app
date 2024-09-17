import 'package:flutter/cupertino.dart';
import 'package:restinio_app/src/core/async_bloc_builder.dart';
import 'package:restinio_app/src/core/navigation/routes.dart';
import 'package:restinio_app/src/features/food/domain/entities/food_entity.dart';
import 'package:restinio_app/src/features/food/presentation/blocs/food_bloc.dart';
import 'package:restinio_app/src/features/food/presentation/widgets/food_tile.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});
  static const _breakingPoint = 300;

  static final _dummyLoadingState = List<FoodEntity>.generate(
    4,
    (index) => FoodEntity(
      id: index.toString(),
      name: 'Loading...',
      description: 'Loading...',
      imageUrl: '',
      price: index.toDouble(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) {
        return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text('Restinio'),
          ),
          child: SafeArea(
            child: Center(
              child: AsyncBlocBuilder<FoodBloc, List<FoodEntity>>(
                (context, snapshot) {
                  return LayoutBuilder(builder: (context, constraints) {
                    final screenWidth = constraints.maxWidth;

                    final crossAxsCount = screenWidth > _breakingPoint
                        ? (screenWidth / _breakingPoint).toInt()
                        : 1;
                    return GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxsCount,
                        mainAxisSpacing: 16.0,
                        mainAxisExtent: 420,
                        crossAxisSpacing: 16.0,
                      ),
                      itemCount: snapshot.length,
                      itemBuilder: (context, index) {
                        final food = snapshot[index];
                        return FoodTile(
                          food,
                          onTap: () =>
                              FoodDetailsRoute(foodId: food.id).push(context),
                        );
                      },
                    );
                  });
                },
                dummyLoadingState: _dummyLoadingState,
              ),
            ),
          ),
        );
      },
    );
  }
}
