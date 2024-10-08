import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiq/bloc/FeatchSong/featch_song_cubit.dart';
import 'package:musiq/bloc/home_screen_cubit/home_screen_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/constants.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/main.dart';
import 'package:musiq/models/home_screen_model.dart';
import 'package:musiq/presentation/commanWidgets/song_list.dart';
import 'package:musiq/presentation/screens/album_or_playlist_screen/album_or_playlist_screen.dart';
import 'package:musiq/presentation/screens/player_screen/player_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          if (state is HomeScreenLoaded) {
            // final songList = state.homeScreenModel.allSongs;
            return SingleChildScrollView(
              child: BlocListener<FeatchSongCubit, FeatchSongState>(
                listener: (context, state) {
                  /// ----------- show loading ---------
                  if (state is FeatchSongLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.transparent,
                          content: Center(
                            child: CircularProgressIndicator(
                              color: colorList[colorIndex],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is FeatchSongLoaded) {
                    Navigator.pop(context); // for close loading
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PlayerScreen(songs: state.songModel),
                        ));
                  } else if (state is FeatchAlbumOrPlayList) {
                    Navigator.pop(context); // for close loading
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AlbumOrPlaylistScreen(
                            songModel: state.songModel,
                            imageUrl: state.imageUrl,
                            title: state.title,
                            libraryModel: state.libraryModel,
                          ),
                        ));
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      //padding left only
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "Artists",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: colorList[colorIndex]),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _SongList(
                      model: state.homeScreenModel.artists,
                      boderRadius: 10,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "Albums",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: colorList[colorIndex]),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _SongList(
                      model: state.homeScreenModel.albums,
                      boderRadius: 20,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "Songs",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: colorList[colorIndex]),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // _SongList(
                    //   model: state.homeScreenModel.allSongs,
                    //   boderRadius: 20,
                    // ),
                    Container(
                      height: 250,
                      child: PageView.builder(
                        itemCount:
                            ((state.homeScreenModel.songs.length + 2) / 3)
                                .floor(),
                        pageSnapping: true,
                        controller: PageController(
                          viewportFraction: 0.9,
                        ),
                        itemBuilder: (context, pageIndex) {
                          return Transform.translate(
                            offset: Offset(
                                isMobile(context)
                                    ? -22
                                    : isTablet(context)
                                        ? -38
                                        : -70,
                                0),
                            child: Column(
                              children: List.generate(3, (itemIndex) {
                                final index = pageIndex * 3 + itemIndex;
                                if (index >=
                                    state.homeScreenModel.songs.length) {
                                  return SizedBox();
                                }
                                return Container(
                                  child: ListTile(
                                    leading: SizedBox(
                                      width: 50.0, // Set the desired width
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: CachedNetworkImage(
                                          imageUrl: state.homeScreenModel
                                                      .songs[index]
                                                  ['artworkImage'] ??
                                              "https://static.vecteezy.com/system/resources/thumbnails/037/044/052/small_2x/ai-generated-studio-shot-of-black-headphones-over-music-note-explosion-background-with-empty-space-for-text-photo.jpg",
                                          placeholder: (context, url) {
                                            // Placeholder logic
                                            return state.homeScreenModel
                                                        .songs[index]['type'] ==
                                                    "Artist"
                                                ? Image.asset(
                                                    "assets/images/artist.png")
                                                : state.homeScreenModel
                                                                .songs[index]
                                                            ['type'] ==
                                                        "album"
                                                    ? Image.asset(
                                                        "assets/images/album.png")
                                                    : Image.asset(
                                                        "assets/images/song.png");
                                          },
                                          errorWidget: (context, url, error) {
                                            // Error widget logic
                                            return state.homeScreenModel
                                                        .songs[index]['type'] ==
                                                    "Artist"
                                                ? Image.asset(
                                                    "assets/images/artist.png")
                                                : state.homeScreenModel
                                                                .songs[index]
                                                            ['type'] ==
                                                        "album"
                                                    ? Image.asset(
                                                        "assets/images/album.png")
                                                    : Image.asset(
                                                        "assets/images/song.png");
                                          },
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      state.homeScreenModel.songs[index]
                                          ['name'],
                                      maxLines: 1,
                                    ),
                                    subtitle: Text(
                                      "  ",
                                      maxLines: 1,
                                    ),
                                    onTap: () {
                                      context.read<FeatchSongCubit>().clickSong(
                                          type: state.homeScreenModel
                                                  .songs[index]['type'] ??
                                              "",
                                          id: state.homeScreenModel.songs[index]
                                                  ['_id'] ??
                                              "0",
                                          imageUrl: state.homeScreenModel
                                              .songs[index]['artworkImage'],
                                          title: state.homeScreenModel
                                              .songs[index]['name']);
                                    },
                                    // trailing: IconButton(
                                    //     onPressed: () {},
                                    //     icon: Icon(Icons.more_vert)),
                                  ),
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      //padding starts from the left side
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "Recommended Songs",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: colorList[colorIndex]),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _SongList(
                      model: state.homeScreenModel.recommendedSongs,
                      boderRadius: 20,
                    ),
                  ],
                ),
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
              // if (data['type'] == "song") {
              context.read<FeatchSongCubit>().clickSong(
                  type: data['type'] ?? "",
                  id: data['_id'] ?? "0",
                  imageUrl: data['artworkImage'] ?? "",
                  title: data['name'] ?? "no name");
              // } else {
              //   context.read<FeatchSongCubit>().fetchSongsByArtist(
              //         artistId: data['_id'] ?? "0",
              //       );
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
                        imageUrl: data['artworkImage'] != null
                            ? (data['type'] == "song"
                                ? data['artworkImage']
                                : Constants.musicmaniaBackendUrl +
                                    "/uploads/" +
                                    data['artworkImage'])
                            : "https://static.vecteezy.com/system/resources/thumbnails/037/044/052/small_2x/ai-generated-studio-shot-of-black-headphones-over-music-note-explosion-background-with-empty-space-for-text-photo.jpg",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => data['type'] == "artist"
                            ? Image.asset("assets/images/artist.png")
                            : data['type'] == "album"
                                ? Image.asset("assets/images/album.png")
                                : Image.asset("assets/images/song.png"),
                        errorWidget: (context, url, error) =>
                            data['type'] == "artist"
                                ? Image.asset("assets/images/artist.png")
                                : data['type'] == "album"
                                    ? Image.asset("assets/images/album.png")
                                    : Image.asset("assets/images/song.png"),
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
