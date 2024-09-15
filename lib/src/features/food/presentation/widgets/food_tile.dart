import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:restinio_app/src/core/di/dependencies_container.dart';
import 'package:restinio_app/src/core/services/app_cache_manager.dart';
import 'package:restinio_app/src/features/food/domain/entities/food_entity.dart';
import 'package:restinio_app/src/features/food/presentation/widgets/price_widget.dart';

class FoodTile extends StatelessWidget {
  final FoodEntity food;

  const FoodTile(this.food, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.all(1),
              constraints:
                  BoxConstraints.expand(height: constraints.maxHeight * 0.85),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xffF3F2F3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: food.imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: food.imageUrl,
                      cacheManager: DependenciesContainer.get<AppCacheManager>(),
                      imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet,
                    )
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      PriceWidget(food.price),
                    ],
                  ),
                  const CupertinoListTileChevron()
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
