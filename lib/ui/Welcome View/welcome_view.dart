import 'package:flutter/material.dart';
import 'package:giveaway_sniffer/app/app.dart';
import 'package:giveaway_sniffer/ui/Welcome%20View/welcome_viewmodel.dart';
import 'package:stacked/stacked.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Twitch Giveaways!'),
        ),
        body: Center(
          child: IconButton(
            onPressed: () => model.navigator(),
            icon: const Icon(Icons.tag_faces_rounded, size: 50,),
          ),
        ),
      ),
      viewModelBuilder: () => WelcomeViewModel(),
    );
  }
}