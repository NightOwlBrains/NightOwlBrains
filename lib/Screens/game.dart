import 'dart:async';
import 'dart:math';

import 'package:catch_the_monkey/Services/music_service.dart';
import 'package:catch_the_monkey/Utils/app_colors.dart';
import 'package:catch_the_monkey/Utils/assets.dart';
import 'package:catch_the_monkey/Utils/constants.dart';
import 'package:catch_the_monkey/Utils/images.dart';
import 'package:catch_the_monkey/Widgets/background_container.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'horror.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> with TickerProviderStateMixin {
  Timer? _timer;
  double? _top = 0;
  double? _bottom = 0;
  double height = 70.h;
  double width = 70.w;
  int run = 1;
  var rng;
  static int videoNumber = 0;
  VideoPlayerController? _videoPlayerController;
  int _milliSeconds = 0;
  int counter = 0;
  bool movingState = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      return showDialog(
          barrierColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            Future.delayed(Duration(seconds: 4), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              backgroundColor: Colors.transparent,
              actions: [Image.asset("assets/images/monkeygif.gif")],
            );
          });
    });
    _setTimer();
    _sizeTimer();
    _initiateVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body());
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  _sizeTimer() {
    Timer timer = Timer.periodic(const Duration(milliseconds: 170), (timer) {
      setState(() {
        height--;
        // ignore: avoid_print
        print(height);
        width--;
        // ignore: avoid_print
        print(width);
        if (width < 50.w && height < 50.h) {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer = null;
    _videoPlayerController!.dispose();
    super.dispose();
  }

  _body() {
    return BackgroundContainer(
      image: Images.background4,
      child: Stack(
        children: [
          GestureDetector(
            onPanStart: (_) {
              // counter++;
              // MusicService().stopAllAudio();
              // MusicService().playGameOverMusic();
              // Navigator.push(
              //   context,
              //   PageTransition(
              //     type: PageTransitionType.bottomToTop,
              //     duration: Duration(milliseconds: 1),
              //     child: GameOver(),
              //   ),
              // ).then((value) {
              //   MusicService().stopAllAudio();
              //   MusicService().playMonkeyMusic();
              //   _setTimer();
              // });
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.transparent,
            ),
          ),
          if (movingState) ...[
            AnimatedPositioned(
              top: _top,
              left: _bottom,
              duration: Duration(milliseconds: 170 + (counter * 10)),
              child: InkWell(
                onTap: () {
                  MusicService().stopAllAudio();
                  setState(() {
                    movingState = false;
                  });
                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     PageTransition(
                  //         type: PageTransitionType.fade,
                  //         duration: const Duration(microseconds: 0),
                  //         child: Horror(_videoPlayerController!, _milliSeconds)),
                  //     (route) => false);
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          duration: const Duration(microseconds: 0),
                          child: Horror(_videoPlayerController!, _milliSeconds,
                              context)));
                },
                child: Image.asset(
                  Images.monkey,
                  height: height,
                  width: width,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ] else ...[
            Container(),
          ],
        ],
      ),
    );
  }

  void _setTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(
        Duration(milliseconds: (run % 10 == 0) ? 400 : 100 + (counter * 10)),
        (Timer t) {
      var range = Random();
      setState(() {
        int height = MediaQuery.of(context).size.height.toInt() - 60;
        int width = MediaQuery.of(context).size.width.toInt() - 50;
        _top = range.nextInt(height).toDouble();
        _bottom = range.nextInt(width).toDouble() / 1.5;
      });
      run++;
      t.cancel();
      _setTimer();
    });
  }

  _initiateVideo() {
    if (videoNumber == Assets.horrorVideos.length) {
      videoNumber = 0;
    }

    String video = Assets.horrorVideos[videoNumber];
    videoNumber++;
    videoslengthplay = videoNumber;
    _videoPlayerController = VideoPlayerController.asset(video);
    _videoPlayerController?.setPlaybackSpeed(2);
  }
}
