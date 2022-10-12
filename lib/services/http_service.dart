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

  String _accessToken = '';
  String get accessToken => _accessToken;

  final List<Streams> _twitchStream = ReactiveList();
  List<Streams> get twitchStream => _twitchStream;

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
      _topGames.add(
        Game(name: data['name'], id: data['id'], boxArt: data['box_art_url']),
      );
    }
    log.i('Top Games: $_topGames');
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
      // TODO figure out how to speed this up, maybe do computation in the background?
      data['title'].split(' ').forEach((word) {
        if (word.contains('!giveaway') ||
            word.contains('giveaway') ||
            word.contains('prize') ||
            word.contains('!prize') ||
            word.contains('free') ||
            word.contains('!free')) {
          _twitchStream.add(
            Streams(
              userName: data['user_name'],
              streamTitle: data['title'],
              tagIds: data['tag_ids'],
              viewerCount: data['viewer_count'],
              giveaway: true,
            ),
          );
        } else {
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
      });
    }
  }

  HttpService() {
    listenToReactiveValues([
      _topGames,
      _twitchStream,
    ]);
  }
}
