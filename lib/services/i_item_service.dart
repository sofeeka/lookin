import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lookin_empat/models/item_dto.dart';

import '../widgets/clothing_item_widget.dart';

abstract class IItemService {
  List<ClothingItemWidget> getClothingItemWidgets({
    required List<QueryDocumentSnapshot<ItemDTO>> json,
  });
}
