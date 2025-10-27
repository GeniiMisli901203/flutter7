import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/trip.dart';
import '../models/map_point.dart';

class MapScreen extends StatefulWidget {
  final List<Trip> trips;
  final List<MapPoint>? initialPoints;

  const MapScreen({
    super.key,
    required this.trips,
    this.initialPoints,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late List<MapPoint> mapPoints;

  @override
  void initState() {
    super.initState();
    mapPoints = widget.initialPoints ?? [
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Карта путешествий'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            tooltip: 'Список поездок',
            // Горизонтальная навигация через маршрут
            onPressed: () => context.go('/'),
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
                  subtitle: Text('${point.latitude.toStringAsFixed(4)}, ${point.longitude.toStringAsFixed(4)}'),
                  trailing: Text(
                      point.description.length > 15
                          ? '${point.description.substring(0, 15)}...'
                          : point.description
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_location),
        // Горизонтальная навигация через маршрут
        onPressed: () => context.goNamed('add_point', extra: mapPoints),
      ),
    );
  }
}