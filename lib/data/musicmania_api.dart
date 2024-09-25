import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:musiq/data/responce_format.dart';
import 'package:musiq/services/auth.dart';

Auth auth = Auth();

class MusicManiaAPI {
  //--------- urls -------------------
  String baseUrl = 'http://192.168.0.16:8080';

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

  //----------- responce ---------------
  Future<http.Response> getResponse(String endpoint, {String id = ''}) async {
    String url = '$baseUrl$endpoint';

    if (id.isNotEmpty) {
      url = '$url/$id';
    }

    log("url: $url");
    final http.Client client = HttpClient() as http.Client;

    final response = await client.get(Uri.parse(url), headers: headers);

    return response;
  }

  Future<Map> fetchAllArtists() async {
    if (jwt == null) {
      await _initializeToken();
    }

    try {
      final res = await getResponse(endpoints['allArtists']!);

      log(res.body);

      return jsonDecode(res.body);
    } catch (e) {
      log('Error in fetchAllArtists: $e');
      return {};
    }
  }

  Future<Map> fetchTopArtists() async {
    if (jwt == null) {
      await _initializeToken();
    }

    try {
      final res = await getResponse(endpoints['topArtists']!);

      log(res.body);

      return jsonDecode(res.body);
    } catch (e) {
      log('Error in fetchTopArtists: $e');
      return {};
    }
  }

  Future<Map> fetchArtistDetails(String id) async {
    if (jwt == null) {
      await _initializeToken();
    }

    try {
      final res = await getResponse(endpoints['artistDetails']!, id: id);

      log(res.body);

      return jsonDecode(res.body);
    } catch (e) {
      log('Error in fetchArtistDetails: $e');
      return {};
    }
  }

  Future<Map> fetchAllAlbums() async {
    if (jwt == null) {
      await _initializeToken();
    }

    try {
      final res = await getResponse(endpoints['allAlbums']!);

      log(res.body);

      return jsonDecode(res.body);
    } catch (e) {
      log('Error in fetchAllAlbums: $e');
      return {};
    }
  }

  Future<Map> fetchTopAlbums() async {
    if (jwt == null) {
      await _initializeToken();
    }

    try {
      final res = await getResponse(endpoints['topAlbums']!);

      log(res.body);

      return jsonDecode(res.body);
    } catch (e) {
      log('Error in fetchTopAlbums: $e');
      return {};
    }
  }

  Future<Map> fetchAlbumDetails(String id) async {
    if (jwt == null) {
      await _initializeToken();
    }

    try {
      final res = await getResponse(endpoints['albumDetails']!, id: id);

      log(res.body);

      return jsonDecode(res.body);
    } catch (e) {
      log('Error in fetchAlbumDetails: $e');
      return {};
    }
  }

  Future<Map> fetchAllSongs() async {
    if (jwt == null) {
      await _initializeToken();
    }

    try {
      final res = await getResponse(endpoints['allSongs']!);

      log(res.body);

      return jsonDecode(res.body);
    } catch (e) {
      log('Error in fetchAllSongs: $e');
      return {};
    }
  }

  Future<Map> fetchSongDetails(String id) async {
    if (jwt == null) {
      await _initializeToken();
    }

    try {
      final res = await getResponse(endpoints['songDetails']!, id: id);

      log(res.body);

      return jsonDecode(res.body);
    } catch (e) {
      log('Error in fetchSongDetails: $e');
      return {};
    }
  }

  Future<Map> playSong(String id) async {
    if (jwt == null) {
      await _initializeToken();
    }

    try {
      final res = await getResponse(endpoints['playSong']!, id: id);

      log(res.body);

      return jsonDecode(res.body);
    } catch (e) {
      log('Error in playSong: $e');
      return {};
    }
  }
}
