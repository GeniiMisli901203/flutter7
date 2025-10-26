import 'package:flutter/material.dart';
import '../models/trip.dart';

class EditTripScreen extends StatefulWidget {
  final Trip trip;
  final Function(Trip) onTripUpdated;

  const EditTripScreen({
    super.key,
    required this.trip,
    required this.onTripUpdated,
  });

  @override
  State<EditTripScreen> createState() => _EditTripScreenState();
}

class _EditTripScreenState extends State<EditTripScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.trip.title);
    _descriptionController = TextEditingController(text: widget.trip.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактировать поездку'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveTrip,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Название поездки',
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
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите описание';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTrip,
                child: const Text('Сохранить изменения'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveTrip() {
    if (_formKey.currentState!.validate()) {
      final updatedTrip = widget.trip.copyWith(
        title: _titleController.text,
        description: _descriptionController.text,
      );

      widget.onTripUpdated(updatedTrip);
      Navigator.pop(context); // Вертикальная навигация - возврат назад
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}