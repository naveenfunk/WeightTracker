import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weighttracker/exceptions/exceptions.dart';
import 'package:weighttracker/providers/weight.dart';
import 'package:weighttracker/utils.dart';
import 'package:provider/provider.dart';

class AddWeightRoute extends StatefulWidget {
  const AddWeightRoute({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddWeightRouteState();
  }
}

class AddWeightRouteState extends State<AddWeightRoute> {
  final _weightController = TextEditingController();
  DateTime? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _weightController,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9.]"))],
                style: const TextStyle(fontSize: 55, color: Colors.black),
                maxLength: 20,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "Enter Weight (Kg)", hintStyle: TextStyle(fontSize: 35, color: Colors.grey)),
              ),
              DateTimePicker(onTimeUpdated: (updatedTime) => _selectedTime = updatedTime),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _saveData,
          tooltip: 'Navigate to next screen',
          child: const Icon(Icons.check),
        ),
      ),
    );
  }

  _saveData() {
    try {
      final weight = double.parse(_weightController.value.text);

      if (weight <= 0) {
        throw InvalidWeightException();
      }
      if (_selectedTime == null) {
        throw InvalidTimeException();
      }
      Provider.of<WeightProvider>(context, listen: false).addWeight(weight, _selectedTime!);
      goBack();
    } on AppExceptions catch (e) {
      showError(e.toString());
    } on Exception catch (e) {
      showError("Invalid Weight entered");
    }
  }

  void showError(String string) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(string)));
  }

  void goBack() {
    Navigator.pop(context);
  }
}

// Date time picker widget
class DateTimePicker extends StatefulWidget {
  final Function(DateTime updatedTime) onTimeUpdated;

  const DateTimePicker({Key? key, required this.onTimeUpdated}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DateTimePickerState();
  }
}

class DateTimePickerState extends State<DateTimePicker> {
  DateTime? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue),
        child: Text(
          _selectedTime != null ? Utils.getFormattedDate(_selectedTime!) : "Select Time",
          style: const TextStyle(fontSize: 15, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      onTap: () => {_selectTime()},
    );
  }

  Future<void> _selectTime() async {
    DateTime currentTime = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
        context: context, initialDate: currentTime, firstDate: currentTime.subtract(const Duration(days: 365 * 10)), lastDate: currentTime);

    if (selectedDate != null) {
      final TimeOfDay? selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(currentTime));
      if (selectedTime != null) {
        _updateSelectedTime(DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour, selectedTime.minute));
      }
    }
  }

  void _updateSelectedTime(DateTime dateTime) {
    setState(() {
      _selectedTime = dateTime;
      widget.onTimeUpdated(dateTime);
    });
  }
}
