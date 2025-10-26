import 'package:flutter/material.dart';
import '../models/trip.dart';
import 'trip_list_screen.dart';

class NewTripScreen extends StatefulWidget {
  final Function(Trip) onTripAdded;

  const NewTripScreen({super.key, required this.onTripAdded});

  @override
  State<NewTripScreen> createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая поездка'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          // Горизонтальная навигация: Отмена создания (возврат с заменой)
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TripListScreen()),
            );
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 2) {
              setState(() {
                _currentStep++;
              });
            } else {
              _saveTrip();
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep--;
              });
            }
          },
          steps: [
            Step(
              title: const Text('Основная информация'),
              content: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Название поездки'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите название';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Описание'),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите описание';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Step(
              title: const Text('Даты'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Выберите даты поездки'),
                  const SizedBox(height: 10),
                  Text('Начало: ${DateTime.now().toString().split(' ')[0]}'),
                  Text('Конец: ${DateTime.now().add(const Duration(days: 7)).toString().split(' ')[0]}'),
                ],
              ),
            ),
            Step(
              title: const Text('Подтверждение'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Проверьте информацию о поездке'),
                  const SizedBox(height: 10),
                  Text('✓ Название: ${_titleController.text}'),
                  Text('✓ Описание: ${_descriptionController.text}'),
                  const Text('✓ Даты выбраны'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveTrip() {
    if (_formKey.currentState!.validate()) {
      final newTrip = Trip(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        date: DateTime.now(),
      );

      widget.onTripAdded(newTrip);

      // Горизонтальная навигация: Возврат на главный экран после сохранения
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TripListScreen()),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}