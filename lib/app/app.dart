import 'package:giveaway_sniffer/services/http_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../ui/Game-List/game_list_view.dart';
import '../ui/Stream-List/stream_list_view.dart';
import '../ui/Welcome View/welcome_view.dart';

// flutter pub run build_runner build --delete-conflicting-outputs

@StackedApp(routes: [
  MaterialRoute(page: WelcomeView, initial: true),
  MaterialRoute(page: GameListView),
  MaterialRoute(page: StreamListView),
], dependencies: [
  Singleton(classType: NavigationService),
  LazySingleton(classType: HttpService),
], logger: StackedLogger())
class App {}
