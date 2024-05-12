import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lookin_empat/models/section_dto.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget({
    super.key,
    required this.onPressed,
    this.onPressedActive = true,
    required this.sectionDTO,
    required this.width,
  });

  final SectionDTO sectionDTO;
  final Function(int) onPressed;
  final bool? onPressedActive;
  final double width;

  // size of the icon relative to the size of the whole section widget
  static const iconRelativeSizeMultiplier = 0.5;
  static const aspectRatio = 3 / 4;

  @override
  Widget build(BuildContext context) {
    var iconWidget = sectionDTO.svgIconPath == null
        ? Icon(
            sectionDTO.iconData,
            size: width * iconRelativeSizeMultiplier,
            color: getOutlineColor(sectionDTO.color),
          )
        : SvgPicture.asset(
            sectionDTO.svgIconPath!,
            color: getOutlineColor(sectionDTO.color),
            width: width * iconRelativeSizeMultiplier,
          );

    return GestureDetector(
      onTap: () {
        onPressed(sectionDTO.id);
      },
      child: SizedBox(
        width: width,
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Container(
            decoration: BoxDecoration(
              color: sectionDTO.color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  sectionDTO.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: getOutlineColor(sectionDTO.color),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                iconWidget,
                const SizedBox(height: 4),
                Text(
                  "Count: --", // todo add section count (maybe by sectionDTO.id)
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: getOutlineColor(sectionDTO.color),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getOutlineColor(Color color) {
    int darkerShade = -100;
    return Color.fromARGB(
      color.alpha,
      (color.red + darkerShade).clamp(0, 255),
      (color.green + darkerShade).clamp(0, 255),
      (color.blue + darkerShade).clamp(0, 255),
    );
  }
}
