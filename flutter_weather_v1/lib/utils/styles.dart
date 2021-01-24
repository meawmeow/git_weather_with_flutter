import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Styles {
  static final bocDecorationType1 = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment(-0.4, -0.8),
      stops: [0.0, 0.5, 0.5, 1],
      colors: [
        Colors.orange[100],
        Colors.orange[100],
        Colors.orange[200],
        Colors.orange[200],
      ],
      tileMode: TileMode.repeated,
    ),
    boxShadow: [
      BoxShadow(
          color: Colors.black.withAlpha(60),
          blurRadius: 5,
          offset: Offset(0, 8),
          spreadRadius: 2)
    ],
  );
  static final bocDecorationType2 = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.green, Colors.blue]),
    boxShadow: [
      BoxShadow(
          color: Colors.black.withAlpha(60),
          blurRadius: 5,
          offset: Offset(0, 8),
          spreadRadius: 2)
    ],
  );
  static final bocDecorationType3 = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.green, Colors.green]),
    boxShadow: [
      BoxShadow(
          color: Colors.black.withAlpha(60),
          blurRadius: 5,
          offset: Offset(0, 8),
          spreadRadius: 2)
    ],
  );
  static final bocDecorationType4 = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Colors.orange,
        Colors.orange,
      ],
    ),
    boxShadow: [
      BoxShadow(
          color: Colors.black.withAlpha(60),
          blurRadius: 5,
          offset: Offset(0, 8),
          spreadRadius: 2)
    ],
  );
  static final bocDecorationType5 = (position) => BoxDecoration(
        image: DecorationImage(
          image: new ExactAssetImage(
              'assets/images/b${(position + 1) >= 4 ? (1 + new Random().nextInt(5 - 1)) : (position + 1)}.png'),
          fit: BoxFit.fitHeight,
        ),
      );
  static final boxDecoration = (color) => BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              const Color(0xFFFF0064),
              const Color(0xFFFF7600),
              const Color(0xFFFFD500),
              const Color(0xFF8CFE00),
              const Color(0xFF00E86C),
              const Color(0xFF00F4F2),
              const Color(0xFF00CCFF),
              const Color(0xFF70A2FF),
              const Color(0xFFA96CFF),
            ],
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withAlpha(60),
                blurRadius: 5,
                offset: Offset(0, 8),
                spreadRadius: 2)
          ]);
}
