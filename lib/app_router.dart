import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/trip.dart';
import '../models/map_point.dart';
import '../screens/trip_list_screen.dart';
import '../screens/trip_detail_screen.dart';
import '../screens/new_trip_screen.dart';
import '../screens/edit_trip_screen.dart';
import '../screens/map_screen.dart';
import '../screens/add_map_point_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/about_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) {
          final trips = state.extra as List<Trip>?;
          return MaterialPage(
            child: TripListScreen(initialTrips: trips),
          );
        },
        routes: [
          // Вертикальная навигация
          GoRoute(
            path: 'trip_detail', // ← УБРАЛ :id из пути
            name: 'trip_detail',
            pageBuilder: (context, state) {
              final trip = state.extra as Trip; // ← Данные через extra
              return MaterialPage(
                child: TripDetailScreen(
                  trip: trip,
                  onTripUpdated: (updatedTrip) {
                    context.pop(updatedTrip);
                  },
                ),
              );
            },
          ),
          GoRoute(
            path: 'edit_trip',
            name: 'edit_trip',
            pageBuilder: (context, state) {
              final args = state.extra as Map<String, dynamic>;
              return MaterialPage(
                child: EditTripScreen(
                  trip: args['trip'] as Trip,
                  onTripUpdated: args['onTripUpdated'] as Function(Trip),
                ),
              );
            },
          ),
          GoRoute(
            path: 'about',
            name: 'about',
            pageBuilder: (context, state) {
              return const MaterialPage(child: AboutScreen());
            },
          ),

          // Горизонтальная навигация
          GoRoute(
            path: 'new_trip',
            name: 'new_trip',
            pageBuilder: (context, state) {
              final currentTrips = state.extra as List<Trip>;
              return MaterialPage(
                child: NewTripScreen(currentTrips: currentTrips),
              );
            },
          ),
          GoRoute(
            path: 'map',
            name: 'map',
            pageBuilder: (context, state) {
              final trips = state.extra as List<Trip>;
              return MaterialPage(
                child: MapScreen(trips: trips),
              );
            },
          ),
          GoRoute(
            path: 'add_point',
            name: 'add_point',
            pageBuilder: (context, state) {
              final currentPoints = state.extra as List<MapPoint>;
              return MaterialPage(
                child: AddMapPointScreen(currentPoints: currentPoints),
              );
            },
          ),
          GoRoute(
            path: 'settings',
            name: 'settings',
            pageBuilder: (context, state) {
              return const MaterialPage(child: SettingsScreen());
            },
          ),
        ],
      ),
    ],
  );
}