import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restinio_app/src/features/table_reservation/domain/entities/table_entity.dart';

class TableDataSource {
  final CollectionReference<Map<String, dynamic>> _collection;

  TableDataSource(FirebaseFirestore firestore)
      : _collection = firestore.collection('tables');

  Stream<List<TableEntity>> streamAll() {
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

  Stream<TableEntity?> stream(String tableId) {
    return _collection.doc(tableId).snapshots().transform(
      StreamTransformer.fromHandlers(
        handleData: (DocumentSnapshot<Map<String, dynamic>> snapshot, sink) {
          final data = snapshot.data();
          sink.add(data != null ? TableEntity.fromMap(data) : null);
        },
      ),
    );
  }
}
