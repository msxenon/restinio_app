import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:restinio_app/src/core/di/dependencies_container.dart';

class FirebaseHttpFileService extends HttpFileService {
  static FirebaseHttpFileService get instance =>
      DependenciesContainer.get<FirebaseHttpFileService>();
  final FirebaseStorage _firebaseStorage;
  FirebaseHttpFileService(this._firebaseStorage) : super();

  @override
  Future<FileServiceResponse> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    final ref = _firebaseStorage.refFromURL(url);
    String downloadURL = await ref.getDownloadURL();
    return super.get(downloadURL);
  }
}
