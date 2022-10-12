import 'package:giveaway_sniffer/app/app.locator.dart';
import 'package:giveaway_sniffer/services/http_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.logger.dart';
import '../../app/app.router.dart';
import '../../models/game.dart';

class GameListViewModel extends ReactiveViewModel {
  final _httpService = locator<HttpService>();
  final _navigataionService = locator<NavigationService>();
  final log = getLogger('GameListView');

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Game> get topGames => _httpService.topGames;

  void initialise() {
    _isLoading = true;
    notifyListeners();

    // Fetch Credentials and GameIds
    _httpService.fetchGameIds();

    _isLoading = false;
    notifyListeners();
  }

  void logg(int index) {
    log.i(index);
  }

  void fetchStreams(Game selection) {
    log.i('Selection: ${selection.name}');
    _navigataionService.navigateTo(Routes.streamListView,
        arguments: StreamListViewArguments(selection: selection));
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [
        _httpService,
      ];
}
