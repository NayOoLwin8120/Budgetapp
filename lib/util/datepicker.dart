import "package:flutter/material.dart";

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({
    required this.selectedDate,
    required this.onDateChanged,
    required this.datetext,
    required this.yearonly,
    super.key,
  });
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;
  final String datetext;
  final bool yearonly;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await _selectDate(context);
      },
      child: Text(datetext),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime initialDate =
        yearonly ? DateTime(DateTime.now().year) : selectedDate;

    DateTime? picked;
    DateTime? pickedYear;

    if (yearonly) {
      // If yearOnly is true, directly use the initialDate without showing the picker
      final DateTime initialDate = selectedDate;

      pickedYear = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDatePickerMode: DatePickerMode.year,
      );

      if (pickedYear != null && pickedYear.year != selectedDate.year) {
        // Only change the year, keep the month and day the same
        final DateTime newDate =
            DateTime(pickedYear.year, selectedDate.month, selectedDate.day);
        onDateChanged(newDate);
      }
    } else {
      // Show the date picker with the selected initialDate
      picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
      );
    }

    if (picked != null && picked != selectedDate) {
      onDateChanged(picked);
    }
  }
}
