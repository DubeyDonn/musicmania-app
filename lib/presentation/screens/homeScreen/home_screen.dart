import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/home_screen_cubit/home_screen_cubit.dart';
import 'package:musiq/models/home_screen_model.dart';
import 'package:musiq/presentation/commanWidgets/song_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          if (state is HomeScreenLoaded) {
            // final songList = state.homeScreenModel.allSongs;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "Top Artists",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SongList(
                    model: state.homeScreenModel.topArtists,
                    borderRadius: 10,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Top Albums",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SongList(
                    model: state.homeScreenModel.topAlbums,
                    borderRadius: 20,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "All Songs",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SongList(
                    model: state.homeScreenModel.allSongs,
                    borderRadius: 20,
                  ),
                ],
              ),
            );
          } else if (state is HomeScreenLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeScreenError) {
            return Center(
              child: Text('Error: '),
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
