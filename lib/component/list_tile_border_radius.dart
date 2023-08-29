import 'package:flutter/material.dart';

class ListTileBorderRadius extends BorderRadius {
  ListTileBorderRadius.all(Radius radius) : super.all(radius);
  static double defaultRadius = 15;
  static get none => BorderRadius.zero;
  static get full => BorderRadius.circular(defaultRadius);

  static get onlyTopLeft =>
      BorderRadius.only(topLeft: Radius.circular(defaultRadius));
  static get onlyTopRight =>
      BorderRadius.only(topRight: Radius.circular(defaultRadius));

  static get onlyBottom => BorderRadius.only(
      bottomLeft: Radius.circular(defaultRadius),
      bottomRight: Radius.circular(defaultRadius));
  static get onlyTop => BorderRadius.only(
      topLeft: Radius.circular(defaultRadius),
      topRight: Radius.circular(defaultRadius));
}
