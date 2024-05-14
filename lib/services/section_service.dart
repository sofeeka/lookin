import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lookin_empat/repositories/i_section_repository.dart';
import 'package:lookin_empat/services/i_section_service.dart';
import '../models/section_dto.dart';
import '../widgets/section_widget.dart';

class SectionService implements ISectionService {
  SectionService();

  @override
  List<SectionWidget> getSectionWidgets({
    required List<QueryDocumentSnapshot<SectionDTO>> json,
    required double width,
    bool onPressedActive = false,
    Function(BuildContext, int)? onPressed,
  }) {

    List<SectionDTO> dtos = json.map((item) => item.data()).toList();

    List<SectionWidget> sections = dtos
        .map((dto) => SectionWidget(
              onPressed: onPressed ?? (c, i) => {},
              sectionDTO: dto,
              width: width,
            ))
        .toList();

    return sections;
  }
}
