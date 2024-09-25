import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musiq/data/musicmania_api.dart';
import 'package:musiq/models/home_screen_model.dart';
import 'package:musiq/models/song_model.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final MusicManiaAPI api = MusicManiaAPI();

  HomeScreenCubit() : super(HomeScreenInitial());

  void loadData() async {
    emit(HomeScreenLoading());

    try {
      final topArtists = await api.fetchTopArtists();
      final topAlbums = await api.fetchTopAlbums();
      final allSongs = await api.fetchAllSongs();
      final recommendedSongs = await api.fetchRecommendedSongs();

      final homeScreenModel = HomeScreenModel(
        topArtists: topArtists,
        topAlbums: topAlbums,
        allSongs: allSongs,
        recommendedSongs: recommendedSongs,
      );

      emit(HomeScreenLoaded(homeScreenModel));
    } catch (e) {
      emit(HomeScreenError(e.toString()));
    }
  }
}
