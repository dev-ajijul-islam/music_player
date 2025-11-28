import 'package:flutter/material.dart';
import 'package:music_player/widgets/song_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    Text("Song name", style: TextTheme.of(context).titleLarge),
                    Text(
                      "Singer name name",
                      style: TextTheme.of(context).titleMedium,
                    ),
                    Slider(inactiveColor: Colors.grey.shade400, value: 10, min: 0, max: 100, onChanged: (value) {}),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("1:00", style: TextTheme.of(context).titleMedium),
                          Text("10:00",style: TextTheme.of(context).titleMedium),
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
                            onPressed: () {},
                            icon: Icon(Icons.skip_previous),
                          ),

                          CircleAvatar(
                            radius: 25,
                            child: Icon(Icons.play_arrow, size: 35),
                          ),

                          IconButton(
                            onPressed: () {},
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
                  itemCount: 10,
                  separatorBuilder: (context, index) => SizedBox(height: 5),
                  itemBuilder: (context, index) => SongTile(),
                  padding: EdgeInsets.all(5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
