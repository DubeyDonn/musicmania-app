class HomeScreenModel {
  final List<dynamic> topArtists;
  final List<dynamic> topAlbums;
  final List<dynamic> allSongs;

  final List<dynamic> recommendedSongs;

  HomeScreenModel({
    required this.topArtists,
    required this.topAlbums,
    required this.allSongs,
    this.recommendedSongs = const [],
  });
}
