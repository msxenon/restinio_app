import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restinio_app/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:restinio_app/src/features/authentication/presentation/blocs/authentication_cubit.dart';
import 'package:restinio_app/src/features/table_reservation/data/models/table_model.dart';
import 'package:restinio_app/src/features/table_reservation/domain/repositories/reservation_repository.dart';
import 'package:restinio_app/src/features/table_reservation/domain/repositories/table_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart';

class TableDetailsCubit extends Cubit<AsyncState<TableModel?>> {
  final TableRepository _tableRepository;
  final ReservationRepository _reservationRepository;
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription? _subscription;
  final DateTime _selectedDateTime;
  final String tableId;
  TableDetailsCubit(
    this._tableRepository,
    this._reservationRepository,
    this._authenticationRepository,
    this._selectedDateTime,
    this.tableId,
  ) : super(const AsyncStateLoading()) {
    _init();
  }

  Future<void> _init() async {
    try {
      _subscription = CombineLatestStream.combine2(
          _tableRepository.stream(tableId),
          _reservationRepository.streamAll(_selectedDateTime, tableId: tableId),
          (value1, value2) => (value1, value2)).listen((event) {
        final table = event.$1;
        if (table == null) {
          emit(const AsyncStateData(null));
          return;
        }

        emit(
          AsyncStateData(
            TableModel.fromEntity(
              table,
              event.$2.firstWhereOrNull(
                (element) => element.tableId == table.id,
              ),
              _authenticationRepository.userId!,
            ),
          ),
        );
      });
    } catch (e) {
      emit(AsyncStateFailure(e.toString()));
    }
  }

  @override
  Future<void> close() async {
    _subscription?.cancel();
    _subscription = null;
    return super.close();
  }

  Future<void> reserveTable(String bookedName) async {
    try {
      emit(const AsyncStateLoading());
      await _reservationRepository.reserveTable(
        tableId: tableId,
        userId: _authenticationRepository.userId!,
        bookedName: bookedName,
        selectedDateTime: _selectedDateTime,
      );
    } catch (e) {
      emit(AsyncStateFailure(e.toString()));
    }
  }

  void cancelReservation(String tableId) {
    try {
      emit(const AsyncStateLoading());
      _reservationRepository.cancelReservation(tableId: tableId, userId: _authenticationRepository.userId!);
    } catch (e) {
      emit(AsyncStateFailure(e.toString()));
    }
  }
}
