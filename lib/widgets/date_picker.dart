import 'package:flutter/material.dart';

class TimePickerWidget extends StatefulWidget {
  final List<TimeOfDay> timeOfDayList;
  final Function setStateCallback;
  const TimePickerWidget(
      {Key? key, required this.timeOfDayList, required this.setStateCallback})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = TimeOfDay.now();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        widget.setStateCallback(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectTime(context),
      borderRadius: BorderRadius.circular(3.0),
      customBorder: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(3),
          side: const BorderSide(
              color: Colors.black, width: 3.0, style: BorderStyle.solid)),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 2.0),
            left: BorderSide(width: 2.0),
            right: BorderSide(width: 2.0),
            bottom: BorderSide(width: 2.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedTime.format(context),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
