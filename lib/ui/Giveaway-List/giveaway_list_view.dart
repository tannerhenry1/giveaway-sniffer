import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:stacked/stacked.dart';

import '../../models/stream.dart';
import 'giveaway_list_viewmodel.dart';

class GiveawayListView extends StatelessWidget {
  final List<Streams> streamsWithGiveaways;
  const GiveawayListView({Key? key, required this.streamsWithGiveaways})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GiveawayListViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Streamers with giveaways',
          ),
        ),
        body: ListView.builder(
          itemCount: streamsWithGiveaways.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 100,
              child: Card(
                key: ValueKey(streamsWithGiveaways[index].userName),
                shadowColor: Colors.deepPurpleAccent,
                margin: const EdgeInsets.all(5.0),
                elevation: 10.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      streamsWithGiveaways[index].userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      streamsWithGiveaways[index].viewerCount.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      viewModelBuilder: () => GiveawayListViewModel(),
    );
  }
}
