import 'dart:io';
import 'package:catch_the_monkey/Screens/game_over.dart';
import 'package:catch_the_monkey/Services/music_service.dart';
import 'package:catch_the_monkey/Utils/app_colors.dart';
import 'package:catch_the_monkey/Utils/app_router.dart';
import 'package:catch_the_monkey/Utils/constants.dart';
import 'package:catch_the_monkey/Widgets/buttons.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vibration/vibration.dart';
import 'package:video_player/video_player.dart';

import 'welcome.dart';

class Horror extends StatefulWidget {
  VideoPlayerController _videoPlayerController;
  int _milliseconds;
  Horror(this._videoPlayerController, this._milliseconds);
  @override
  State<Horror> createState() => _HorrorState();
}

class _HorrorState extends State<Horror> {
  // InterstitialAd? _interstitialAd;
  bool _isShown = false;
  @override
  void initState() {
    // InterstitialAd.load(
    //     adUnitId: _adUnitID(),
    //     request: const AdRequest(),
    //     adLoadCallback: InterstitialAdLoadCallback(
    //       onAdLoaded: (InterstitialAd ad) {
    //         _interstitialAd = ad;
    //         _interstitialAd?.fullScreenContentCallback =
    //             FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
    //           _navigateToWelcomeScreen();
    //         });
    //       },
    //       onAdFailedToLoad: (LoadAdError error) {
    //         print('InterstitialAd failed to load: $error');
    //       },
    //     ));
    _intializeVideo();
    super.initState();
  }

  @override
  void dispose() {
    // _videoPlayerController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Vibration.vibrate(
    //     duration: widget._videoPlayerController.value.duration.inMilliseconds);
    return Scaffold(
      backgroundColor: Colors.transparent,
      // ignore: sized_box_for_whitespace
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: AspectRatio(
              aspectRatio: widget._videoPlayerController.value.aspectRatio,
              child: VideoPlayer(widget._videoPlayerController),
            ),
          ),
        ),
      ),
    );
  }

  void _intializeVideo() {
    widget._videoPlayerController.setPlaybackSpeed(2);
    widget._videoPlayerController.addListener(() {
      Vibration.vibrate();
      if (!widget._videoPlayerController.value.isPlaying &&
          widget._videoPlayerController.value.isInitialized &&
          (widget._videoPlayerController.value.duration ==
              widget._videoPlayerController.value.position)) {
        if (!_isShown) {
          _isShown = true;
          // _showAlertDialog();
          AppRouter.pop(context);
          AppRouter.push(context, const GameOver());
        }
      }
    });
    widget._videoPlayerController.initialize().then((_) => setState(() {}));
    widget._videoPlayerController.play();
  }

  String _adUnitID() {
    print("hhhhhhhhh");
    print(Platform.isIOS);
    if (Platform.isAndroid) {
      return "ca-app-pub-8167936072500546/2294696788";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8167936072500546/1353150209";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }

    // if (Platform.isAndroid) return "ca-app-pub-8167936072500546/2294696788";
    // return "ca-app-pub-8167936072500546/1353150209";
  }

  _navigateToWelcomeScreen() async {
    Vibration.cancel();
    MusicService().stopAllAudio();
    await MusicService().playMonkeyMusic();
    AppRouter.makeFirst(context, Welcome());
  }

  _showAlertDialog() async {
    var dialog = AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      insetPadding: EdgeInsets.only(top: 16.h),
      contentPadding: EdgeInsets.only(top: 16.h),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Text(K_alert_dailog_message,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.black)),
      actions: [
        Button("Play", () {
          AppRouter.pop(context);
          // if (_interstitialAd == null) {
          //   _navigateToWelcomeScreen();
          // } else {
          //   _interstitialAd?.show();
          // }
        })
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }
}
