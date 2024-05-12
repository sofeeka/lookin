import 'package:flutter/material.dart';
import 'package:lookin_empat/repositories/i_section_repository.dart';
import '../models/section_dto.dart';

class SectionRepository implements ISectionRepository {
  static int staticIdCounter = 1;
  static List<SectionDTO>? sectionDTOs;

  static const String iconPathBase = 'lib/assets/icons/section/';
  static const double defaultWidth = 50;

  static SectionDTO errorDTO = SectionDTO(
    id: 0,
    color: Colors.red,
    name: "Error",
    iconData: Icons.error,
  );

  @override
  List<SectionDTO> initialiseSections() {
    var temp = [
      SectionDTO(
        id: staticIdCounter++,
        color: Colors.yellow,
        name: 'T-shirts',
        svgIconPath: '${iconPathBase}t-shirt.svg',
      ),
      SectionDTO(
        id: staticIdCounter++,
        color: Colors.green,
        name: 'Shorts',
        svgIconPath: '${iconPathBase}shorts.svg',
      ),
      SectionDTO(
        id: staticIdCounter++,
        color: Colors.red,
        name: 'Caps',
        svgIconPath: '${iconPathBase}cap.svg',
      ),
      SectionDTO(
        id: staticIdCounter++,
        color: Colors.blue,
        name: 'Beanies',
        svgIconPath: '${iconPathBase}beanie.svg',
      ),
      SectionDTO(
        id: staticIdCounter++,
        color: Colors.yellow,
        name: 'Blouses',
        svgIconPath: '${iconPathBase}blouse.svg',
      ),
    ];
    sectionDTOs = [];
    sectionDTOs!.addAll(temp);
    return sectionDTOs!;
  }

  @override
  SectionDTO? getByID(int id) {
    if (sectionDTOs == null) {
      return null;
    }

    for (SectionDTO section in sectionDTOs!) {
      if (section.id == id) {
        return section;
      }
    }
    return null;
  }

  @override
  SectionDTO getByIndex(int i) {
    if (sectionDTOs == null) {
      return errorDTO;
    }

    if (i < sectionDTOs!.length) {
      return sectionDTOs![i];
    }

    return errorDTO;
  }
}
