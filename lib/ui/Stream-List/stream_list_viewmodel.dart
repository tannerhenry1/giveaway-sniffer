import 'package:giveaway_sniffer/services/http_service.dart';
import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';
import '../../models/game.dart';
import '../../models/stream.dart';

class StreamListViewModel extends ReactiveViewModel {
  final _httpService = locator<HttpService>();

  bool _isLoading = false;
  bool get isLoading => true;

  List<Streams> get twitchStream => _httpService.twitchStream;

  Future<void> initialise(Game selection) async {
    _isLoading = true;
    notifyListeners();
    // fetch top viewed streams in category
    await _httpService.fetchStreamsFromSelection(selection);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> displayData() async {}

  @override
  List<ReactiveServiceMixin> get reactiveServices => [
        _httpService,
      ];
}
