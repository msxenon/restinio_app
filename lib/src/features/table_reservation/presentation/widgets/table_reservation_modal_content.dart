import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restinio_app/src/core/async_bloc_builder.dart';
import 'package:restinio_app/src/core/navigation/app_router.dart';
import 'package:restinio_app/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:restinio_app/src/features/table_reservation/data/models/table_model.dart';
import 'package:restinio_app/src/features/table_reservation/domain/repositories/reservation_repository.dart';
import 'package:restinio_app/src/features/table_reservation/domain/repositories/table_repository.dart';
import 'package:restinio_app/src/features/table_reservation/presentation/blocs/table_details_cubit.dart';

class TableReservationModalContent extends StatefulWidget {
  const TableReservationModalContent({
    super.key,
    required this.date,
    required this.tableId,
  });
  final String tableId;
  final int date;

  @override
  State<TableReservationModalContent> createState() =>
      _TableReservationModalContentState();
}

class _TableReservationModalContentState
    extends State<TableReservationModalContent> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TableDetailsCubit(
          TableRepository.instance,
          ReservationRepository.instance,
          AuthenticationRepository.instance,
          DateTime.fromMillisecondsSinceEpoch(widget.date),
          widget.tableId,
        );
      },
      child: AsyncBlocBuilder<TableDetailsCubit, TableModel?>(
        (context, model) {
          if (model == null) {
            return const Center(child: Text('No data'));
          }

          if (model.status.isReserved) {
            return const Center(child: Text('Table is reserved'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your name',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                CupertinoButton.filled(
                  child: const Text('Book'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      unawaited(_reserveTable(context, model));
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _reserveTable(BuildContext context, TableModel model) async {
    final isReserved = await context.read<TableDetailsCubit>().reserveTable(
          _nameController.text,
        );
    if (context.mounted && isReserved) {
      AppRouter.instance
        ..pop()
        ..showDelayedInfoDialog(
          'Table is reserved for ${_nameController.text}',
        );
    }
  }
}
