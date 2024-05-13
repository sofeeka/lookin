import 'package:flutter/cupertino.dart';

class SectionDTO {
  SectionDTO({
    required this.id,
    required this.name,
    required this.color,
    this.iconData,
    this.svgIconPath,
  }) {
    assert(iconData != null || svgIconPath != null);
  }

  //todo optional add iconData
  SectionDTO.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as int,
          name: json['name']! as String,
          color: Color(json['color']! as int),
          svgIconPath: json['svgIconPath']! as String,
        );

  SectionDTO copyWith({
    int? id,
    String? name,
    Color? color,
    IconData? iconData,
    String? svgIconPath,
  }) {
    return SectionDTO(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
        iconData: iconData ?? this.iconData,
        svgIconPath: svgIconPath ?? this.svgIconPath);
  }

  //todo optional add iconData
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color.value,
      'svgIconPath': svgIconPath,
    };
  }

  final int id;
  final Color color;
  final String name;

  // svgIcon will be selected if both svgIconPath and iconData are defined
  final String? svgIconPath;
  final IconData? iconData;
}
