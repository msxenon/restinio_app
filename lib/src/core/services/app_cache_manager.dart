import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:restinio_app/src/core/di/dependencies_container.dart';
import 'package:restinio_app/src/core/services/firebase_http_file_service.dart';

class AppCacheManager extends CacheManager {
  static AppCacheManager get instance =>
      DependenciesContainer.get<AppCacheManager>();
  AppCacheManager(FirebaseHttpFileService fileService)
      : super(
          Config(
            'restinio_cache',
            fileService: fileService,
          ),
        );
}
