import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restinio_app/src/core/constants.dart';
import 'package:restinio_app/src/features/table_reservation/domain/entities/reservation_entity.dart';

class ReservationDataSource {
  final CollectionReference<Map<String, dynamic>> _collection;

  ReservationDataSource(FirebaseFirestore firestore)
      : _collection = firestore.collection('reservations_collection');


  final _createdAtKey =
      ReservationEntityMapper.ensureInitialized().fields[#createdAt]!.key;
  final _tableIdKey =
      ReservationEntityMapper.ensureInitialized().fields[#tableId]!.key;
  final _createdByKey =
      ReservationEntityMapper.ensureInitialized().fields[#createdBy]!.key;

  Query<Map<String, dynamic>> _selectiveTimeslotQuery(
    DateTime selectedDateTime, {
    String? tableId,
  }) {
    final startDateTime = selectedDateTime.subtract(AppConstants.totalReservationDuration);
    final endDateTime = selectedDateTime.add(AppConstants.totalReservationDuration);
    final query = _collection.where(
      _createdAtKey,
      isGreaterThanOrEqualTo: Timestamp.fromDate(startDateTime),
      isLessThan: Timestamp.fromDate(endDateTime),
    );
    if (tableId != null) {
      return query.where(_tableIdKey, isEqualTo: tableId);
    }

    return query;
  }

  Stream<List<ReservationEntity>> streamAll(
    DateTime selectedDateTime, {
    String? tableId,
  }) {
    return _selectiveTimeslotQuery(selectedDateTime, tableId: tableId)
        .snapshots()
        .transform(
      StreamTransformer.fromHandlers(
        handleData: (QuerySnapshot<Map<String, dynamic>> snapshot, sink) {
          final tables = snapshot.docs.map((doc) {
            return ReservationEntity.fromMap(doc.data());
          }).toList();
          sink.add(tables);
        },
      ),
    );
  }

  Future<void> reserveTable({
    required String tableId,
    required String userId,
    required String bookedName,
    required DateTime selectedDateTime,
  }) async {
    String docId = _collection.doc().id;

    final entity = ReservationEntity(
      tableId: tableId,
      id: docId,
      createdBy: userId,
      bookedName: bookedName,
      createdAt: selectedDateTime,
    );
    await _collection.doc(docId).set(entity.toMap());
  }

  Future<void> cancelReservation({
    required String userId,
    required String tableId,
  }) async {
    final docsToDelete = await _collection
        .where(_tableIdKey, isEqualTo: tableId)
        .where(_createdByKey, isEqualTo: userId)
        .get();
    for (final doc in docsToDelete.docs) {
      await doc.reference.delete();
    }
  }
}
