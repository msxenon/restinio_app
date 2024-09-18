import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restinio_app/src/core/async_bloc_builder.dart';
import 'package:restinio_app/src/core/navigation/routes.dart';
import 'package:restinio_app/src/features/food/domain/entities/food_entity.dart';
import 'package:restinio_app/src/features/food/presentation/blocs/food_screen_bloc.dart';
import 'package:restinio_app/src/features/food/presentation/widgets/food_tile.dart';

class FoodScreen extends StatefulWidget {
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
      proteins: index,
      kcal: index,
      fats: index,
      carbs: index,
    ),
  );

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      context.read<FoodScreenBloc>().search(textController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) {
        return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text('Restinio'),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CupertinoSearchTextField(
                    controller: textController,
                    placeholder: 'Search',
                    onSuffixTap: () => context.read<FoodScreenBloc>().onClearSearchTapped(),
                  ),
                ),
                Expanded(
                  child: AsyncBlocBuilder<FoodScreenBloc, List<FoodEntity>>(
                    (context, snapshot) {
                      return LayoutBuilder(builder: (context, constraints) {
                        final screenWidth = constraints.maxWidth;

                        final crossAxsCount = screenWidth >
                                FoodScreen._breakingPoint
                            ? (screenWidth / FoodScreen._breakingPoint).toInt()
                            : 1;
                        return GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxsCount,
                            mainAxisSpacing: 16.0,
                            mainAxisExtent: 300,
                            crossAxisSpacing: 16.0,
                          ),
                          itemCount: snapshot.length,
                          itemBuilder: (context, index) {
                            final food = snapshot[index];
                            return FoodTile(
                              food,
                              onTap: () => FoodDetailsRoute(foodId: food.id)
                                  .push(context),
                            );
                          },
                        );
                      });
                    },
                    dummyLoadingState: FoodScreen._dummyLoadingState,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
