import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restinio_app/src/core/async_bloc_builder.dart';
import 'package:restinio_app/src/core/constants/app_colors.dart';
import 'package:restinio_app/src/core/presentation/widgets/custom_cached_network_image.dart';
import 'package:restinio_app/src/features/food/domain/entities/food_entity.dart';
import 'package:restinio_app/src/features/food/domain/repositories/food_repository.dart';
import 'package:restinio_app/src/features/food/presentation/blocs/food_details_bloc.dart';
import 'package:restinio_app/src/features/food/presentation/widgets/food_property_tile.dart';
import 'package:restinio_app/src/features/food/presentation/widgets/price_widget.dart';

class FoodDetailsScreen extends StatelessWidget {
  final String foodId;

  const FoodDetailsScreen(this.foodId, {super.key});
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.secondarySurface,
      child: BlocProvider<FoodDetailsBloc>(
        create: (context) => FoodDetailsBloc(foodId, FoodRepository.instance),
        child: AsyncBlocBuilder<FoodDetailsBloc, FoodEntity?>(
          (context, state) {
            if (state == null) {
              return const Center(child: Text('Item not found'));
            }
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  elevation: 0,
                  expandedHeight: 360,
                  floating: false,
                  pinned: false,
                  snap: false,
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    stretchModes: const [StretchMode.zoomBackground],
                    background: FirebaseCachedNetworkImage(state.imageUrl),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Text(
                          state.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        PriceWidget(state.price),
                        const SizedBox(height: 8),
                        Text(
                          state.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: FoodPropertyTile(
                                    iconDate: FontAwesomeIcons.wheatAwn,
                                    unit: state.carbsUnitValue,
                                    value: state.carbs,
                                  ),
                                ),
                                Expanded(
                                  child: FoodPropertyTile(
                                    iconDate: FontAwesomeIcons.dna,
                                    unit: state.proteinsUnitValue,
                                    value: state.proteins,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: FoodPropertyTile(
                                    iconDate: FontAwesomeIcons.fire,
                                    unit: state.kcalUnitValue,
                                    value: state.kcal,
                                  ),
                                ),
                                Expanded(
                                  child: FoodPropertyTile(
                                    iconDate: FontAwesomeIcons.pizzaSlice,
                                    unit: state.fatsUnitValue,
                                    value: state.fats,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(height: 32),
                        const Text(
                          'Ingredients',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc bibendum mauris sodales neque pellentesque tincidunt. Etiam dictum nisl nisi, in vehicula nunc rutrum vel. Sed venenatis ut nibh et porta. Suspendisse potenti. Pellentesque elementum leo id est ornare mattis. Donec dignissim id sem eget sollicitudin. Ut dignissim mauris ac hendrerit ullamcorper. Nulla rhoncus a metus vitae hendrerit. Sed tincidunt arcu ipsum, nec ultrices ligula aliquet ac. Curabitur imperdiet lorem dolor, ac tincidunt quam sodales sit amet.',
                          style: TextStyle(
                            fontSize: 16,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
