class Songs {
  Message? message;

  Songs({this.message});

  Songs.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
  }
}

class Message {
  Header? header;
  Body? body;

  Message({this.header, this.body});

  Message.fromJson(Map<String, dynamic> json) {
    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }
}

class Header {
  int? statusCode;
  double? executeTime;

  Header({this.statusCode, this.executeTime});

  Header.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    executeTime = json['execute_time'];
  }
}

class Body {
  List<TrackList>? trackList;

  Body({this.trackList});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['track_list'] != null) {
      trackList = <TrackList>[];
      json['track_list'].forEach((v) {
        trackList!.add(TrackList.fromJson(v));
      });
    }
  }
}

class TrackList {
  Track? track;

  TrackList({this.track});

  TrackList.fromJson(Map<String, dynamic> json) {
    track = json['track'] != null ? Track.fromJson(json['track']) : null;
  }
}

class Track {
  int? trackId;
  String? trackName;
  int? trackRating;
  int? explicit;
  int? hasLyrics;
  String? albumName;
  int? artistId;
  String? artistName;

  Track({
    this.trackId,
    this.trackName,
    this.trackRating,
    this.explicit,
    this.hasLyrics,
    this.albumName,
    this.artistId,
    this.artistName,
  });

  Track.fromJson(Map<String, dynamic> json) {
    trackId = json['track_id'];
    trackName = json['track_name'];

    trackRating = json['track_rating'];

    explicit = json['explicit'];
    hasLyrics = json['has_lyrics'];

    albumName = json['album_name'];
    artistId = json['artist_id'];
    artistName = json['artist_name'];
  }
}
