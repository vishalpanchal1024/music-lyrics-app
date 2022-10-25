import 'package:flutter/material.dart';
import 'package:music_app/Model/api_client_responce.dart';
import 'package:music_app/screens/track_detail.dart';
import '../Model/api_responce_model.dart';

class Trending extends StatefulWidget {
  const Trending({super.key});

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  ApiClientResponce client = ApiClientResponce();
  Songs? data;
  Future<void> getData() async {
    data = await client.getUserDate();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trending',
          style: TextStyle(color: Colors.black, fontSize: 25.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const AlertDialog(
                icon: Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
                title: Text('No Internet Connection !'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData != null) {
              return ListView.builder(
                itemCount: data!.message!.body!.trackList!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TrackDetail(
                                getdatafromtrending:
                                    data!.message!.body!.trackList![index],
                              ),
                            ),
                          );
                        },
                        leading: const Icon(Icons.library_music),
                        title: Text(data!
                            .message!.body!.trackList![index].track!.trackName
                            .toString()),
                        subtitle: Text(data!
                            .message!.body!.trackList![index].track!.albumName
                            .toString()),
                        trailing: Text(data!
                            .message!.body!.trackList![index].track!.artistName
                            .toString()),
                      ),
                      const Divider(
                        thickness: 2.0,
                        indent: 18.0,
                        endIndent: 18.0,
                      ),
                    ],
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
