import 'package:flutter/material.dart';
import '../models/trip.dart';
import 'trip_detail_screen.dart';
import 'new_trip_screen.dart';
import 'map_screen.dart';
import 'settings_screen.dart';

class TripListScreen extends StatefulWidget {
  const TripListScreen({super.key});

  @override
  State<TripListScreen> createState() => _TripListScreenState();
}

class _TripListScreenState extends State<TripListScreen> {
  List<Trip> trips = [
    Trip(id: '1', title: 'Отдых в Сочи', description: 'Поездка на море'),
    Trip(id: '2', title: 'Поход в горы', description: 'Восхождение на Эльбрус'),
  ];

  int _currentIndex = 0;

  // Этот метод будет вызываться из других экранов через Navigator
  void addNewTrip(Trip newTrip) {
    // Проверяем, mounted чтобы избежать ошибки setState после dispose
    if (mounted) {
      setState(() {
        trips.add(newTrip);
      });
    }
  }

  void _deleteTrip(String tripId) {
    setState(() {
      trips.removeWhere((trip) => trip.id == tripId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои поездки'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: _currentIndex == 0 ? _buildTripsList() : _buildStatistics(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Поездки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Статистика',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 0 ? FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NewTripScreen(
                onTripAdded: (newTrip) {
                  // Создаем новый экран TripListScreen с обновленными данными
                  final newScreen = TripListScreen();
                  // Вызываем метод добавления поездки на новом экране
                  (newScreen.createState() as _TripListScreenState).addNewTrip(newTrip);
                  return newScreen;
                },
              ),
            ),
          );
        },
      ) : null,
    );
  }

  Widget _buildTripsList() {
    return ListView.builder(
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
        return Dismissible(
          key: Key(trip.id),
          background: Container(color: Colors.red),
          onDismissed: (direction) => _deleteTrip(trip.id),
          child: Card(
            child: ListTile(
              title: Text(trip.title),
              subtitle: Text(trip.description),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TripDetailScreen(
                      trip: trip,
                      onTripUpdated: (updatedTrip) {
                        setState(() {
                          final index = trips.indexWhere((t) => t.id == trip.id);
                          if (index != -1) {
                            trips[index] = updatedTrip;
                          }
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatistics() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.bar_chart, size: 100, color: Colors.blue),
          const SizedBox(height: 20),
          Text('Всего поездок: ${trips.length}'),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(Icons.map),
            label: const Text('Посмотреть на карте'),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MapScreen(trips: trips),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}