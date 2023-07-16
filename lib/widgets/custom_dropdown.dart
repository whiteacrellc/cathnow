import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyDropdownList extends StatefulWidget {
  MyDropdownList({super.key, required this.setStateCallback});
  int _selectedValue = 1;
  int get selectedValue => _selectedValue;
  final Function setStateCallback;

  @override
  MyDropdownListState createState() => MyDropdownListState();
}

class MyDropdownListState extends State<MyDropdownList> {
  int _selectedValue = 4;
  final List<int> _dropdownValues = [1, 2, 3, 4, 5, 6, 7, 8];

  int get selectedValue => _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
        /*
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(13),
          //color: Colors.white,
        ),
        */
        padding: const EdgeInsets.all(16.0),
        child: DropdownButton<int>(
            value: _selectedValue,
            items: _dropdownValues.map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(
                  '$value',
                ),
              );
            }).toList(),
            onChanged: _onChanged));
  }

  void _onChanged(int? newValue) {
    setState(() {
      _selectedValue = newValue!;
      widget._selectedValue = _selectedValue;
      widget.setStateCallback(_selectedValue);
    });
  }
}
