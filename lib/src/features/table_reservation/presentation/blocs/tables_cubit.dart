import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restinio_app/src/features/authentication/presentation/blocs/authentication_cubit.dart';
import 'package:restinio_app/src/features/table_reservation/domain/entities/table_entity.dart';
import 'package:restinio_app/src/features/table_reservation/domain/repositories/table_repository.dart';

class TablesCubit extends Cubit<AsyncState<List<TableEntity>>> {
  final TableRepository _tableRepository;

  TablesCubit(this._tableRepository) : super(const AsyncStateLoading()) {
    _init();
  }

  Future<void> _init() async {
    try {
      _tableRepository.streamAll().listen((tables) {
        emit(AsyncStateData(tables));
      });
    } catch (e) {
      emit(AsyncStateFailure(e.toString()));
    }
  }
}
