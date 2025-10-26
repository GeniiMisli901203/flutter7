import 'package:flutter/material.dart';
import '../models/map_point.dart';
import 'trip_list_screen.dart';

class AddMapPointScreen extends StatefulWidget {
  final Function(MapPoint) onPointAdded;

  const AddMapPointScreen({super.key, required this.onPointAdded});

  @override
  State<AddMapPointScreen> createState() => _AddMapPointScreenState();
}

class _AddMapPointScreenState extends State<AddMapPointScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _latitudeController = TextEditingController(text: '55.7558');
  final _longitudeController = TextEditingController(text: '37.6173');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить точку на карту'),
        // Убираем кнопку назад - только горизонтальная навигация
        automaticallyImplyLeading: false,
        actions: [
          // Кнопка отмены - горизонтальная навигация на главный экран
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Отмена',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TripListScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Название точки',
                  border: OutlineInputBorder(),
                ),
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
                decoration: const InputDecoration(
                  labelText: 'Описание',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите описание';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _latitudeController,
                      decoration: const InputDecoration(
                        labelText: 'Широта',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _longitudeController,
                      decoration: const InputDecoration(
                        labelText: 'Долгота',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  // Кнопка отмены - горизонтальная навигация
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const TripListScreen()),
                        );
                      },
                      child: const Text('Отмена'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Кнопка добавления - горизонтальная навигация
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _addPoint,
                      child: const Text('Добавить точку'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Дополнительная кнопка перехода к списку поездок
              TextButton.icon(
                icon: const Icon(Icons.list),
                label: const Text('Вернуться к списку поездок'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const TripListScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addPoint() {
    if (_formKey.currentState!.validate()) {
      final newPoint = MapPoint(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        latitude: double.parse(_latitudeController.text),
        longitude: double.parse(_longitudeController.text),
      );

      widget.onPointAdded(newPoint);

      // Горизонтальная навигация - замена экрана на главный
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TripListScreen()),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }
}