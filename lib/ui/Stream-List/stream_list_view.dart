import 'package:flutter/material.dart';
import 'package:giveaway_sniffer/ui/Stream-List/stream_list_viewmodel.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:stacked/stacked.dart';

import '../../models/game.dart';

class StreamListView extends StatelessWidget {
  final Game selection;
  const StreamListView({Key? key, required this.selection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StreamListViewModel>.reactive(
      onModelReady: (model) => model.initialise(selection),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Top Streamers in ${selection.name}',
          ),
        ),
        body: LoadingOverlay(
          isLoading: model.isLoading,
          child: ListView.builder(
            itemCount: model.twitchStream.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => model.displayData(),
                child: SizedBox(
                  height: 100,
                  child: Card(
                    key: ValueKey(model.twitchStream[index].userName),
                    shadowColor: Colors.deepPurpleAccent,
                    margin: const EdgeInsets.all(5.0),
                    elevation: 10.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          model.twitchStream[index].userName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Giveaway: ${model.twitchStream[index].giveaway}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      viewModelBuilder: () => StreamListViewModel(),
    );
  }
}
