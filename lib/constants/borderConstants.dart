import 'package:flutter/material.dart';

class BorderConstants {
  static BorderConstants instance = BorderConstants._init();

  BorderConstants._init();

  final youtubeButtonCircular = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  );

  final wikipediaButtonCircular = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  );
}
