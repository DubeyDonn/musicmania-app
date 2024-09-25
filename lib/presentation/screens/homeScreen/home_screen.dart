import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/FeatchSong/featch_song_cubit.dart';
import 'package:musiq/bloc/home_screen_cubit/home_screen_cubit.dart';
import 'package:musiq/core/sized.dart';
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
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _SongList(
                    model: state.homeScreenModel.topArtists,
                    boderRadius: 10,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Top Albums",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _SongList(
                    model: state.homeScreenModel.topAlbums,
                    boderRadius: 20,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "All Songs",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _SongList(
                    model: state.homeScreenModel.allSongs,
                    boderRadius: 20,
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

// ignore: must_be_immutable
class _SongList extends StatelessWidget {
  final List model;
  double boderRadius;
  _SongList({
    required this.model,
    required this.boderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 10),
        itemCount: model.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final data = model[index];

          return GestureDetector(
            onTap: () {
              // log("Subtitle: ${data.subtitle}");
              // log("Description: ${data.description}");
              // log("HeaderDesc: ${data.headerDesc}");
              // log("PermaUrl: ${data.permaUrl}");
              // log("Image: ${data.image}");
              // log("Language: ${data.language}");
              // log("Year: ${data.year}");
              // log("PlayCount: ${data.playCount}");
              // log("ExplicitContent: ${data.explicitContent}");
              // log("ListCount: ${data.listCount}");
              // log("ListType: ${data.listType}");
              // log("List: ${data.list.toString()}"); // Convert list to a string
              // log("MoreInfo: ${data.moreInfo}"); // Assuming moreInfo is a Map
              // log("ButtonTooltipInfo: ${data.buttonTooltipInfo}");
              // if (data.type == "radio_station") {
              //   context.read<FeatchSongCubit>().feachArtistSong(
              //         artistName: data.title,
              //         imageUrl: data.image,
              //         title: data.title,
              //       );
              // } else {
              context.read<FeatchSongCubit>().clickSong(
                  type: data['type'] ?? "",
                  id: data['_id'] ?? "0",
                  imageUrl: data['artworkImage'] ?? "",
                  title: data['name'] ?? "no name");
              // }
            },
            child: SizedBox(
              width: 180,
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(boderRadius),
                      child: CachedNetworkImage(
                          imageUrl: data['artworkImage'] ??
                              "https://static.vecteezy.com/system/resources/thumbnails/037/044/052/small_2x/ai-generated-studio-shot-of-black-headphones-over-music-note-explosion-background-with-empty-space-for-text-photo.jpg",
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              // data.type == "Artist"                            ?
                              Image.asset("assets/images/artist.png")
                          // : data.type == "album"
                          //     ? Image.asset("assets/images/album.png")
                          //     : Image.asset("assets/images/song.png"),
                          ,
                          errorWidget: (context, url, error) =>
                              // data.type == "Artist"
                              //     ?
                              Image.asset("assets/images/artist.png")
                          // : data.type == "album"
                          //     ? Image.asset("assets/images/album.png")
                          //     : Image.asset("assets/images/song.png"),
                          ),
                    ),
                  ),
                  constWidth20,
                  Text(
                    data['name'] ?? "no name",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
