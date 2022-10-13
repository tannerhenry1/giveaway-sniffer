import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:stacked/stacked.dart';

import 'game_list_viewmodel.dart';

class GameListView extends StatelessWidget {
  const GameListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GameListViewModel>.reactive(
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Top Games List'),
          actions: [
            model.isLoadingAppbar
                ? const Center(
                  child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                )
                : IconButton(
                    onPressed: () => model.fetchAllLiveGiveaways(),
                    icon: const Icon(Icons.downloading))
          ],
        ),
        body: LoadingOverlay(
          isLoading: model.isLoading,
          child: ListView.builder(
            itemCount: model.topGames.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => model.fetchStreams(model.topGames[index]),
                child: SizedBox(
                  height: 100,
                  child: Card(
                    key: ValueKey(model.topGames[index].name),
                    shadowColor: Colors.deepPurpleAccent,
                    margin: const EdgeInsets.all(5.0),
                    elevation: 10.0,
                    child: Center(
                      child: Text(
                        model.topGames[index].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      viewModelBuilder: () => GameListViewModel(),
    );
  }
}
