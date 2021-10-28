import 'package:catch_the_monkey/Utils/app_colors.dart';
import 'package:catch_the_monkey/Utils/app_router.dart';
import 'package:catch_the_monkey/Utils/constants.dart';
import 'package:catch_the_monkey/Utils/images.dart';
import 'package:catch_the_monkey/Widgets/background_container.dart';
import 'package:catch_the_monkey/Widgets/buttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'game.dart';

class Welcome extends StatefulWidget {
  final bool isFirst;
  const Welcome({Key? key, this.isFirst = true}) : super(key: key);
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  BuildContext? _context;
  final InAppReview inAppReview = InAppReview.instance;

  @override
  void initState() {
    // if (widget.isFirst) {
    //   WidgetsBinding.instance!.addPostFrameCallback((_) => _showAlertDialog());
    // }
    if (videoslengthplay == 1) {
      _showRatingAppDialog();
    }

    super.initState();
  }

  _showRatingAppDialog() async {
    await Future.delayed(Duration(milliseconds: 100));
    final _ratingDialog = RatingDialog(
      title: Text("Catch The Monkey"),
      image: Image.asset(
        "assets/images/monkey.png",
        height: 100,
      ),
      submitButtonText: "Submit",
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, '
            'comment: ${response.comment}');

        if (response.rating < 3.0) {
          print('response.rating: ${response.rating}');
        } else {
          StoreRedirect.redirect(
              androidAppId: 'com.night_owl_brains.catch_the_monkey',
              iOSAppId: 'com.nightowlbrains.catchthemonkey');
        }
      },
    );

    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      body: BackgroundContainer(
        child: _body(),
        image: Images.background3,
      ),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 60.h),
          child: Image.asset(
            Images.catchTheMonkey,
            height: 66.h,
            width: 234.w,
          ),
        ),
        Image.asset(
          Images.monkey,
          height: 70.h,
          width: 70.w,
        ),
        Column(
          children: [
            Button(K_Play_Game, () {
              AppRouter.push(_context!, Game());
            }),
            SizedBox(height: 14.h),
            Button(K_Rate_Us, _ratePressed,
                textColor: Colors.white,
                backgroundColor: Colors.transparent,
                borderColor: AppColors.white),
            SizedBox(height: 14.h),
            Button(K_Share_With_Friends, _sharePressed,
                textColor: Colors.white,
                backgroundColor: Colors.transparent,
                borderColor: AppColors.white),
            SizedBox(height: 43.h),
          ],
        )
      ],
    );
  }

  _showAlertDialog() async {
    var dialog = AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      insetPadding:
          EdgeInsets.only(top: 16.h, bottom: 16.h, left: 16.h, right: 16.h),
      contentPadding:
          EdgeInsets.only(top: 16.h, bottom: 16.h, right: 16.h, left: 16.h),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: const Text('Sound Effects Will Help,\nTurn Up Volume',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.black)),
      actions: [
        SizedBox(
          width: 160.h,
          child: Button("OK", () {
            AppRouter.pop(context);
          }),
        )
      ],
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }

  void _sharePressed() {
    final Size size = MediaQuery.of(context).size;
    Share.share(K_share_Pre_Text + " " + K_APP_URL,
        sharePositionOrigin: Rect.fromLTWH(0, 0, size.width, size.height / 2));
  }

  Future<void> _ratePressed() async {
    if (await canLaunch(K_APP_URL)) await launch(K_APP_URL);
  }
}
