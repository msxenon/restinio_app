import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restinio_app/src/core/navigation/app_router.dart';

class SecondTabScreen extends StatefulWidget {
  const SecondTabScreen({super.key});

  @override
  State<SecondTabScreen> createState() => _SecondTabScreenState();
}

class _SecondTabScreenState extends State<SecondTabScreen> {
  DateTime? datetime = DateTime.now();
  final dateTimeFormatter = DateFormat('yyyy MMM dd h:m a');
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(
              child: Text(datetime != null
                  ? 'Tap to change date and time'
                  : 'Tap to select date and time'),
              onPressed: () => unawaited(_showDateTimePicker()),
            ),
            if (datetime != null) Text(dateTimeFormatter.format(datetime!)),
            const SizedBox(height: 20),
            CupertinoButton.filled(
              onPressed: datetime != null
                  ? () => TableReservationRoute(
                          date: datetime!.millisecondsSinceEpoch.toString())
                      .go(context)
                  : null,
              child: const Text('Reserve a table now!'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDateTimePicker() async {
    final initialPickerDateTime = datetime ?? DateTime.now();
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
