import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../models/map_point.dart';
import 'add_map_point_screen.dart';
import 'trip_list_screen.dart';

class MapScreen extends StatefulWidget {
  final List<Trip> trips;

  const MapScreen({super.key, required this.trips});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<MapPoint> mapPoints = [
    MapPoint(
      id: '1',
      title: 'Сочи',
      description: 'Курортный город',
      latitude: 43.5855,
      longitude: 39.7231,
    ),
    MapPoint(
      id: '2',
      title: 'Эльбрус',
      description: 'Горная вершина',
      latitude: 43.3550,
      longitude: 42.4392,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Карта путешествий'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            tooltip: 'Список поездок',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TripListScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.blue[50],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.map, size: 100, color: Colors.blue),
                    const SizedBox(height: 20),
                    const Text('Карта с отметками о поездках'),
                    Text('Всего точек: ${mapPoints.length}'),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: mapPoints.length,
              itemBuilder: (context, index) {
                final point = mapPoints[index];
                return ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.red),
                  title: Text(point.title),
                  subtitle: Text('${point.latitude}, ${point.longitude}'),
                  trailing: Text(point.description),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_location),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AddMapPointScreen(
                onPointAdded: (newPoint) {
                  // Создаем новый экран карты с добавленной точкой
                  final newMapScreen = MapScreen(trips: widget.trips);
                  (newMapScreen.createState() as _MapScreenState).mapPoints.add(newPoint);
                  return newMapScreen;
                },
              ),
            ),
          );
        },
      ),
    );
  }
}