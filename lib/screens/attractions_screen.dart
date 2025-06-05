import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/places_service.dart';
import 'package:url_launcher/url_launcher.dart';

class AttractionsScreen extends StatefulWidget {
  final String destinationName;
  final LatLng location;

  const AttractionsScreen({
    super.key,
    required this.destinationName,
    required this.location,
  });

  @override
  State<AttractionsScreen> createState() => _AttractionsScreenState();
}

class _AttractionsScreenState extends State<AttractionsScreen> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _attractions = [];
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadAttractions();
  }

  Future<void> _loadAttractions() async {
    try {
      final attractions = await PlacesService.searchAttractions(widget.location);
      
      if (mounted) {
        setState(() {
          _attractions = attractions;
          _isLoading = false;

          // Add markers for each attraction
          _markers.add(
            Marker(
              markerId: const MarkerId('destination'),
              position: widget.location,
              infoWindow: InfoWindow(
                title: widget.destinationName,
                snippet: 'Main destination',
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            ),
          );

          for (var attraction in attractions) {
            final location = attraction['geometry']['location'];
            _markers.add(
              Marker(
                markerId: MarkerId(attraction['place_id']),
                position: LatLng(location['lat'], location['lng']),
                infoWindow: InfoWindow(
                  title: attraction['name'],
                  snippet: attraction['vicinity'],
                ),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
              ),
            );
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading attractions: $e')),
        );
      }
    }
  }

  void _showAttractionDetails(Map<String, dynamic> attraction) async {
    final details = await PlacesService.getPlaceDetails(attraction['place_id']);
    if (!mounted) return;

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
                Text(
                  attraction['name'],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                if (details?['photos']?.isNotEmpty)
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(
                          PlacesService.getPhotoUrl(
                            details!['photos'][0]['photo_reference'],
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
                  title: Text(attraction['vicinity'] ?? ''),
                ),

                // Rating if available
                if (attraction['rating'] != null)
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: Row(
                      children: [
                        Text(attraction['rating'].toString()),
                        const SizedBox(width: 8),
                        Text(
                          '(${attraction['user_ratings_total']} reviews)',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 16),

                // Navigation button
                ElevatedButton.icon(
                  onPressed: () async {
                    final location = attraction['geometry']['location'];
                    final url = 'https://www.google.com/maps/dir/?api=1&destination=${location['lat']},${location['lng']}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                  icon: const Icon(Icons.directions),
                  label: const Text('Get Directions'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text('Attractions in ${widget.destinationName}'),
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
                      target: widget.location,
                      zoom: 13,
                    ),
                    markers: _markers,
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                  ),
                ),

                // Attractions list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _attractions.length,
                    itemBuilder: (context, index) {
                      final attraction = _attractions[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: ListTile(
                          title: Text(
                            attraction['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(attraction['vicinity'] ?? ''),
                          trailing: attraction['rating'] != null
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 20,
                                      color: colorScheme.primary,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      attraction['rating'].toString(),
                                      style: TextStyle(
                                        color: colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              : null,
                          onTap: () => _showAttractionDetails(attraction),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
} 