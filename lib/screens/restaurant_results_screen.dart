import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../services/places_service.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantResultsScreen extends StatefulWidget {
  final String meal;
  final Position userLocation;

  const RestaurantResultsScreen({
    super.key,
    required this.meal,
    required this.userLocation,
  });

  @override
  State<RestaurantResultsScreen> createState() => _RestaurantResultsScreenState();
}

class _RestaurantResultsScreenState extends State<RestaurantResultsScreen> {
  List<Map<String, dynamic>> _restaurants = [];
  bool _isLoading = true;
  GoogleMapController? _mapController;
  Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _searchRestaurants();
  }

  Future<void> _searchRestaurants() async {
    try {
      final results = await PlacesService.searchRestaurants(
        widget.meal,
        widget.userLocation,
      );

      if (mounted) {
        setState(() {
          _restaurants = results;
          _isLoading = false;
        });

        _updateMapMarkers();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Błąd podczas wyszukiwania restauracji'),
          ),
        );
      }
    }
  }

  void _updateMapMarkers() {
    final markers = <String, Marker>{};
    
    // Add user location marker
    markers['user'] = Marker(
      markerId: const MarkerId('user'),
      position: LatLng(widget.userLocation.latitude, widget.userLocation.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      infoWindow: const InfoWindow(title: 'Twoja lokalizacja'),
    );

    // Add restaurant markers
    for (final restaurant in _restaurants) {
      final location = restaurant['geometry']['location'];
      final markerId = restaurant['place_id'];
      
      markers[markerId] = Marker(
        markerId: MarkerId(markerId),
        position: LatLng(location['lat'], location['lng']),
        infoWindow: InfoWindow(
          title: restaurant['name'],
          snippet: restaurant['formatted_address'],
        ),
      );
    }

    setState(() {
      _markers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Restauracje - ${widget.meal}'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Map view
                SizedBox(
                  height: 200,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        widget.userLocation.latitude,
                        widget.userLocation.longitude,
                      ),
                      zoom: 13,
                    ),
                    markers: _markers.values.toSet(),
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                  ),
                ),
                
                // Results list
                Expanded(
                  child: _restaurants.isEmpty
                      ? Center(
                          child: Text(
                            'Nie znaleziono restauracji w pobliżu',
                            style: TextStyle(
                              color: colorScheme.onBackground,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _restaurants.length,
                          itemBuilder: (context, index) {
                            final restaurant = _restaurants[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: ListTile(
                                title: Text(
                                  restaurant['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text(restaurant['formatted_address'] ?? ''),
                                    if (restaurant['rating'] != null)
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.amber,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            restaurant['rating'].toString(),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.directions),
                                  onPressed: () async {
                                    final url = 'https://www.google.com/maps/dir/?api=1&destination=${restaurant['geometry']['location']['lat']},${restaurant['geometry']['location']['lng']}';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    }
                                  },
                                ),
                                onTap: () async {
                                  final details = await PlacesService.getPlaceDetails(
                                    restaurant['place_id'],
                                  );
                                  if (mounted && details != null) {
                                    _showRestaurantDetails(details);
                                  }
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }

  void _showRestaurantDetails(Map<String, dynamic> details) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: ListView(
              controller: scrollController,
              children: [
                // Restaurant name
                Text(
                  details['name'],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Photo if available
                if (details['photos']?.isNotEmpty)
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(
                          PlacesService.getPhotoUrl(
                            details['photos'][0]['photo_reference'],
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                // Address
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(details['formatted_address'] ?? ''),
                ),

                // Phone number if available
                if (details['formatted_phone_number'] != null)
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text(details['formatted_phone_number']),
                    onTap: () async {
                      final url = 'tel:${details['formatted_phone_number']}';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    },
                  ),

                // Website if available
                if (details['website'] != null)
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text('Odwiedź stronę'),
                    onTap: () async {
                      if (await canLaunch(details['website'])) {
                        await launch(details['website']);
                      }
                    },
                  ),

                // Opening hours if available
                if (details['opening_hours']?['weekday_text'] != null)
                  ExpansionTile(
                    leading: const Icon(Icons.access_time),
                    title: const Text('Godziny otwarcia'),
                    children: [
                      ...List<Widget>.from(
                        details['opening_hours']['weekday_text'].map(
                          (text) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            child: Text(text),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
} 