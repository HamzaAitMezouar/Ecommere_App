import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'Home.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/Logo.mp4')
      ..initialize().then((_) {
        setState(() {});
      })
      ..setVolume(0.0);
    playVid();
  }

  void playVid() async {
    _controller.play();
    await Future.delayed(const Duration(seconds: 4));
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : home(),
    );
  }
}
