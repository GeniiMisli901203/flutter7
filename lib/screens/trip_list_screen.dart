import 'package:flutter/material.dart';
import '../models/trip.dart';
import 'trip_detail_screen.dart';
import 'new_trip_screen.dart';
import 'map_screen.dart';
import 'settings_screen.dart';

class TripListScreen extends StatefulWidget {
  final List<Trip> initialTrips;

  // Основной конструктор
  const TripListScreen({super.key, List<Trip>? initialTrips})
      : initialTrips = initialTrips ?? const [];

  @override
  State<TripListScreen> createState() => _TripListScreenState();
}

class _TripListScreenState extends State<TripListScreen> {
  late List<Trip> trips;

  @override
  void initState() {
    super.initState();
    // Инициализируем trips из initialTrips или начальными данными
    trips = widget.initialTrips.isNotEmpty
        ? List.from(widget.initialTrips)
        : [
      Trip(id: '1', title: 'Отдых в Сочи', description: 'Поездка на море'),
      Trip(id: '2', title: 'Поход в горы', description: 'Восхождение на Эльбрус'),
    ];
  }

  int _currentIndex = 0;

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
              Navigator.push(
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
                currentTrips: trips, // Передаем текущие поездки
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
          // В методе _buildStatistics замените:
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