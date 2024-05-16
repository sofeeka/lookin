import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lookin_empat/models/item_dto.dart';
import 'package:lookin_empat/widgets/scrollable_section_widget.dart';

abstract class IItemService {
  List<ScrollableSectionWidget> getScrollableSectionWidgets({
    required List<QueryDocumentSnapshot<ItemDTO>> json,
    required double width,
  });
}
