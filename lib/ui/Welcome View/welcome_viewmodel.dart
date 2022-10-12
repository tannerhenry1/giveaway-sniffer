import 'package:giveaway_sniffer/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.router.dart';

class WelcomeViewModel extends BaseViewModel {

  final _navigationService = locator<NavigationService>();

  void navigator() {
    _navigationService.navigateTo(Routes.gameListView);
  }
}