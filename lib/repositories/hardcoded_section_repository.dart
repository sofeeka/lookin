import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lookin_empat/repositories/i_section_repository.dart';
import '../models/section_dto.dart';
import '../style/colors.dart';

class HardCodedSectionRepository /*implements ISectionRepository*/ {
  static int staticIdCounter = 1;
  static List<SectionDTO>? sectionDTOs;

  static const String iconPathBase = 'lib/assets/icons/section/';

  static SectionDTO errorDTO = SectionDTO(
    id: 0,
    userId: 'no user',
    color: Colors.red,
    name: "error",
    iconData: Icons.error,
  );

  @override
  List<SectionDTO> initialiseSections() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    sectionDTOs = [
      SectionDTO(
        id: staticIdCounter++,
        userId: userId,
        color: CColors.yellow,
        name: 'T-shirts',
        svgIconPath: '${iconPathBase}t-shirt.svg',
      ),
      SectionDTO(
        id: staticIdCounter++,
        userId: userId,
        color: CColors.green,
        name: 'Shorts',
        svgIconPath: '${iconPathBase}shorts.svg',
      ),
      SectionDTO(
        id: staticIdCounter++,
        userId: userId,
        color: CColors.red,
        name: 'Caps',
        svgIconPath: '${iconPathBase}cap.svg',
      ),
      SectionDTO(
        id: staticIdCounter++,
        userId: userId,
        color: CColors.blue,
        name: 'Beanies',
        svgIconPath: '${iconPathBase}beanie.svg',
      ),
      SectionDTO(
        id: staticIdCounter++,
        userId: userId,
        color: CColors.teal,
        name: 'Blouses',
        svgIconPath: '${iconPathBase}blouse.svg',
      ),
    ];
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

  @override
  void add(SectionDTO model) {
    sectionDTOs?.add(model);
  }

  @override
  void delete(int id) {
    sectionDTOs?.removeWhere((element) => id == element.id);
  }

  @override
  Stream<QuerySnapshot<Object?>> get() {
    // TODO: implement getSections
    throw UnimplementedError();
  }

  @override
  void update(int id, SectionDTO dto) {
    // TODO: implement updateSection
    throw UnimplementedError();
  }
}
