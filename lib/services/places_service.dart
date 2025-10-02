import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesService {
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/place';
  static const String apiKey = 'AIzaSyBz5G-pPSugCL_-n_xyi2hJkv1LmW3BjUQ'; // Replace with actual API key

  // Check and request location permissions
  static Future<bool> checkLocationPermission() async {
    final status = await Permission.location.status;
    if (status.isGranted) {
      return true;
    }

    final result = await Permission.location.request();
    return result.isGranted;
  }

  // Get current location
  static Future<Position?> getCurrentLocation() async {
    try {
      final hasPermission = await checkLocationPermission();
      if (!hasPermission) {
        return null;
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  // Search for restaurants based on meal type
  static Future<List<Map<String, dynamic>>> searchRestaurants(String meal, Position location) async {
    try {
      // Translate meal name to search query
      final searchQuery = _translateMealToSearchQuery(meal);
      
      final response = await http.get(
        Uri.parse(
          '$_baseUrl/textsearch/json?query=$searchQuery&location=${location.latitude},${location.longitude}&radius=5000&type=restaurant&language=pl&key=$apiKey',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          return List<Map<String, dynamic>>.from(data['results']);
        }
      }
      return [];
    } catch (e) {
      print('Error searching restaurants: $e');
      return [];
    }
  }

  // Helper method to translate meal names to search queries
  static String _translateMealToSearchQuery(String meal) {
    // Add common keywords to improve search relevance
    final mealLower = meal.toLowerCase();
    
    if (mealLower.contains('pizza')) return 'pizzeria $meal';
    if (mealLower.contains('sushi')) return 'sushi restauracja';
    if (mealLower.contains('burger')) return 'burger restauracja';
    if (mealLower.contains('curry')) return 'indyjska restauracja';
    if (mealLower.contains('makaron')) return 'restauracja makarony pasta';
    if (mealLower.contains('ramen')) return 'ramen restauracja azjatycka';
    if (mealLower.contains('kebab')) return 'kebab restauracja';
    if (mealLower.contains('sałatka')) return 'restauracja sałatki healthy';
    
    // Default search query
    return 'restauracja $meal';
  }

  // Get place details including photos, opening hours, etc.
  static Future<Map<String, dynamic>?> getPlaceDetails(String placeId) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$_baseUrl/details/json?place_id=$placeId&fields=name,rating,formatted_phone_number,formatted_address,opening_hours,photos,price_level,website&language=pl&key=$apiKey',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          return data['result'];
        }
      }
      return null;
    } catch (e) {
      print('Error getting place details: $e');
      return null;
    }
  }

  // Get place photo
  static String getPhotoUrl(String photoReference) {
    return '$_baseUrl/photo?maxwidth=400&photo_reference=$photoReference&key=$apiKey';
  }

  // Search for attractions near a location
  static Future<List<Map<String, dynamic>>> searchAttractions(LatLng location) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$_baseUrl/nearbysearch/json?location=${location.latitude}2,${location.longitude}&radius=5000&type=tourist_attraction|point_of_interest|museum|park|church|landmark&language=en&key=$apiKey',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          return List<Map<String, dynamic>>.from(data['results']);
        }
      }
      return [];
    } catch (e) {
      print('Error searching attractions: $e');
      return [];
    }
  }
} 