import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restinio_app/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:restinio_app/src/features/authentication/presentation/blocs/authentication_cubit.dart';
import 'package:restinio_app/src/features/table_reservation/data/models/table_model.dart';
import 'package:restinio_app/src/features/table_reservation/domain/entities/reservation_entity.dart';
import 'package:restinio_app/src/features/table_reservation/domain/entities/table_entity.dart';
import 'package:restinio_app/src/features/table_reservation/domain/repositories/reservation_repository.dart';
import 'package:restinio_app/src/features/table_reservation/domain/repositories/table_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart';

class TablesCubit extends Cubit<AsyncState<List<TableModel>>> {
  final TableRepository _tableRepository;
  final ReservationRepository _reservationRepository;
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription? _subscription;
  final DateTime _selectedDateTime;
  TablesCubit(
    this._tableRepository,
    this._reservationRepository,
    this._authenticationRepository,
    this._selectedDateTime,
  ) : super(const AsyncStateLoading()) {
    _init();
  }

  Future<void> _init() async {
    try {
      _subscription = CombineLatestStream.combine2(
          _tableRepository.streamAll(),
          _reservationRepository.streamAll(_selectedDateTime),
          (value1, value2) => (value1, value2)).listen((event) {
        final tables = event.$1;
        final reservations = event.$2;
        final tablesMap = <TableEntity, ReservationEntity?>{};
        for (final table in tables) {
          tablesMap[table] = reservations.firstWhereOrNull(
            (element) => element.tableId == table.id,
          );
        }
        final models = tablesMap.entries
            .map(
              (e) => TableModel.fromEntity(
                e.key,
                e.value,
                _authenticationRepository.userId!,
              ),
            )
            .toList();

        emit(AsyncStateData(models));
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
}
