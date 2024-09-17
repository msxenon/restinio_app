import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restinio_app/src/core/constants/constants.dart';
import 'package:restinio_app/src/core/navigation/routes.dart';
import 'package:restinio_app/src/core/utilities/extensions/date_time_extensions.dart';

class TableReservationScreenStep1 extends StatefulWidget {
  const TableReservationScreenStep1({super.key});

  @override
  State<TableReservationScreenStep1> createState() =>
      _TableReservationScreenStep1();
}

class _TableReservationScreenStep1 extends State<TableReservationScreenStep1> {
  DateTime datetime = DateTime.now()
      .toTheClosestHourAfter(AppConstants.totalReservationDuration);
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(
              child: const Text('Tap to change date and time'),
              onPressed: () => unawaited(_showDateTimePicker()),
            ),
            Text(datetime.toHumanReadable()),
            const SizedBox(height: 20),
            CupertinoButton.filled(
              onPressed: () => TableReservationStep2Route(
                      date: datetime.millisecondsSinceEpoch.toString())
                  .push(context),
              child: const Text('Reserve'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDateTimePicker() async {
    final initialPickerDateTime = datetime;
    final newPickedDate = await showDatePicker(
      context: context,
      initialDate: datetime,
      firstDate: initialPickerDateTime,
      lastDate: initialPickerDateTime.add(const Duration(days: 30)),
    );
    if (!mounted || newPickedDate == null) return;
    final newPickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialPickerDateTime),
    );

    if (mounted && newPickedTime != null) {
      setState(() {
        datetime = DateTime(
          newPickedDate.year,
          newPickedDate.month,
          newPickedDate.day,
          newPickedTime.hour,
          newPickedTime.minute,
        );
      });
    }
  }
}
