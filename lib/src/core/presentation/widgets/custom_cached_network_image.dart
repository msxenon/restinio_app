import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:restinio_app/src/core/constants/app_colors.dart';
import 'package:restinio_app/src/core/di/dependencies_container.dart';
import 'package:restinio_app/src/core/services/app_cache_manager.dart';

class FirebaseCachedNetworkImage extends StatelessWidget {
  final String imageUrl;

  const FirebaseCachedNetworkImage(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final imageProvider = CachedNetworkImageProvider(
      imageUrl,
      cacheManager: DependenciesContainer.get<AppCacheManager>(),
      imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet,
    );
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Image(
            image: imageProvider,
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
            color: AppColors.onSurface.withOpacity(0.7),
          ),
        ),
        Image(
          image: imageProvider,
        ),
      ],
    );
  }
}
