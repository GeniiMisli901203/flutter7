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
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая поездка'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TripListScreen()),
              );
            },
          ),
        ],
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep == 0) {
            if (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
              setState(() {
                _currentStep++;
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Заполните все поля')),
              );
            }
          } else if (_currentStep == 1) {
            setState(() {
              _currentStep++;
            });
          } else if (_currentStep == 2) {
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
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                if (_currentStep != 0)
                  ElevatedButton(
                    onPressed: details.onStepCancel,
                    child: const Text('Назад'),
                  ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text(_currentStep == 2 ? 'Сохранить' : 'Продолжить'),
                ),
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('Основная информация'),
            content: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Название поездки',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Описание',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
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
                const Text('Проверьте информацию о поездке:'),
                const SizedBox(height: 10),
                Text('✓ Название: ${_titleController.text}'),
                Text('✓ Описание: ${_descriptionController.text}'),
                Text('✓ Начало: ${DateTime.now().toString().split(' ')[0]}'),
                Text('✓ Конец: ${DateTime.now().add(const Duration(days: 7)).toString().split(' ')[0]}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _saveTrip() {
    if (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
      final newTrip = Trip(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        date: DateTime.now(),
      );

      // Создаем новый экран со списком с добавленной поездкой
      final newListScreen = widget.onTripAdded(newTrip);

      // Горизонтальная навигация на новый экран
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => newListScreen),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Поездка "${_titleController.text}" добавлена!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Заполните все поля')),
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