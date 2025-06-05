import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TravelService {
  // Katowice coordinates
  static const LatLng KATOWICE_LOCATION = LatLng(50.2649, 19.0238);

  // Travel categories
  static const String QUICK_TRIP = 'Quick trip';
  static const String TRIP_300 = 'Trip up to 300 km';
  static const String TRIP_500 = 'Trip up to 500 km';
  static const String TRIP_POLAND = 'Trip within Poland';
  static const String TRIP_EUROPE = 'Trip within Europe';
  static const String TRIP_WORLDWIDE = 'Trip worldwide';

  // Destinations data
  static final Map<String, List<Destination>> destinations = {
    QUICK_TRIP: [
      Destination('Gliwice', 'Silesian city known for its technical university and radio station', LatLng(50.2945, 18.6714)),
      Destination('Zabrze', 'Industrial heritage city with unique mining sites', LatLng(50.3249, 18.7857)),
      Destination('Chorzów', 'Home to the famous Silesian Park and Zoo', LatLng(50.2974, 18.9545)),
      Destination('Bytom', 'Historic Upper Silesian city with beautiful architecture', LatLng(50.3484, 18.9160)),
      Destination('Tychy', 'Modern city known for its brewery and car factory', LatLng(50.1308, 18.9642)),
      Destination('Sosnowiec', 'Important industrial and cultural center', LatLng(50.2867, 19.1040)),
      Destination('Będzin', 'City with a medieval castle and Jewish heritage', LatLng(50.3257, 19.1333)),
      Destination('Pszczyna', 'Known for its beautiful palace and park complex', LatLng(50.0383, 18.9553)),
    ],
    TRIP_300: [
      Destination('Kraków', 'Historic royal city with rich cultural heritage', LatLng(50.0647, 19.9450)),
      Destination('Wrocław', 'City of bridges and markets', LatLng(51.1079, 17.0385)),
      Destination('Częstochowa', 'Religious center with Jasna Góra Monastery', LatLng(50.8118, 19.1203)),
      Destination('Opole', 'City of music festivals', LatLng(50.6751, 17.9213)),
      Destination('Bielsko-Biała', 'Gateway to the Beskid Mountains', LatLng(49.8224, 19.0584)),
      Destination('Zakopane', 'Winter capital of Poland', LatLng(49.2992, 19.9496)),
      Destination('Olomouc', 'Historic city in Czech Republic', LatLng(49.5938, 17.2508)),
      Destination('Ostrava', 'Industrial heritage city in Czech Republic', LatLng(49.8209, 18.2625)),
    ],
    TRIP_500: [
      Destination('Warsaw', 'Capital city of Poland', LatLng(52.2297, 21.0122)),
      Destination('Łódź', 'City of industrial heritage and film', LatLng(51.7592, 19.4559)),
      Destination('Brno', 'Second largest city in Czech Republic', LatLng(49.1951, 16.6068)),
      Destination('Prague', 'Capital city of Czech Republic', LatLng(50.0755, 14.4378)),
      Destination('Vienna', 'Capital city of Austria', LatLng(48.2082, 16.3738)),
      Destination('Budapest', 'Capital city of Hungary', LatLng(47.4979, 19.0402)),
      Destination('Bratislava', 'Capital city of Slovakia', LatLng(48.1486, 17.1077)),
    ],
    TRIP_POLAND: [
      Destination('Gdańsk', 'Historic port city', LatLng(54.3520, 18.6466)),
      Destination('Poznań', 'Historic trade city with famous town hall', LatLng(52.4064, 16.9252)),
      Destination('Szczecin', 'Port city with Ducal Castle', LatLng(53.4285, 14.5528)),
      Destination('Lublin', 'City with preserved medieval core', LatLng(51.2465, 22.5684)),
      Destination('Białystok', 'Largest city in northeastern Poland', LatLng(53.1325, 23.1688)),
      Destination('Toruń', 'Gothic architecture and Copernicus birthplace', LatLng(53.0138, 18.5984)),
      Destination('Rzeszów', 'Capital of Subcarpathian region', LatLng(50.0412, 21.9991)),
      Destination('Kołobrzeg', 'Popular Baltic Sea resort', LatLng(54.1760, 15.5833)),
    ],
    TRIP_EUROPE: [
      Destination('Berlin', 'Capital city of Germany', LatLng(52.5200, 13.4050)),
      Destination('Paris', 'Capital city of France', LatLng(48.8566, 2.3522)),
      Destination('Rome', 'Capital city of Italy', LatLng(41.9028, 12.4964)),
      Destination('Amsterdam', 'Capital city of Netherlands', LatLng(52.3676, 4.9041)),
      Destination('Barcelona', 'Cultural capital of Catalonia', LatLng(41.3851, 2.1734)),
      Destination('Copenhagen', 'Capital city of Denmark', LatLng(55.6761, 12.5683)),
      Destination('Stockholm', 'Capital city of Sweden', LatLng(59.3293, 18.0686)),
      Destination('Athens', 'Capital city of Greece', LatLng(37.9838, 23.7275)),
    ],
    TRIP_WORLDWIDE: [
      Destination('New York', 'The Big Apple, USA', LatLng(40.7128, -74.0060)),
      Destination('Tokyo', 'Capital city of Japan', LatLng(35.6762, 139.6503)),
      Destination('Sydney', 'Largest city in Australia', LatLng(-33.8688, 151.2093)),
      Destination('Dubai', 'Largest city in UAE', LatLng(25.2048, 55.2708)),
      Destination('Rio de Janeiro', 'Carnival city of Brazil', LatLng(-22.9068, -43.1729)),
      Destination('Cape Town', 'Legislative capital of South Africa', LatLng(-33.9249, 18.4241)),
      Destination('Singapore', 'City-state in Southeast Asia', LatLng(1.3521, 103.8198)),
      Destination('Vancouver', 'Major city in Western Canada', LatLng(49.2827, -123.1207)),
    ],
  };

  // Calculate distance between two points using Haversine formula
  static double calculateDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371; // Earth's radius in kilometers
    
    double lat1 = point1.latitude * pi / 180;
    double lat2 = point2.latitude * pi / 180;
    double dLat = (point2.latitude - point1.latitude) * pi / 180;
    double dLon = (point2.longitude - point1.longitude) * pi / 180;

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return earthRadius * c;
  }

  // Get random destination from a category
  static Destination getRandomDestination(String category) {
    final categoryDestinations = destinations[category];
    if (categoryDestinations == null || categoryDestinations.isEmpty) {
      throw Exception('No destinations found for category: $category');
    }

    final random = Random();
    return categoryDestinations[random.nextInt(categoryDestinations.length)];
  }

  // Validate if a destination is within the specified range
  static bool isDestinationWithinRange(Destination destination, double maxDistance) {
    double distance = calculateDistance(KATOWICE_LOCATION, destination.location);
    return distance <= maxDistance;
  }
}

class Destination {
  final String name;
  final String description;
  final LatLng location;

  const Destination(this.name, this.description, this.location);
} 