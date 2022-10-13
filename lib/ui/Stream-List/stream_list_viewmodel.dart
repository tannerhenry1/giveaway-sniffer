import 'package:giveaway_sniffer/services/http_service.dart';
import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../models/game.dart';
import '../../models/stream.dart';

class StreamListViewModel extends ReactiveViewModel {
  final _httpService = locator<HttpService>();
  final log = getLogger('StreamListView');

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Streams> get twitchStream => _httpService.twitchStream;

  Future<void> initialise(Game selection) async {
    _isLoading = true;
    notifyListeners();
    // fetch top viewed streams in category
    await _httpService.fetchStreamsFromSelection(selection);
    log.i('Before Sort');
    initBackgroundSort();
    log.i('After Sort');
    _isLoading = false;
    notifyListeners();
  }

  void initBackgroundSort() {
    String test = '!GiVeaWay';
    test = test.toLowerCase();
    log.i(test);
    log.i('Test: ${test.contains('giveaway')}');
    for (int i = 0; i < twitchStream.length; i++) {
      twitchStream[i].streamTitle.split(' ').forEach((word) {
        word = word.toLowerCase();
        if (word.contains('giveaway')) {
          _httpService.setGiveawayTrue(i);
        }
      });
    }
  }

  Future<void> displayData() async {}

  @override
  List<ReactiveServiceMixin> get reactiveServices => [
        _httpService,
      ];
}
