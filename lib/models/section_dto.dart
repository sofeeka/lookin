import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SectionDTO {
  SectionDTO({
    required this.id,
    required this.userId,
    required this.name,
    required this.color,
    this.iconData,
    this.svgIconPath,
  }) {
    assert(iconData != null || svgIconPath != null);
  }

  factory SectionDTO.fromJson(Map<String, dynamic> json) {
    IconData? iconData =
        isSVGPathValid(json['svgIconPath']) ? null : Icons.error;
    return SectionDTO(
      id: json['id']! as int,
      userId: json['userId']! as String,
      name: json['name']! as String,
      color: Color(json['color']! as int),
      svgIconPath: (json['svgIconPath']) == null
          ? null
          : (json['svgIconPath']) as String,
      iconData: iconData,
    );
  }

  SectionDTO copyWith({
    int? id,
    String? userId,
    String? name,
    Color? color,
    IconData? iconData,
    String? svgIconPath,
  }) {
    return SectionDTO(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        color: color ?? this.color,
        iconData: iconData ?? this.iconData,
        svgIconPath: svgIconPath ?? this.svgIconPath);
  }

  //todo optional add iconData
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId' : userId,
      'name': name,
      'color': color.value,
      'svgIconPath': svgIconPath,
    };
  }

  final int id;
  final String userId;
  final Color color;
  final String name;

  // svgIcon will be selected if both svgIconPath and iconData are defined
  final String? svgIconPath;
  final IconData? iconData;

  static bool isSVGPathValid(String? svgPath) {
    try {
      SvgPicture.string(svgPath!);
      return true;
    } catch (e) {
      return false;
    }
  }
}
