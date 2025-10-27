import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('О приложении'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          // Вертикальная навигация - возврат назад
          onPressed: () => context.pop(),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(Icons.travel_explore, size: 100, color: Colors.blue),
            ),
            SizedBox(height: 20),
            Text(
              'Travel Notes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Версия: 1.0.0'),
            SizedBox(height: 20),
            Text(
              'Описание:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Приложение для ведения заметок о путешествиях.'),
            SizedBox(height: 20),
            Text(
              'Функциональность:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('• Создание и редактирование поездок'),
            Text('• Отслеживание маршрутов на карте'),
            Text('• Добавление точек интереса'),
            Spacer(),
            Center(
              child: Text('© 2025 Travel Notes App'),
            ),
          ],
        ),
      ),
    );
  }
}