import 'package:flutter/cupertino.dart';

class SectionDTO {
  SectionDTO({
    required this.id,
    required this.color,
    required this.name,
    this.iconData,
    this.svgIconPath,
  }) {
    assert(iconData != null || svgIconPath != null);
  }

  final int id;
  final Color color;
  final String name;

  // svgIcon will be selected if both svgIconPath and iconData are defined
  final String? svgIconPath;
  final IconData? iconData;
}
