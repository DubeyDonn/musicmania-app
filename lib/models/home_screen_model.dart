class HomeScreenModel {
  final List<dynamic> artists;
  final List<dynamic> albums;
  final List<dynamic> songs;

  final List<dynamic> recommendedSongs;

  HomeScreenModel({
    required this.artists,
    required this.albums,
    required this.songs,
    this.recommendedSongs = const [],
  });
}
