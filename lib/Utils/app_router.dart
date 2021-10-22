import 'package:flutter/material.dart';

class AppRouter {
  static push(BuildContext context, Widget nextPage) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => nextPage));
  }

  static pushOpaque(BuildContext context, Widget nextPage) {
    Navigator.push(
        context,
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) => nextPage));
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }

  static makeFirst(BuildContext context, Widget nextPage) {
    Navigator.of(context).popUntil((predicate) => predicate.isFirst);
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute(builder: (context) => nextPage),
    );
  }
}
