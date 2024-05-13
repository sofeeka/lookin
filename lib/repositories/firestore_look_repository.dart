import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lookin_empat/models/look_dto.dart';
import 'package:lookin_empat/models/section_dto.dart';
import 'package:lookin_empat/widgets/error_dialog.dart';

class FirestoreLookRepository {
  static const FIREBASE_TABLE_REF = "looks";

  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _collectionRef;

  FirestoreLookRepository() {
    _collectionRef =
        _firestore.collection(FIREBASE_TABLE_REF).withConverter<LookDTO>(
            fromFirestore: (snapshots, _) => LookDTO.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (model, _) => model.toJson());
  }

  Stream<QuerySnapshot> get() {
    return _collectionRef.snapshots();
  }

  void add(LookDTO dto) async {
    _collectionRef.add(dto);
  }

  void update(int id, LookDTO dto) {
    _collectionRef.doc(id.toString()).update(dto.toJson());
  }

  Future<void> delete(int id)
  async {
      QuerySnapshot<Object?> querySnapshot =
          await _collectionRef.where('fieldName', isEqualTo: id).get();

      for (DocumentSnapshot<Object?> docSnapshot
      in querySnapshot.docs) {
        await docSnapshot.reference.delete();
      }
  }

  void deleteByDocumentId(String id) {
    _collectionRef.doc(id.toString()).delete();
  }
}
