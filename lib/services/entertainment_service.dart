import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

class EntertainmentService {
  // Category constants
  static const String GAME = 'Game';
  static const String MOVIE = 'Movie';
  static const String TV_SERIES = 'TV Series';
  static const String OUTDOOR = 'Outdoor Entertainment';

  // Distance range constants for outdoor entertainment
  static const String RANGE_10 = '10 km';
  static const String RANGE_30 = '30 km';
  static const String RANGE_50 = '50 km';
  static const String RANGE_100 = '100 km';

  // Katowice coordinates
  static const LatLng KATOWICE_LOCATION = LatLng(50.2649, 19.0238);

  // Entertainment datasets
  static final Map<String, List<String>> games = {
    'Board Games': [
      'Play Monopoly',
      'Have a chess match',
      'Try Scrabble',
      'Play Carcassonne',
      'Organize a Ticket to Ride session',
      'Challenge friends to Pandemic',
      'Enjoy Settlers of Catan',
      'Play Codenames',
    ],
    'Video Games': [
      'Start a new game in The Witcher 3',
      'Play a match of FIFA',
      'Try a level in Portal',
      'Explore Minecraft',
      'Race in Forza Horizon',
      'Battle in Mortal Kombat',
      'Build in Cities: Skylines',
      'Adventure in Red Dead Redemption 2',
    ],
    'Card Games': [
      'Play a round of Poker',
      'Organize a Bridge evening',
      'Try Solitaire',
      'Play UNO with friends',
      'Learn a new card trick',
      'Start a Magic: The Gathering duel',
      'Play traditional Polish card games',
    ],
  };

  static final Map<String, List<String>> movies = {
    'Action': [
      'Watch The Dark Knight',
      'Experience Inception',
      'Enjoy Mad Max: Fury Road',
      'See John Wick',
      'Watch Mission: Impossible',
      'Experience Gladiator',
      'View Die Hard',
    ],
    'Drama': [
      'Watch The Shawshank Redemption',
      'Experience The Godfather',
      'See Schindler\'s List',
      'Watch Forrest Gump',
      'Experience The Green Mile',
      'View The Pianist',
      'Watch A Beautiful Mind',
    ],
    'Comedy': [
      'Watch The Hangover',
      'Experience Groundhog Day',
      'See Bridesmaids',
      'Watch Superbad',
      'View The Grand Budapest Hotel',
      'Experience The Big Lebowski',
      'Watch Shaun of the Dead',
    ],
    'Sci-Fi': [
      'Watch Blade Runner 2049',
      'Experience Interstellar',
      'See Arrival',
      'Watch The Matrix',
      'Experience Ex Machina',
      'View District 9',
      'Watch Dune',
    ],
  };

  static final Map<String, List<String>> tvSeries = {
    'Drama': [
      'Start Breaking Bad',
      'Watch The Wire',
      'Experience Better Call Saul',
      'See The Crown',
      'Watch True Detective',
      'Try The Sopranos',
      'Start Mad Men',
    ],
    'Comedy': [
      'Watch Friends',
      'Experience The Office',
      'See Brooklyn Nine-Nine',
      'Try Parks and Recreation',
      'Watch Modern Family',
      'Experience Community',
      'View How I Met Your Mother',
    ],
    'Fantasy': [
      'Start Game of Thrones',
      'Watch The Witcher',
      'Experience Stranger Things',
      'See The Mandalorian',
      'Try Shadow and Bone',
      'Watch House of the Dragon',
      'Experience Good Omens',
    ],
    'Crime': [
      'Watch Sherlock',
      'Experience Mindhunter',
      'See Fargo',
      'Try Broadchurch',
      'Watch Luther',
      'Experience Ozark',
      'View The Bridge',
    ],
  };

  static final Map<String, List<Map<String, dynamic>>> outdoorEntertainment = {
    RANGE_10: [
      {
        'name': 'Silesia Park',
        'description': 'Large recreational area with attractions, zoo, and amusement park',
        'location': const LatLng(50.2906, 19.0233),
        'activities': ['Walking trails', 'Zoo visit', 'Amusement rides', 'Rope park'],
      },
      {
        'name': 'Valley of Three Ponds',
        'description': 'Popular recreational area with beaches and water activities',
        'location': const LatLng(50.2397, 19.0275),
        'activities': ['Swimming', 'Beach relaxation', 'Water sports'],
      },
    ],
    RANGE_30: [
      {
        'name': 'Chorzów Amusement Park',
        'description': 'Classic amusement park with various rides and attractions',
        'location': const LatLng(50.2905, 18.9755),
        'activities': ['Roller coasters', 'Family rides', 'Entertainment shows'],
      },
      {
        'name': 'Paprocany Lake',
        'description': 'Beautiful lake with recreational facilities',
        'location': const LatLng(50.1422, 18.9993),
        'activities': ['Water sports', 'Cycling', 'Beach activities'],
      },
    ],
    RANGE_50: [
      {
        'name': 'Eagle Valley Zoo',
        'description': 'Modern zoo with diverse animal species',
        'location': const LatLng(50.3717, 19.2347),
        'activities': ['Animal watching', 'Educational programs', 'Family activities'],
      },
      {
        'name': 'Dąbrowa Górnicza Pogoria III',
        'description': 'Popular recreational lake with beaches',
        'location': const LatLng(50.3553, 19.2156),
        'activities': ['Swimming', 'Sailing', 'Beach sports'],
      },
    ],
    RANGE_100: [
      {
        'name': 'Energylandia',
        'description': 'Largest amusement park in Poland',
        'location': const LatLng(49.9771, 19.4023),
        'activities': ['Roller coasters', 'Water park', 'Shows and entertainment'],
      },
      {
        'name': 'Kraków Old Town',
        'description': 'Historic city center with entertainment options',
        'location': const LatLng(50.0617, 19.9373),
        'activities': ['Sightseeing', 'Street performances', 'Cultural events'],
      },
    ],
  };

  // Helper method to get all available categories
  static List<String> get categories => [GAME, MOVIE, TV_SERIES, OUTDOOR];

  // Helper method to get distance ranges for outdoor entertainment
  static List<String> get distanceRanges => [RANGE_10, RANGE_30, RANGE_50, RANGE_100];

  // Helper method to calculate distance between two points
  static double calculateDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371; // Earth's radius in kilometers

    // Convert latitude and longitude to radians
    final lat1 = point1.latitude * (pi / 180);
    final lon1 = point1.longitude * (pi / 180);
    final lat2 = point2.latitude * (pi / 180);
    final lon2 = point2.longitude * (pi / 180);

    // Haversine formula
    final dLat = lat2 - lat1;
    final dLon = lon2 - lon1;
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return earthRadius * c;
  }
} 