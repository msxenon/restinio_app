import 'package:restinio_app/src/features/table_reservation/data/data_sources/reservation_data_source.dart';
import 'package:restinio_app/src/features/table_reservation/domain/entities/reservation_entity.dart';
import 'package:restinio_app/src/features/table_reservation/domain/repositories/reservation_repository.dart';

class ReservationRepositoryImpl extends ReservationRepository {
  final ReservationDataSource _dataSource;
  ReservationRepositoryImpl(this._dataSource);

  @override
  Stream<List<ReservationEntity>> streamAll(DateTime selectedDateTime,
      {String? tableId}) {
    return _dataSource.streamAll(selectedDateTime, tableId: tableId);
  }

  @override
  Future<void> reserveTable({
    required String tableId,
    required String userId,
    required String bookedName,
    required DateTime selectedDateTime,
  }) {
    return _dataSource.reserveTable(
      tableId: tableId,
      userId: userId,
      bookedName: bookedName,
      selectedDateTime: selectedDateTime,
    );
  }

  @override
  Future<void> cancelReservation({
    required String userId,
    required String tableId,
  }) {
    return _dataSource.cancelReservation(
      tableId: tableId,
      userId: userId,
    );
  }
}
