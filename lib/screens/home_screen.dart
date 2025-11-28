import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/model/song_model.dart';
import 'package:music_player/widgets/song_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  bool isPlaying = false;
  int currentSongIndex = 0;
  List<SongModel> songList = [
    SongModel(
      songName: "3-second synth melody",
      artist: "artist 1",
      songUrl: "https://samplelib.com/lib/preview/mp3/sample-3s.mp3",
      thumbnail:
          "https://d3jmn01ri1fzgl.cloudfront.net/photoadking/webp_thumbnail/white-music-youtube-thumbnail-template-9bpbt9b8cd486b.webp",
      duration: Duration(seconds: 3),
    ),
    SongModel(
      songName: "6-second synth melody",
      artist: "artist 2",
      songUrl: "https://samplelib.com/lib/preview/mp3/sample-6s.mp3",
      thumbnail:
          "https://d3jmn01ri1fzgl.cloudfront.net/photoadking/webp_thumbnail/white-music-youtube-thumbnail-template-9bpbt9b8cd486b.webp",
      duration: Duration(seconds: 6),
    ),
    SongModel(
      songName: "9-second melody using background drums",
      artist: "artist 3",
      songUrl: "https://samplelib.com/lib/preview/mp3/sample-9s.mp3",
      thumbnail:
          "https://d3jmn01ri1fzgl.cloudfront.net/photoadking/webp_thumbnail/white-music-youtube-thumbnail-template-9bpbt9b8cd486b.webp",
      duration: Duration(seconds: 9),
    ),
    SongModel(
      songName: "12-second melody using flute and whole drum ensemble",
      artist: "artist 4",
      songUrl: "https://samplelib.com/lib/preview/mp3/sample-12s.mp3",
      thumbnail:
          "https://d3jmn01ri1fzgl.cloudfront.net/photoadking/webp_thumbnail/white-music-youtube-thumbnail-template-9bpbt9b8cd486b.webp",
      duration: Duration(seconds: 12),
    ),
    SongModel(
      songName: "19 seconds of awesome music without using drums",
      artist: "artist 5",
      songUrl: "https://samplelib.com/lib/preview/mp3/sample-15s.mp3",
      thumbnail:
          "https://d3jmn01ri1fzgl.cloudfront.net/photoadking/webp_thumbnail/white-music-youtube-thumbnail-template-9bpbt9b8cd486b.webp",
      duration: Duration(seconds: 19),
    ),
  ];
  final AudioPlayer player = AudioPlayer();

  Duration currentPosition = Duration.zero;
  Duration currentDuration = Duration.zero;
  

  @override
  Widget build(BuildContext context) {
    
    double maxSec = max(currentDuration.inSeconds.toDouble(), 1);
    double currentSliderPos = currentPosition.inSeconds.toDouble().clamp(0, maxSec);

    return Scaffold(
      backgroundColor: ColorScheme.of(context).secondary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                clipBehavior: Clip.hardEdge,
                child: Column(
                  children: [
                    Image.network(
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      "https://d3jmn01ri1fzgl.cloudfront.net/photoadking/webp_thumbnail/white-music-youtube-thumbnail-template-9bpbt9b8cd486b.webp",
                    ),
                    SizedBox(height: 20),
                    Text(
                      textAlign: TextAlign.center,
                      songList[currentSongIndex].songName,
                      style: TextTheme.of(context).titleLarge,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      songList[currentSongIndex].artist,
                      style: TextTheme.of(context).titleMedium,
                    ),
                    Slider(
                      inactiveColor: Colors.grey.shade400,
                      value: currentSliderPos,
                      min: 0,
                      max: maxSec,
                      onChanged: (value) {
                        final position = Duration(seconds: value.toInt());
                        player.seek(position);
                      },

                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _durationFormatter(currentPosition),
                            style: TextTheme.of(context).titleMedium,
                          ),
                          Text(
                            _durationFormatter(
                              songList[currentSongIndex].duration,
                            ),
                            style: TextTheme.of(context).titleMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            style: IconButton.styleFrom(),
                            onPressed: _playPrevSong,
                            icon: Icon(Icons.skip_previous),
                          ),

                          Visibility(
                            visible: isLoading == false,
                            replacement: Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: InkWell(
                              onTap: () {
                                isPlaying
                                    ? _pauseSong()
                                    : _playSong(songList[currentSongIndex]);
                              },
                              child: CircleAvatar(
                                radius: 25,
                                child: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),

                          IconButton(
                            onPressed: _playNextSong,
                            icon: Icon(Icons.skip_next),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: ListView.separated(
                  itemCount: songList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 5),
                  itemBuilder: (context, index) {
                    final songModel = songList[index];
                    return SongTile(
                      songIndex: index,
                      songModel: songModel,
                      onPlay: () {
                        currentSongIndex = index;
                        _playSong(songList[index]);
                      },
                      currentSongIndex: currentSongIndex,
                      isPlaying: isPlaying,
                      onPause: _pauseSong,
                      onTileTap: (){
                        setState(() {
                          currentSongIndex = index;
                        });
                      },
                    );
                  },
                  padding: EdgeInsets.all(5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _playSong(SongModel song) async {
    setState(() {
      isLoading = true;
      isPlaying = true;
    });
    await player.play(UrlSource(song.songUrl));
    setState(() {
      isLoading = false;
    });
    player.onPositionChanged.listen(
      (event) => setState(() {
        currentPosition = event;
      }),
    );
    player.onDurationChanged.listen((event) => setState(() {
      currentDuration = event;
    }),);
    player.onPlayerComplete.listen((event) => _playNextSong());
  }

  Future<void> _pauseSong() async {
    setState(() {
      isPlaying = false;
    });
    await player.pause();
  }

  Future<void> _playNextSong() async {
    _pauseSong();
    currentSongIndex = (currentSongIndex + 1) % songList.length;
    _playSong(songList[currentSongIndex]);
  }

  Future<void> _playPrevSong() async {
    _pauseSong();
    currentSongIndex =
        (currentSongIndex - 1 + songList.length) % songList.length;
    _playSong(songList[currentSongIndex]);
  }

  String _durationFormatter(Duration duration) {
    final mnt = duration.inMinutes;
    final int sec = duration.inSeconds.remainder(60);

    return "$mnt:$sec";
  }
}
