import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musiq/data/musicmania_api.dart';
import 'package:musiq/models/home_screen_model.dart';
import 'package:musiq/models/song_model.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final MusicManiaAPI api = MusicManiaAPI();

  HomeScreenCubit() : super(HomeScreenInitial());

  Future<void> fetchHomeScreenData() async {
    emit(HomeScreenLoading());

    try {
      final topArtists = await api.fetchTopArtists();
      final topAlbums = await api.fetchTopAlbums();
      final allSongs = await api.fetchAllSongs();

      final homeScreenModel = HomeScreenModel(
        topArtists: topArtists['data'],
        topAlbums: topAlbums['data'],
        allSongs: allSongs['data'],
      );

      emit(HomeScreenLoaded(homeScreenModel));
    } catch (e) {
      emit(HomeScreenError(e.toString()));
    }
  }
}
