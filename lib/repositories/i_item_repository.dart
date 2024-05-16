import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/item_dto.dart';

abstract class IItemRepository {

  void add(ItemDTO model);
  Future<QuerySnapshot> getAll();
  void update(int id, ItemDTO model);
  void delete(int id);

  Future<List<ItemDTO>?> getByUserId(String userId);
  Future<ItemDTO?> getByIndex(int i);
  Future<int?> getMaxId();
}
