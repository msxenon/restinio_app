import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restinio_app/src/features/table_reservation/domain/entities/table_entity.dart';

class TableDataSource {
  final CollectionReference<Map<String, dynamic>> _collection;

  TableDataSource(FirebaseFirestore firestore)
      : _collection = firestore.collection('tables');

  Stream<List<TableEntity>> getFoods() {
    return _collection.snapshots().transform(
      StreamTransformer.fromHandlers(
        handleData: (QuerySnapshot<Map<String, dynamic>> snapshot, sink) {
          final tables = snapshot.docs.map((doc) {
            return TableEntity.fromMap(doc.data());
          }).toList();
          sink.add(tables);
        },
      ),
    );
  }
}
