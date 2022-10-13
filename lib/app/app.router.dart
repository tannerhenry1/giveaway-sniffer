// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i6;
import 'package:flutter/material.dart';
import 'package:giveaway_sniffer/models/game.dart' as _i7;
import 'package:giveaway_sniffer/models/stream.dart' as _i8;
import 'package:giveaway_sniffer/ui/Game-List/game_list_view.dart' as _i3;
import 'package:giveaway_sniffer/ui/Giveaway-List/giveaway_list_view.dart'
    as _i5;
import 'package:giveaway_sniffer/ui/Stream-List/stream_list_view.dart' as _i4;
import 'package:giveaway_sniffer/ui/Welcome%20View/welcome_view.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i9;

class Routes {
  static const welcomeView = '/';

  static const gameListView = '/game-list-view';

  static const streamListView = '/stream-list-view';

  static const giveawayListView = '/giveaway-list-view';

  static const all = <String>{
    welcomeView,
    gameListView,
    streamListView,
    giveawayListView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.welcomeView,
      page: _i2.WelcomeView,
    ),
    _i1.RouteDef(
      Routes.gameListView,
      page: _i3.GameListView,
    ),
    _i1.RouteDef(
      Routes.streamListView,
      page: _i4.StreamListView,
    ),
    _i1.RouteDef(
      Routes.giveawayListView,
      page: _i5.GiveawayListView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.WelcomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.WelcomeView(),
        settings: data,
      );
    },
    _i3.GameListView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.GameListView(),
        settings: data,
      );
    },
    _i4.StreamListView: (data) {
      final args = data.getArgs<StreamListViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i4.StreamListView(key: args.key, selection: args.selection),
        settings: data,
      );
    },
    _i5.GiveawayListView: (data) {
      final args = data.getArgs<GiveawayListViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i5.GiveawayListView(
            key: args.key, streamsWithGiveaways: args.streamsWithGiveaways),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class StreamListViewArguments {
  const StreamListViewArguments({
    this.key,
    required this.selection,
  });

  final _i6.Key? key;

  final _i7.Game selection;
}

class GiveawayListViewArguments {
  const GiveawayListViewArguments({
    this.key,
    required this.streamsWithGiveaways,
  });

  final _i6.Key? key;

  final List<_i8.Streams> streamsWithGiveaways;
}

extension NavigatorStateExtension on _i9.NavigationService {
  Future<dynamic> navigateToWelcomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.welcomeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGameListView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.gameListView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStreamListView({
    _i6.Key? key,
    required _i7.Game selection,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.streamListView,
        arguments: StreamListViewArguments(key: key, selection: selection),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGiveawayListView({
    _i6.Key? key,
    required List<_i8.Streams> streamsWithGiveaways,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.giveawayListView,
        arguments: GiveawayListViewArguments(
            key: key, streamsWithGiveaways: streamsWithGiveaways),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
