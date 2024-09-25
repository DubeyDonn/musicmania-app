import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:musiq/services/auth.dart';

Auth auth = Auth();

class MusicManiaAPI {
  //--------- urls -------------------
  String baseUrl = 'http://192.168.0.16:8000';

  // Token will be initialized asynchronously
  String? jwt;

  //---------End points -----------
  Map<String, String> endpoints = {
    'allArtists': '/music/allArtist',
    'topArtists': '/music/topArtist',
    'artistDetails': '/music/artist',
    'allAlbums': '/music/allAlbums',
    'topAlbums': '/music/topAlbums',
    'albumDetails': '/music/album',
    'allSongs': '/music/allTrack',
    'songDetails': '/music/track',
    'playSong': '/music/play',
  };

  //------------header------------
  Map<String, String> headers = {};

  // Constructor
  MusicManiaAPI() {
    _initializeToken();
  }

  // Asynchronous method to initialize the token
  Future<void> _initializeToken() async {
    jwt = await auth.getToken();
    headers = {
      'Authorization': 'Bearer $jwt',
    };
  }

  //----------- response ---------------
  Future<http.Response> getResponse(String endpoint, {String id = ''}) async {
    String url = '$baseUrl$endpoint';

    if (id.isNotEmpty) {
      url = '$url/$id';
    }

    log("url: $url");
    final http.Client client = http.Client();

    final response = await client.get(Uri.parse(url), headers: headers);

    return response;
  }

  // Example methods to fetch data
  Future<List<dynamic>> fetchTopArtists() async {
    try {
      final response = await getResponse(endpoints['topArtists']!);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      log('Error in fetchTopArtists: $e');
      rethrow;
    }
  }

  Future<List<dynamic>> fetchTopAlbums() async {
    try {
      final response = await getResponse(endpoints['topAlbums']!);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      log('Error in fetchTopAlbums: $e');
      rethrow;
    }
  }

  Future<List<dynamic>> fetchAllSongs() async {
    if (jwt == null) {
      await _initializeToken();
    }

    try {
      final res = await getResponse(endpoints['allSongs']!);

      log(res.body);

      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        return [];
      }
    } catch (e) {
      log('Error in fetchAllSongs: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> fetchAlbumDetails(String id) async {
    try {
      final response = await getResponse(endpoints['albumDetails']!, id: id);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {};
      }
    } catch (e) {
      log('Error in fetchAlbumDetails: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> fetchSongDetails(String id) async {
    try {
      final response = await getResponse(endpoints['songDetails']!, id: id);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {};
      }
    } catch (e) {
      log('Error in fetchSongDetails: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> playSong(String id) async {
    try {
      final response = await getResponse(endpoints['playSong']!, id: id);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {};
      }
    } catch (e) {
      log('Error in playSong: $e');
      return {};
    }
  }
}
