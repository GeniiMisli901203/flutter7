import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/map_point.dart';

class AddMapPointScreen extends StatefulWidget {
  final List<MapPoint> currentPoints;

  const AddMapPointScreen({super.key, required this.currentPoints});

  @override
  State<AddMapPointScreen> createState() => _AddMapPointScreenState();
}

class _AddMapPointScreenState extends State<AddMapPointScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _latitudeController = TextEditingController(text: '55.7558');
  final _longitudeController = TextEditingController(text: '37.6173');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить точку на карту'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            // Горизонтальная навигация - возврат на карту
            onPressed: () => context.goNamed('map', extra: widget.currentPoints),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Название точки',
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
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
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
                  child: TextField(
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
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Отмена - горизонтальная навигация на карту
                      context.goNamed('map', extra: widget.currentPoints);
                    },
                    child: const Text('Отмена'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _addPoint,
                    child: const Text('Добавить точку'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addPoint() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _latitudeController.text.isNotEmpty &&
        _longitudeController.text.isNotEmpty) {

      final latitude = double.tryParse(_latitudeController.text);
      final longitude = double.tryParse(_longitudeController.text);

      if (latitude == null || longitude == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Введите корректные координаты')),
        );
        return;
      }

      final newPoint = MapPoint(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        latitude: latitude,
        longitude: longitude,
      );

      final updatedPoints = [...widget.currentPoints, newPoint];

      // Горизонтальная навигация на карту с обновленными данными
      context.goNamed('map', extra: updatedPoints);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Точка "${_titleController.text}" добавлена!')),
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
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }
}