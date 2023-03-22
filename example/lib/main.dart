import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DemoScreen(),
    );
  }
}

class DemoScreen extends StatelessWidget {
  const DemoScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("first app bar")),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MyHomePage(title: 'second appbar')),
                );
              },
              child: Text('tap')),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with ChangeNotifier {
  final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'q1yRzj0qdnA',
      flags: const YoutubePlayerFlags(autoPlay: true));

  @override
  void dispose() {
    // _controller.toggleFullScreenMode();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Function? rotate;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          rotate!();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          toggleScreenCallBack: (callback) => rotate = callback,
          controller: _controller,
          showVideoProgressIndicator: true,
          progressColors: const ProgressBarColors(
              playedColor: Colors.red, handleColor: Colors.red),
        ),
        builder: (context, player) {
          return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: Column(
                children: [
                  player,
                  ElevatedButton(
                    onPressed: () {
                      rotate!();
                    },
                    child: Text("Rotate"),
                  )
                ],
              )
              // YoutubePlayer(
              //   toggleScreenCallBack: (callback) => rotate = callback,
              //   controller: _controller,
              //   showVideoProgressIndicator: true,
              //   progressColors: const ProgressBarColors(
              //       playedColor: Colors.red, handleColor: Colors.red),
              // ),
              );
        },
      ),
    );
  }
}
