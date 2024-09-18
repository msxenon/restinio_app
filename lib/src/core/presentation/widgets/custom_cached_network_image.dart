import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:restinio_app/src/core/di/dependencies_container.dart';
import 'package:restinio_app/src/core/services/app_cache_manager.dart';

class FirebaseCachedNetworkImage extends StatelessWidget {
  final String imageUrl;

  const FirebaseCachedNetworkImage(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      cacheManager: DependenciesContainer.get<AppCacheManager>(),
      imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet,
      fit: BoxFit.cover,
    );
  }
}
