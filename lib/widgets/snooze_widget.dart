import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cathnow/utils/notification_module.dart';

class SnoozeWidget extends StatefulWidget {
  const SnoozeWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SnoozeWidgetState createState() => _SnoozeWidgetState();
}

class _SnoozeWidgetState extends State<SnoozeWidget> {
  String _selectedValue = '15';
  // ignore: prefer_final_fields
  TextEditingController _otherController = TextEditingController();

  @override
  void dispose() {
    _otherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final NotificationModule notificationModule = NotificationModule();

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          //color: Colors.black,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Snooze Altert:',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          DropdownButton<String>(
            value: _selectedValue,
            onChanged: (String? newValue) {
              setState(() {
                _selectedValue = newValue!;
              });
            },
            items: <String>['15', '30', '45', '60']
                .map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text('$value minutes'),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20.0),
          const Text('Other:'),
          const SizedBox(height: 10.0),
          TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter a custom duration (less than 120)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (int.tryParse(value) != null) {
                  int parsedValue = int.parse(value);
                  if (parsedValue > 120) {
                    controller.text = '120';
                  }
                } else {
                  controller.text = '';
                }
              }),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              String selectedDuration = _selectedValue == 'Other'
                  ? _otherController.text
                  : _selectedValue;
              int number = int.parse(selectedDuration);
              notificationModule.snoozeNotification(number);
            },
            child: const Text('Snooze'),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              exit(0);
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}
