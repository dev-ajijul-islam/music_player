import 'package:flutter/material.dart';
import 'package:music_player/model/song_model.dart';

class SongTile extends StatelessWidget {
  final int currentSongIndex;
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final int songIndex;
  final SongModel songModel;
  final bool isPlaying;
  final VoidCallback onTileTap;

  const SongTile({
    super.key,
    required this.songModel,
    required this.songIndex,
    required this.onPlay,
    required this.onPause,
    required this.currentSongIndex,
    required this.isPlaying,
    required this.onTileTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTileTap();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: (currentSongIndex == songIndex)
          ? ColorScheme.of(context).primary.withAlpha(50)
          : Colors.white,
      title: Text(songModel.songName),
      subtitle: Text(songModel.artist, style: TextStyle(color: Colors.grey)),
      leading: CircleAvatar(
        backgroundColor: ColorScheme.of(context).primary.withAlpha(200),
        child: Text("${songIndex + 1}"),
      ),
      trailing: IconButton(
        onPressed: () {
          (isPlaying && currentSongIndex == songIndex) ? onPause() : onPlay();
        },
        icon: Icon(
          (currentSongIndex == songIndex && isPlaying)
              ? Icons.pause
              : Icons.play_arrow,
        ),
      ),
    );
  }
}
