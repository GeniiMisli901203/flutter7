import 'package:flutter/material.dart';
import 'about_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _darkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        // Возвращаем кнопку назад
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Вертикальная навигация - возврат назад
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Настройки приложения',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SwitchListTile(
            title: const Text('Уведомления'),
            value: _notifications,
            onChanged: (value) {
              setState(() {
                _notifications = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Темная тема'),
            value: _darkTheme,
            onChanged: (value) {
              setState(() {
                _darkTheme = value;
              });
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('О приложении'),
            // Вертикальная навигация: Переход к информации о приложении
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}