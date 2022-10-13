import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:stacked/stacked.dart';

import '../app/app.logger.dart';
import '../models/game.dart';
import '../models/stream.dart';

class HttpService with ReactiveServiceMixin {
  final log = getLogger('HttpService');

  static const String clientId = 'ja4jcr2nn1zdx64ddazz88xu63dino';
  static const String secret = '7fm5vc8k4bcshczqr6u0rt19z4pf48';

  static const String credUrl = 'https://id.twitch.tv/oauth2/token';

  static const String getStreamsUrl = 'https://api.twitch.tv/helix/streams';

  static const String getTopGameIdUrl = 'https://api.twitch.tv/helix/games/top';

  static const String getSubsId = 'https://api.twitch.tv/helix/subscriptions';

  String _accessToken = '';
  String get accessToken => _accessToken;

  final List<Streams> _twitchStream = ReactiveList();
  List<Streams> get twitchStream {
    _twitchStream.sort((a, b) {
      if (a.giveaway == b.giveaway) {
        return 0;
      } else if (a.giveaway) {
        return -1;
      }
      return 1;
    });
    return [..._twitchStream];
  }

  final List<Streams> _streamsWithGiveaways = ReactiveList();
  List<Streams> get streamsWithGiveaways => _streamsWithGiveaways;

  final ReactiveList<Game> _topGames = ReactiveList();
  List<Game> get topGames => _topGames;

  Future<void> fetchGameIds() async {
    // Fetch the access token
    Response credentialResponse = await http.post(Uri.parse(credUrl), body: {
      'client_id': clientId,
      'client_secret': secret,
      'grant_type': 'client_credentials'
    });
    _accessToken = json.decode(credentialResponse.body)['access_token'];
    // header for http get request
    Map<String, String> header = {
      'Client-Id': clientId,
      'Authorization': 'Bearer $_accessToken',
    };
    // Perform HTTP get request to retrieve TopGameData
    Response gameResponse = await http.get(
      Uri.parse('$getTopGameIdUrl?first=100'),
      headers: header,
    );
    _topGames.clear();
    // Loop through games and pull data
    for (var data in json.decode(gameResponse.body)['data']) {
      if (data['name'] != 'Slots') {
        _topGames.add(
          Game(name: data['name'], id: data['id'], boxArt: data['box_art_url']),
        );
      }
    }
  }

  Future<void> fetchStreamsFromSelection(Game selection) async {
    var header = {
      'Client-Id': clientId,
      'Authorization': 'Bearer $_accessToken',
    };
    var streamResponse = await http.get(
      Uri.parse('$getStreamsUrl?game_id=${selection.id}&language=en&first=100'),
      headers: header,
    );
    _twitchStream.clear();
    for (var data in json.decode(streamResponse.body)['data']) {
      _twitchStream.add(
        Streams(
          userName: data['user_name'],
          streamTitle: data['title'],
          tagIds: data['tag_ids'],
          viewerCount: data['viewer_count'],
          giveaway: false,
        ),
      );
    }
  }

  Future<void> fetchAllGiveaways() async {
    var header = {
      'Client-Id': clientId,
      'Authorization': 'Bearer $_accessToken',
    };
    for (var game in topGames) {
      log.i('Sniffing ${game.name}');
      var streamResponse = await http.get(
        Uri.parse('$getStreamsUrl?game_id=${game.id}&language=en&first=100'),
        headers: header,
      );
      for (var stream in json.decode(streamResponse.body)['data']) {
        stream['title'].split(' ').forEach((word) {
          word = word.toLowerCase();
          if (word.contains('giveaway')) {
            _streamsWithGiveaways.add(
              Streams(
                userName: stream['user_name'],
                streamTitle: stream['title'],
                tagIds: stream['tag_ids'],
                viewerCount: stream['viewer_count'],
                giveaway: true,
              ),
            );
          }
        });
      }
    }
    log.i('Done with giveaway search');
  }

  void setGiveawayTrue(int index) {
    _twitchStream[index].giveaway = true;
    notifyListeners();
  }

  HttpService() {
    listenToReactiveValues([
      _topGames,
      _twitchStream,
      _streamsWithGiveaways,
    ]);
  }
}
