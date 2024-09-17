import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:restinio_app/src/core/di/dependencies_container.dart';
import 'package:restinio_app/src/core/presentation/widgets/custom_button.dart';
import 'package:restinio_app/src/core/services/app_cache_manager.dart';
import 'package:restinio_app/src/features/food/domain/entities/food_entity.dart';
import 'package:restinio_app/src/features/food/presentation/widgets/price_widget.dart';

class FoodTile extends StatelessWidget {
  final FoodEntity food;
  final VoidCallback onTap;
  const FoodTile(this.food, {required this.onTap, super.key});
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: onTap,
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: food.imageUrl.isEmpty ? const Color(0xffF3F2F3) : null,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
            image: food.imageUrl.isNotEmpty
                ? DecorationImage(
                    image: CachedNetworkImageProvider(
                      food.imageUrl,
                      cacheManager:
                          DependenciesContainer.get<AppCacheManager>(),
                      imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet,
                    ),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: Container(
            margin: EdgeInsets.only(top: constraints.maxHeight * 0.80),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ClipRect(
              clipBehavior: Clip.antiAlias,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
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
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
