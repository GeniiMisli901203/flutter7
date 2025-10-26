import 'package:flutter/material.dart';
import '../models/trip.dart';
import 'edit_trip_screen.dart';

class TripDetailScreen extends StatelessWidget {
  final Trip trip;
  final Function(Trip)? onTripUpdated;

  const TripDetailScreen({
    super.key,
    required this.trip,
    this.onTripUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(trip.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              trip.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              trip.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            const Text('Детали поездки:'),
            const SizedBox(height: 10),
            _buildDetailItem(Icons.calendar_today, 'Дата: ${DateTime.now().toString().split(' ')[0]}'),
            _buildDetailItem(Icons.location_on, 'Место: ${trip.title.split(' ').last}'),
            _buildDetailItem(Icons.notes, 'Заметки: Планируется...'),
            const Spacer(),
            if (onTripUpdated != null)
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text('Редактировать поездку'),
                  // Вертикальная навигация: Переход к редактированию
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTripScreen(
                          trip: trip,
                          onTripUpdated: onTripUpdated!,
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}