import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SpotifyService {
  // TODO: Store these securely, e.g., using environment variables or a config file not committed to Git.
  static const String _clientId = 'YOUR_SPOTIFY_CLIENT_ID'; // Replace with your actual Client ID
  static const String _clientSecret = 'YOUR_SPOTIFY_CLIENT_SECRET'; // Replace with your actual Client Secret
  static const String _redirectUri = 'http://127.0.0.1:54321/callback';
  
  bool _isInitialized = false;
  late SharedPreferences _prefs;
  String? _accessToken;
  String? _refreshToken;

  Future<void> initialize() async {
    if (_isInitialized) return;

    _prefs = await SharedPreferences.getInstance();
    _accessToken = _prefs.getString('spotify_access_token');
    _refreshToken = _prefs.getString('spotify_refresh_token');
    
    if (_accessToken == null || _refreshToken == null) {
      print('No tokens found, starting authentication...');
      await _authenticate();
    } else {
      try {
        // Test the token by making a simple request
        final response = await http.get(
          Uri.parse('https://api.spotify.com/v1/me'),
          headers: {'Authorization': 'Bearer $_accessToken'},
        );
        
        if (response.statusCode != 200) {
          print('Token test failed, refreshing...');
          await _refreshAccessToken();
        }
      } catch (e) {
        print('Error testing token: $e');
        await _authenticate();
      }
    }
    _isInitialized = true;
  }

  Future<void> _refreshAccessToken() async {
    if (_refreshToken == null) {
      print('No refresh token available, re-authenticating...');
      await _authenticate();
      return;
    }

    try {
      print('Attempting to refresh token...');
      final response = await http.post(
        Uri.parse('https://accounts.spotify.com/api/token'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Basic ${base64Encode(utf8.encode('$_clientId:$_clientSecret'))}',
        },
        body: {
          'grant_type': 'refresh_token',
          'refresh_token': _refreshToken,
        },
      );

      if (response.statusCode != 200) {
        print('Failed to refresh token: ${response.body}');
        throw Exception('Failed to refresh token: ${response.body}');
      }

      final data = jsonDecode(response.body);
      _accessToken = data['access_token'];
      if (data['refresh_token'] != null) {
        _refreshToken = data['refresh_token'];
        await _prefs.setString('spotify_refresh_token', _refreshToken!);
      }
      await _prefs.setString('spotify_access_token', _accessToken!);
      print('Token refreshed successfully');
    } catch (e) {
      print('Error refreshing token: $e');
      await _authenticate();
    }
  }

  Future<void> _authenticate() async {
    print('Starting authentication process...');
    // Clear any existing tokens
    await _prefs.remove('spotify_access_token');
    await _prefs.remove('spotify_refresh_token');
    _accessToken = null;
    _refreshToken = null;

    // Construct the authorization URL
    final authUrl = Uri.https('accounts.spotify.com', '/authorize', {
      'client_id': _clientId,
      'response_type': 'code',
      'redirect_uri': _redirectUri,
      'scope': 'user-library-read user-modify-playback-state',
    });

    print('Launching authentication URL...');
    // Launch the authentication flow
    final result = await FlutterWebAuth2.authenticate(
      url: authUrl.toString(),
      callbackUrlScheme: Uri.parse(_redirectUri).scheme,
    );

    // Extract the authorization code from the result
    final code = Uri.parse(result).queryParameters['code'];
    if (code == null) {
      throw Exception('Failed to get authorization code');
    }

    print('Got authorization code, exchanging for tokens...');
    // Exchange the code for an access token
    final tokenResponse = await _getAccessToken(code);
    
    // Save the tokens
    _accessToken = tokenResponse['access_token'];
    _refreshToken = tokenResponse['refresh_token'];
    await _prefs.setString('spotify_access_token', _accessToken!);
    await _prefs.setString('spotify_refresh_token', _refreshToken!);
    print('Authentication completed successfully');
  }

  Future<Map<String, dynamic>> _getAccessToken(String code) async {
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic ${base64Encode(utf8.encode('$_clientId:$_clientSecret'))}',
      },
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': _redirectUri,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to get access token: ${response.body}');
    }

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getRandomTrack() async {
    if (!_isInitialized) {
      print('Initializing Spotify service...');
      await initialize();
    }

    try {
      print('Fetching saved tracks...');
      // Get user's saved tracks
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/me/tracks?limit=50'),
        headers: {'Authorization': 'Bearer $_accessToken'},
      );

      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          await _refreshAccessToken();
          return getRandomTrack();
        }
        throw Exception('Failed to get saved tracks: ${response.body}');
      }

      final data = jsonDecode(response.body);
      final items = data['items'] as List;
      
      print('Number of saved tracks: ${items.length}');
      if (items.isEmpty) {
        throw Exception('No saved tracks found');
      }

      // Get a random track from saved tracks
      final random = Random();
      final randomIndex = random.nextInt(items.length);
      final savedTrack = items[randomIndex]['track'];
      
      print('Selected track: ${savedTrack['name']}');
      
      final result = {
        'name': savedTrack['name'],
        'artist': savedTrack['artists'][0]['name'],
        'album': savedTrack['album']['name'],
        'uri': savedTrack['uri'],
        'imageUrl': savedTrack['album']['images'].isNotEmpty 
            ? savedTrack['album']['images'][0]['url'] 
            : null,
      };
      print('Returning track data: $result');
      return result;
    } catch (e, stackTrace) {
      print('Error in getRandomTrack: $e');
      print('Stack trace: $stackTrace');
      if (e.toString().contains('401')) {
        await _refreshAccessToken();
        return getRandomTrack();
      }
      throw Exception('Failed to get random track: $e');
    }
  }

  Future<void> playTrack(String trackUri) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      // Start playback using the Web API directly
      final response = await http.put(
        Uri.parse('https://api.spotify.com/v1/me/player/play'),
        headers: {
          'Authorization': 'Bearer $_accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'uris': [trackUri],
        }),
      );

      if (response.statusCode != 204) {
        if (response.statusCode == 401) {
          await _refreshAccessToken();
          return playTrack(trackUri);
        }
        throw Exception('Failed to start playback: ${response.body}');
      }
    } catch (e) {
      if (e.toString().contains('401')) {
        await _refreshAccessToken();
        return playTrack(trackUri);
      }
      throw Exception('Failed to play track: $e');
    }
  }
} 