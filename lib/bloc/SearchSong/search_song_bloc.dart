import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/data/musicmania_api.dart';
import 'package:musiq/data/saavn_data.dart';
import 'package:musiq/models/search_model.dart';
import 'package:musiq/models/song_model.dart';

part 'search_song_event.dart';
part 'search_song_state.dart';

MusicManiaAPI api = MusicManiaAPI();

class SearchSongBloc extends Bloc<SearchSongEvent, SearchSongState> {
  SearchSongBloc() : super(SearchSongInitial()) {
    on<SearchSongEvent>((event, emit) async {
      emit(SearchSongLoading());
      try {
        final searchData = await api.fetchSearch(event.searchQuery);
        // final searchSongData = await SaavnAPI()
        //     .fetchSongSearchResults(searchQuery: event.searchQuery);

        if (searchData.isEmpty) {
          emit(SearchSongError());
          return;
        }

        // final searchModel = SearchModel.fromJson(searchData);
        List<SongModel> songList = (searchData as List)
            .map((songJson) => SongModel.fromJson(songJson))
            .toList();

        emit(SearchSongSuccess(songModel: songList));
      } catch (e) {
        log("Error fetching search results: $e");
        emit(SearchSongError());
      }
    });
  }
}
