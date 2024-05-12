import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lookin_empat/models/section_dto.dart';

const FIREBASE_SECTIONS_REF = "sections";

class FirestoreSectionService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _sectionsRef;

  FirestoreSectionService() {
    _sectionsRef =
        _firestore.collection(FIREBASE_SECTIONS_REF).withConverter<SectionDTO>(
            fromFirestore: (snapshots, _) => SectionDTO.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (section, _) => section.toJson());
  }

  Stream<QuerySnapshot> getSections() {
    return _sectionsRef.snapshots();
  }

  void addSection(SectionDTO section) async {
    _sectionsRef.add(section);
  }

  void updateSection(String todoId, SectionDTO section) {
    _sectionsRef.doc(todoId).update(section.toJson());
  }

  void deleteSection(String sectionId) {
    _sectionsRef.doc(sectionId).delete();
  }
}
