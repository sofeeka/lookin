import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lookin_empat/models/section_dto.dart';

class FirestoreSectionRepository {
  static const FIREBASE_TABLE_REF = "sections";

  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _sectionsRef;

  FirestoreSectionRepository() {
    _sectionsRef =
        _firestore.collection(FIREBASE_TABLE_REF).withConverter<SectionDTO>(
            fromFirestore: (snapshots, _) => SectionDTO.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (section, _) => section.toJson());
  }

  Stream<QuerySnapshot> getSections() {
    return _sectionsRef.snapshots();
  }

  void addSection(SectionDTO dto) async {
    _sectionsRef.add(dto);
  }

  void updateSection(int id, SectionDTO dto) {
    _sectionsRef.doc(id.toString()).update(dto.toJson());
  }

  void deleteSection(int id) {
    _sectionsRef.doc(id.toString()).delete();
  }
}
