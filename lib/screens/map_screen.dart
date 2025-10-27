import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../models/map_point.dart';
import 'add_map_point_screen.dart';
import 'trip_list_screen.dart';

class MapScreen extends StatefulWidget {
  final List<Trip> trips;
  final List<MapPoint> initialPoints;

  const MapScreen({
    super.key,
    required this.trips,
    List<MapPoint>? initialPoints,
  }) : initialPoints = initialPoints ?? const [];

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late List<MapPoint> mapPoints;

  @override
  void initState() {
    super.initState();
    // Инициализируем точки из initialPoints или начальными данными
    mapPoints = widget.initialPoints.isNotEmpty
        ? List.from(widget.initialPoints)
        : [
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
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.travel_explore),
                      label: const Text('Мои поездки'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TripListScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Точки на карте:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.list_alt, size: 16),
                        label: const Text('К поездкам'),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => TripListScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
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
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: 'list_btn',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TripListScreen()),
              );
            },
            child: const Icon(Icons.view_list),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'add_point_btn',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddMapPointScreen(
                    currentPoints: mapPoints, // Передаем текущие точки
                  ),
                ),
              );
            },
            child: const Icon(Icons.add_location),
          ),
        ],
      ),
    );
  }
}