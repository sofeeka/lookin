import 'package:cloud_firestore/cloud_firestore.dart';
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
    Function(int)? onPressed,
  }) {
    List<SectionDTO> dtos = json.map((item) => item.data()).toList();

    List<SectionWidget> sections = dtos
        .map((dto) => SectionWidget(
              onPressed: onPressed ?? (i) => {},
              sectionDTO: dto,
              width: width,
            ))
        .toList();

    return sections;
  }
}
