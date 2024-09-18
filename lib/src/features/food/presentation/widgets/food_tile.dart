import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:restinio_app/src/core/constants/app_colors.dart';
import 'package:restinio_app/src/core/constants/constants.dart';
import 'package:restinio_app/src/core/di/dependencies_container.dart';
import 'package:restinio_app/src/core/presentation/widgets/custom_button.dart';
import 'package:restinio_app/src/core/services/app_cache_manager.dart';
import 'package:restinio_app/src/features/food/domain/entities/food_entity.dart';
import 'package:restinio_app/src/features/food/presentation/widgets/kcal_widget.dart';
import 'package:restinio_app/src/features/food/presentation/widgets/price_widget.dart';

class FoodTile extends StatelessWidget {
  final FoodEntity food;
  final VoidCallback onTap;
  const FoodTile(this.food, {required this.onTap, super.key});
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.radius),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.secondarySurface.withOpacity(0.4),
              AppColors.secondarySurface,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 8).copyWith(top: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConstants.radius),
                  color: AppColors.primarySurface,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  image: food.imageUrl.isNotEmpty
                      ? DecorationImage(
                          image: CachedNetworkImageProvider(
                            food.imageUrl,
                            cacheManager:
                                DependenciesContainer.get<AppCacheManager>(),
                            imageRenderMethodForWeb:
                                ImageRenderMethodForWeb.HttpGet,
                          ),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
            ),
            Flexible(
              flex: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8)
                        .copyWith(top: 16),
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
                        KcalWidget(food.kcal),
                        const SizedBox(height: 4),
                        PriceWidget(food.price),
                      ],
                    ),
                    const CupertinoListTileChevron()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
