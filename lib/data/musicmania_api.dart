import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:musiq/core/constants.dart';
import 'package:musiq/services/auth.dart';

Auth auth = Auth();

class MusicManiaAPI {
  //--------- urls -------------------
  String baseUrl = Constants.musicmaniaBackendUrl;

  // Token will be initialized asynchronously
  String? jwt;

  //---------End points -----------
  Map<String, String> endpoints = {
    'allArtists': '/music/allArtist',
    'topArtists': '/music/topArtist',
    'artistDetails': '/music/artist',
    'allAlbums': '/music/allAlbum',
    'topAlbums': '/music/topAlbum',
    'albumDetails': '/music/album',
    'allSongs': '/music/allTrack',
    'songDetails': '/music/track',
    'playSong': '/music/play',
    'recommendedSongs': '/music/recommend',
    'fetchSongByArtist': '/music/tracks/artist',
    'fetchSongsByAlbum': '/music/tracks/album',
    'search': '/music/search',
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

  Future<List<dynamic>> fetchRecommendedSongs() async {
    try {
      final response = await getResponse(endpoints['recommendedSongs']!);
      if (response.statusCode == 200) {
        final recommendations = jsonDecode(response.body)['recommendations'];

        return recommendations;
      } else {
        return [];
      }
    } catch (e) {
      log('Error in fetchRecommendedSongs: $e');
      return [];
    }
  }

  Future<List<dynamic>> fetchSongsByArtist(String artistId) async {
    try {
      final response =
          await getResponse(endpoints['fetchSongByArtist']!, id: artistId);
      if (response.statusCode == 200) {
        var body = response.body;
        var jsonBody = jsonDecode(body);

        return jsonBody;
      } else {
        return [];
      }
    } catch (e) {
      log('Error in fetchByArtist: $e');
      return [];
    }
  }

  //fetch by album
  Future<List<dynamic>> fetchSongsByAlbum(String albumId) async {
    try {
      final response =
          await getResponse(endpoints['fetchSongsByAlbum']!, id: albumId);
      if (response.statusCode == 200) {
        var body = response.body;
        var jsonBody = jsonDecode(body);

        return jsonBody;
      } else {
        return [];
      }
    } catch (e) {
      log('Error in fetchByAlbum: $e');
      return [];
    }
  }

  //fetch all artist
  Future<List<dynamic>> fetchAllArtists() async {
    try {
      final response = await getResponse(endpoints['allArtists']!);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      log('Error in fetchAllArtists: $e');
      return [];
    }
  }

  //fetch all albums
  Future<List<dynamic>> fetchAllAlbums() async {
    try {
      final response = await getResponse(endpoints['allAlbums']!);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      log('Error in fetchAllAlbums: $e');
      return [];
    }
  }

  // fetch by search
  Future<List<dynamic>> fetchSearch(String query) async {
    try {
      final response = await getResponse(endpoints['search']!, id: query);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      log('Error in fetchSearch: $e');
      return [];
    }
  }
}
