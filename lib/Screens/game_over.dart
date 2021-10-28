import 'dart:io';
import 'package:catch_the_monkey/Screens/welcome.dart';
import 'package:catch_the_monkey/Services/music_service.dart';
import 'package:catch_the_monkey/Utils/app_colors.dart';
import 'package:catch_the_monkey/Utils/app_router.dart';
import 'package:catch_the_monkey/Utils/constants.dart';
import 'package:catch_the_monkey/Utils/images.dart';
import 'package:catch_the_monkey/Widgets/background_container.dart';
import 'package:catch_the_monkey/Widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

class GameOver extends StatefulWidget {
  const GameOver({Key? key}) : super(key: key);

  @override
  State<GameOver> createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  BuildContext? _buildContext;
  // InterstitialAd? _interstitialAd;
  // bool isAddLoaded = false;

  // String _adUnitID() {
  //   if (Platform.isAndroid) return "ca-app-pub-8167936072500546/2294696788";
  //   return "ca-app-pub-8167936072500546/1353150209";
  // }

  _navigateToWelcomeScreen() async {
    AppRouter.pop(_buildContext!);
    Vibration.cancel();
    MusicService().stopAllAudio();
    await MusicService().playMonkeyMusic();
    AppRouter.makeFirst(
        _buildContext!,
        const Welcome(
          isFirst: false,
        ));
  }

  @override
  void initState() {
    // InterstitialAd.load(
    //     adUnitId: _adUnitID(),
    //     request: const AdRequest(),
    //     adLoadCallback: InterstitialAdLoadCallback(
    //       onAdLoaded: (InterstitialAd ad) {
    //         _interstitialAd = ad;
    //         setState(() => isAddLoaded = true);
    //         _interstitialAd?.fullScreenContentCallback =
    //             FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
    //           _navigateToWelcomeScreen();
    //           _interstitialAd = null;
    //         });
    //       },
    //       onAdFailedToLoad: (LoadAdError error) {
    //         // ignore: avoid_print
    //         print('InterstitialAd failed to load: $error');
    //       },
    //     ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return WillPopScope(
      onWillPop: () async {
        return _navigateToWelcomeScreen();
      },
      child: Scaffold(
        body: BackgroundContainer(
          child:
              // isAddLoaded
              // ?
              _body(),
          // : const Center(
          //     child: CircularProgressIndicator(
          //     color: Colors.red,
          //   )),
          image: Images.background5,
        ),
      ),
    );
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
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          Images.gameOver,
          height: 129.h,
          width: 180.w,
        ),
        Column(
          children: [
            Button(K_Prank_Again, () {
              // AppRouter.pop(_buildContext);
              // if (_interstitialAd == null) {

              _navigateToWelcomeScreen();
              // } else {
              //   _interstitialAd?.show();
              // }
            }),
            // SizedBox(height: 14.h),
            // Button(K_Rate_Us, _ratePressed,
            //     textColor: Colors.white,
            //     backgroundColor: Colors.transparent,
            //     borderColor: AppColors.white),
            // SizedBox(height: 43.h),
          ],
        )
      ],
    );
  }

  Future<void> _ratePressed() async {
    if (await canLaunch(K_APP_URL)) await launch(K_APP_URL);
  }
}
