import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class TrackDetail extends StatefulWidget {
  final getdatafromtrending;
  const TrackDetail({Key? key, required this.getdatafromtrending})
      : super(key: key);

  @override
  State<TrackDetail> createState() => _TrackDetailState();
}

class _TrackDetailState extends State<TrackDetail> {
  Widget feildName(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 10.0),
      child: Text(
        name,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget valueName(var name) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 10.0),
      child: Text(
        name.toString(),
        style: const TextStyle(
          fontSize: 16.0,
        ),
      ),
    );
  }

  Future? getUserDate(String trackid) async {
    Uri url = Uri.parse(
        'https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackid&apikey=4d9906716e9395ff40347ec9435b9262');
    var response = await http.get(url);

    var body = await jsonDecode(response.body);

    Lyrics users = Lyrics.fromjson(body);

    return users;
  }

  Lyrics? lyrics;
  Future<void> UpdateUI() async {
    lyrics = await getUserDate(
        widget.getdatafromtrending!.track!.trackId.toString());
  }

  @override
  void initState() {
    UpdateUI();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          'Track Details',
          style: TextStyle(color: Colors.black, fontSize: 25.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          feildName('Name'),
          valueName(widget.getdatafromtrending!.track!.trackName),
          feildName('Artist'),
          valueName(widget.getdatafromtrending!.track!.artistName),
          feildName('Album Name'),
          valueName(widget.getdatafromtrending!.track!.albumName),
          feildName('Explicit'),
          valueName(widget.getdatafromtrending!.track!.explicit),
          feildName('Rating'),
          valueName(widget.getdatafromtrending!.track!.trackRating),
          feildName('Lyrics'),
          FutureBuilder(
              future: UpdateUI(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData != null) {
                  return valueName(lyrics!.lyrics);
                }
                return const Center(child: CircularProgressIndicator());
              })
        ],
      ),
    );
  }
}

class Lyrics {
  String? lyrics;
  Lyrics({this.lyrics});
  Lyrics.fromjson(Map<String, dynamic> map) {
    lyrics = map['message']['body']['lyrics']['lyrics_body'];
  }
}
