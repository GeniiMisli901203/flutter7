import 'package:flutter/material.dart';
import 'package:flutter7/screens/trip_list_screen.dart';
import '../models/trip.dart';
import '../models/map_point.dart';
import 'add_map_point_screen.dart';

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

  void _addMapPoint(MapPoint newPoint) {
    setState(() {
      mapPoints.add(newPoint);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Карта путешествий'),
        actions: [

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
                    // Кнопка перехода к списку поездок (вертикальная навигация)
                    ElevatedButton.icon(
                      icon: const Icon(Icons.travel_explore),
                      label: const Text('Мои поездки'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TripListScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    // Еще одна кнопка перехода (горизонтальная навигация)
                    OutlinedButton.icon(
                      icon: const Icon(Icons.view_list),
                      label: const Text('Вернуться к списку'),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const TripListScreen()),
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
                // Заголовок списка точек с кнопкой перехода
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
                            MaterialPageRoute(builder: (context) => const TripListScreen()),
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
                        subtitle: Text('${point.latitude}, ${point.longitude}'),
                        trailing: Text(point.description),
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
          // Кнопка перехода к списку поездок
          FloatingActionButton.small(
            heroTag: 'list_btn',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TripListScreen()),
              );
            },
            child: const Icon(Icons.view_list),
          ),
          const SizedBox(height: 10),
          // Кнопка добавления новой точки
          FloatingActionButton(
            heroTag: 'add_point_btn',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddMapPointScreen(onPointAdded: _addMapPoint),
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