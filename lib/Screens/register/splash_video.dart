import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iskcon/Utils/contants.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:video_player/video_player.dart';

import '../../Utils/pref_manager.dart';
import '../../widgets/gradientButton.dart';

class SplashVideo extends StatefulWidget {
  const SplashVideo({Key? key}) : super(key: key);

  @override
  State<SplashVideo> createState() => _SplashVideoState();
}

class _SplashVideoState extends State<SplashVideo> {
  static final videoPlayerController = VideoPlayerController.network(
    'https://player.vimeo.com/external/464508537.sd.mp4?s=206f33573237e20f260d4474ec6ce2957ed9ae8e&profile_id=165&oauth2_token_id=57447761',
  );
// await videoPlayerController.initialize();

  final chewieController = ChewieController(
    videoPlayerController: videoPlayerController,
    // aspectRatio: 4 / 3,
    // placeholder: CircularProgressIndicator(backgroundColor: primaryColor),
    autoPlay: true,
    looping: true,
    showOptions: false,
    showControlsOnInitialize: false,
    showControls: false,
  );

// final playerWidget = Chewie(
//   controller: chewieController,
// );
  // bool _visible = false;
  // VideoPlayerController? _controller;
  @override
  void initState() {
    Preferences.init();
    super.initState();
    setState(() {});
    // startTimer();
    // _controller = VideoPlayerController.asset("assets/videos/sample.mp4");
    // _controller?.initialize().then((_) {
    //   _controller!.setLooping(true);
    //   Timer(Duration(milliseconds: 100), () {
    //     setState(() {
    //       _controller!.play();
    //       _visible = true;
    //     });
    //   });
    // });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
    // if (_controller != null) {
    //   _controller!.dispose();
    //   _controller = null;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.9),
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.fill,
              child: SizedBox(
                width: videoPlayerController.value.size.width,
                height: videoPlayerController.value.size.height,
                child: VideoPlayer(videoPlayerController),
              ),
            ),
          ),
          _getContent()
        ],
      ),
    );
  }

  _getVideoBackground() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Chewie(
          controller: chewieController,
        ),
      ],
    );
  }

  _getBackgroundColor() {
    return Container(
      color: Colors.blue.withAlpha(120),
    );
  }

  _getContent() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[..._getLoginButtons()],
      ),
    );
  }

  _getLoginButtons() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return <Widget>[
      GradientButton(
        gradient: gradientOpp,
        name: "Login",
        size: Size(width * 0.9, height * 0.06),
        onPress: () async {
          var result = await (Connectivity().checkConnectivity());
          if (result == ConnectivityResult.wifi ||
              result == ConnectivityResult.mobile) {
            Get.offAllNamed(ROUTE_LOGIN);
            dispose();
          } else {
            Get.snackbar('Internet', 'No Internet Connection',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white);
          }
        },
        border: false,
        fontSize: 18,
      ),
      SizedBox(height: height * 0.02),
      GradientButton(
        name: "Sign Up",
        size: Size(width * 0.9, height * 0.06),
        onPress: () async {
          var result = await (Connectivity().checkConnectivity());
          if (result == ConnectivityResult.wifi ||
              result == ConnectivityResult.mobile) {
            Get.toNamed(ROUTE_REGISTER);
            dispose();
          } else {
            Get.snackbar('Internet', 'No Internet Connection',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white);
          }
        },
        border: false,
        fontSize: 18,
      ),
      SizedBox(height: height * 0.10),
    ];
  }
}


/*import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:video_player/video_player.dart';

import '../../Utils/pref_manager.dart';

class SplashVideo extends StatefulWidget {
  const SplashVideo({Key? key}) : super(key: key);

  @override
  State<SplashVideo> createState() => _SplashVideoState();
}

class _SplashVideoState extends State<SplashVideo> {
  static final videoPlayerController = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
// await videoPlayerController.initialize();

  final chewieController = ChewieController(
    videoPlayerController: videoPlayerController,
    // placeholder: CircularProgressIndicator(backgroundColor: primaryColor),
    autoPlay: true,
    looping: true,
    showOptions: false,
    showControlsOnInitialize: false,
    showControls: false,
  );

// final playerWidget = Chewie(
//   controller: chewieController,
// );
  // bool _visible = false;
  // VideoPlayerController? _controller;
  @override
  void initState() {
    Preferences.init();
    super.initState();
    // startTimer();
    // _controller = VideoPlayerController.asset("assets/videos/sample.mp4");
    // _controller?.initialize().then((_) {
    //   _controller!.setLooping(true);
    //   Timer(Duration(milliseconds: 100), () {
    //     setState(() {
    //       _controller!.play();
    //       _visible = true;
    //     });
    //   });
    // });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
    // if (_controller != null) {
    //   _controller!.dispose();
    //   _controller = null;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            // _getBackgroundColor(),
            // Positioned(
            //   top: 0,
            // child:
            _getVideoBackground(),
            // ),
            Positioned(
              child: _getContent(),
            )
          ],
        ),
      ),
    );
  }

  _getVideoBackground() {
    return Chewie(
      controller: chewieController,
    );
  }

  _getBackgroundColor() {
    return Container(
      color: Colors.blue.withAlpha(120),
    );
  }

  _getContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Spacer(),
        ..._getLoginButtons()
      ],
    );
  }

  _getLoginButtons() {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        width: double.infinity,
        child: TextButton(
          // color: Colors.white,
          // padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: const Text('Sign Up with Email'),
          onPressed: () async {},
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        width: double.infinity,
        child: TextButton(
          // color: Colors.blueAccent,
          // padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: const Text(
            'Log back in',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {},
        ),
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 16, top: 20, left: 20, right: 20),
        width: double.infinity,
        child: TextButton(
          child: const Text(
            'Later...',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {},
        ),
      ),
    ];
  }
}
 */