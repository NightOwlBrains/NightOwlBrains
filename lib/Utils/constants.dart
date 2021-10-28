import 'dart:io';

int videoslengthplay = 0;
const K_App_Name = "Catch the monkey";
const K_Empty_String = "";
const K_Play_Game = "Play Game";
const K_Rate_Us = "Rate Us";
const K_Play_Again = "Play Again";
const K_Prank_Again = "Go To Next Prank";
const K_Exit = "Exit";
const K_Start_Experience = "Start Experience";
const K_Intro_Texts = [
  "Instruction Of The Game Is To Catch The Monkey, When Its Moving Around The Screen..",
  "You Have Multiple Chances To Catch  The Monkey And If You Miss It, The Game Will Be Over!",
  "Share This Awesome Experience With Your Family & Friends.."
];
const K_Share_With_Friends = "Share With Friends";
const K_share_Pre_Text = "Hello, Try This New Game, It’s So Hard To Win!";
const K_Have_Fun = "Have fun!!!";
const K_Notification_Body =
    "We know you’ve miss pranking. Come have some fun today!";
var K_APP_URL = Platform.isAndroid
    ? "https://play.google.com/store/apps/details?id=com.night_owl_brains.catch_the_monkey"
    : "https://apps.apple.com/us/app/id1588028531";
const K_alert_dailog_message = "Go To The Next Prank!";
