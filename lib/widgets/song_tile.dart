import 'package:flutter/material.dart';

class SongTile extends StatelessWidget {
  const SongTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: Colors.white,
      title: Text("Song name"),
      subtitle: Text("Artist name"),
      leading: CircleAvatar(child: Text("1")),
      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.skip_next)),
    );
  }
}
