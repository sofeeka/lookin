import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/section_dto.dart';
import '../widgets/section_widget.dart';

abstract class ISectionService {
  List<SectionWidget> getSectionWidgets({
    required List<QueryDocumentSnapshot<SectionDTO>> json,
    required double width,
    bool onPressedActive = false,
    Function(int)? onPressed,
  });
}
