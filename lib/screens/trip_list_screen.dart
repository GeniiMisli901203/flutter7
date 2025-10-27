import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/trip.dart';

class TripListScreen extends StatefulWidget {
  final List<Trip>? initialTrips;

  const TripListScreen({super.key, this.initialTrips});

  @override
  State<TripListScreen> createState() => _TripListScreenState();
}

class _TripListScreenState extends State<TripListScreen> {
  late List<Trip> trips;

  @override
  void initState() {
    super.initState();
    if (widget.initialTrips != null) {
      trips = widget.initialTrips!;
    } else {
      trips = [
        Trip(id: '1', title: 'Отдых в Сочи', description: 'Поездка на море'),
        Trip(id: '2', title: 'Поход в горы', description: 'Восхождение на Эльбрус'),
      ];
    }
  }

  int _currentIndex = 0;

  void _deleteTrip(String tripId) {
    setState(() {
      trips.removeWhere((trip) => trip.id == tripId);
    });
  }

  void _updateTrip(Trip updatedTrip) {
    setState(() {
      final index = trips.indexWhere((trip) => trip.id == updatedTrip.id);
      if (index != -1) {
        trips[index] = updatedTrip;
      }
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
            onPressed: () => context.pushNamed('settings'),
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
        onPressed: () => context.goNamed('new_trip', extra: trips),
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
            child: InkWell(
              onTap: () async {
                print('Нажата поездка: ${trip.title}');
                final result = await context.pushNamed<Trip>(
                  'trip_detail',
                  extra: trip,
                );
                if (result != null) {
                  _updateTrip(result);
                }
              },
              child: ListTile(
                title: Text(trip.title),
                subtitle: Text(trip.description),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
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
            onPressed: () => context.goNamed('map', extra: trips),
          ),
        ],
      ),
    );
  }
}