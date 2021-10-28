import 'package:catch_the_monkey/Utils/app_colors.dart';
import 'package:catch_the_monkey/Utils/app_router.dart';
import 'package:catch_the_monkey/Utils/constants.dart';
import 'package:catch_the_monkey/Utils/images.dart';
import 'package:catch_the_monkey/Widgets/background_container.dart';
import 'package:catch_the_monkey/Widgets/buttons.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'welcome.dart';

class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late FirebaseMessaging messaging;
  String? notificationText;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic("messaging");
    messaging.getToken().then((value) {
      print(value);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.title);

      print(event.notification!.body);
      print(event.data.values);
      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         title: Text(event.notification!.title!),
      //         content: Text(event.notification!.body!),
      //         actions: [
      //           TextButton(
      //             child: Text("Ok"),
      //             onPressed: () {
      //               Navigator.of(context).pop();
      //             },
      //           )
      //         ],
      //       );
      //     });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }

  final List<PageViewModel> _introImagesList = [
    PageViewModel(
      title: K_Empty_String,
      bodyWidget: Column(
        children: [
          Image.asset(
            Images.intro,
            height: 335.sp,
            width: 253.sp,
          ),
          Padding(
            padding: EdgeInsets.only(top: 60.h, left: 24.w, right: 24.w),
            child: Text(K_Intro_Texts[0],
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    ),
    PageViewModel(
      title: K_Empty_String,
      bodyWidget: Column(
        children: [
          Image.asset(
            Images.gameOverCard,
            height: 335.sp,
            width: 253.sp,
          ),
          Padding(
            padding: EdgeInsets.only(top: 60.h, left: 24.w, right: 24.w),
            child: Text(K_Intro_Texts[1],
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    ),
    PageViewModel(
      title: K_Empty_String,
      bodyWidget: Column(
        children: [
          Image.asset(
            Images.shareCard,
            height: 335.sp,
            width: 253.sp,
          ),
          Padding(
            padding: EdgeInsets.only(top: 60.h, left: 24.w, right: 24.w),
            child: Text(K_Intro_Texts[2],
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    )
  ];

  late final BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      body: BackgroundContainer(
        child: _body(),
        image: Images.background2,
      ),
    );
  }

  Widget _body() {
    return IntroductionScreen(
        globalBackgroundColor: Colors.transparent,
        pages: _introImagesList,
        dotsDecorator: const DotsDecorator(
          size: Size(7, 7),
          color: AppColors.gray,
          activeSize: Size(25, 7),
          activeColor: AppColors.yellow,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        globalFooter: Column(
          children: [
            Button(K_Start_Experience, () {
              AppRouter.makeFirst(_context, const Welcome());
            }),
            SizedBox(height: 43.h),
          ],
        ),
        showDoneButton: false,
        showNextButton: false);
  }
}
