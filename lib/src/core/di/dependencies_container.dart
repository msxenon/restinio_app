import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:restinio_app/firebase_options.dart';
import 'package:restinio_app/src/core/navigation/app_router.dart';
import 'package:restinio_app/src/core/services/app_cache_manager.dart';
import 'package:restinio_app/src/core/services/firebase_http_file_service.dart';
import 'package:restinio_app/src/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:restinio_app/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:restinio_app/src/features/food/data/data_sources/food_remote_data_source.dart';
import 'package:restinio_app/src/features/food/data/repositories/food_repository_impl.dart';
import 'package:restinio_app/src/features/food/domain/repositories/food_repository.dart';

class DependenciesContainer {
  static final _injector = GetIt.instance;

  DependenciesContainer._();

  static T get<T extends Object>() {
    return _injector.get<T>();
  }

  static void _registerSingleton<T extends Object>(T instanceObject) {
    _injector.registerSingleton<T>(instanceObject);
  }

  static void _registerFactory<T extends Object>(FactoryFunc<T> factory) {
    _injector.registerLazySingleton<T>(factory);
  }

  static Future<void> init() async {
    final firebaseApp = await _initFirebaseApp();
    final firebaseAuth = FirebaseAuth.instanceFor(app: firebaseApp);
    final fireStore = FirebaseFirestore.instanceFor(app: firebaseApp);
    final firebaseStorage = FirebaseStorage.instanceFor(app: firebaseApp);
    _registerSingleton<AuthenticationRepository>(
      AuthenticationRepositoryImpl(firebaseAuth),
    );
    _registerSingleton<AppRouter>(
      AppRouter(),
    );
    _registerFactory<FirebaseHttpFileService>(
      () => FirebaseHttpFileService(firebaseStorage),
    );
    _registerFactory<AppCacheManager>(
      () => AppCacheManager(get<FirebaseHttpFileService>()),
    );
    _registerFactory<FoodRemoteDataSource>(
      () => FoodRemoteDataSource(fireStore),
    );
    _registerFactory<FoodRepository>(
      () => FoodRepositoryImpl(
        get<FoodRemoteDataSource>(),
      ),
    );
  }

  static Future<FirebaseApp> _initFirebaseApp() async {
    final options = DefaultFirebaseOptions.currentPlatform;
    return Firebase.initializeApp(options: options, name: 'restinio_app');
  }
}
