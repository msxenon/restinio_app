import 'package:restinio_app/src/core/di/dependencies_container.dart';
import 'package:restinio_app/src/features/table_reservation/domain/entities/reservation_entity.dart';

abstract class ReservationRepository {
  static ReservationRepository get instance =>
      DependenciesContainer.get<ReservationRepository>();
  Stream<List<ReservationEntity>> streamAll(
    DateTime selectedDateTime, {
    String? tableId,
  });

  Future<void> reserveTable({
    required String tableId,
    required String userId,
    required String bookedName,
    required DateTime selectedDateTime,
  });

  Future<void> cancelReservation({
    required String userId,
    required String tableId,
  });
}
