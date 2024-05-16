import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lookin_empat/models/item_dto.dart';

import '../models/logger.dart';
import 'i_item_repository.dart';

class FirestoreItemRepository implements IItemRepository {
  static const FIREBASE_TABLE_REF = "items";
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _collectionRef;

  FirestoreItemRepository() {
    _collectionRef =
        _firestore.collection(FIREBASE_TABLE_REF).withConverter<ItemDTO>(
            fromFirestore: (snapshots, _) => ItemDTO.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (section, _) => section.toJson());
  }

  @override
  Future<QuerySnapshot> getAll() async {
    return await _collectionRef.get();
  }

  @override
  void add(ItemDTO model) async {
    final CollectionReference localCollectionRef =
        _firestore.collection(FIREBASE_TABLE_REF);

    Map<String, dynamic> modelData = model.toJson();
    await localCollectionRef.doc(model.id.toString()).set(modelData);
  }

  @override
  void update(int id, ItemDTO dto) async {
    _collectionRef.doc(id.toString()).update(dto.toJson());
  }

  @override
  void delete(int id) {
    _collectionRef.doc(id.toString()).delete();
  }

  @override
  Future<ItemDTO?> getByID(int id) async {
    try {
      var docSnapshot = await _firestore.collection(FIREBASE_TABLE_REF).doc(id.toString()).get();
      if (docSnapshot.exists) {
        return ItemDTO.fromJson(docSnapshot.data()! as Map<String, Object?>);
      } else {
        return null;
      }
    } catch (error) {
      Logger.log('Error fetching SectionDTO by ID: $error');
      return null;
    }
  }

  @override
  Future<ItemDTO?> getByIndex(int index) async {
    try {
      var querySnapshot =
          await _collectionRef.orderBy('id').limit(index + 1).get();
      if (querySnapshot.size > index) {
        return ItemDTO.fromJson(
            querySnapshot.docs[index].data() as Map<String, Object?>);
      } else {
        return null;
      }
    } catch (error) {
      Logger.log('Error fetching SectionDTO by index: $error');
      return null;
    }
  }

  @override
  Future<int?> getMaxId() async {
    try {
      var querySnapshot = await _collectionRef.orderBy('id', descending: true).limit(1).get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.get('id') as int?;
      } else {
        return null;
      }
    } catch (error) {
      Logger.log('Error fetching max ID: $error');
      return null;
    }
  }
}
