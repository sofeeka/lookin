import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lookin_empat/models/section_dto.dart';
import 'package:lookin_empat/repositories/section_repository.dart';

import '../models/logger.dart';
import 'i_section_repository.dart';

class FirestoreSectionRepository implements ISectionRepository {
  static const FIREBASE_TABLE_REF = "sections";
  static bool initialised = false;
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _collectionRef;

  FirestoreSectionRepository() {
    _collectionRef =
        _firestore.collection(FIREBASE_TABLE_REF).withConverter<SectionDTO>(
            fromFirestore: (snapshots, _) => SectionDTO.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (section, _) => section.toJson());
  }

  @override
  Future<QuerySnapshot> getAll() async {
    return await _collectionRef.get();
  }

  @override
  void add(SectionDTO model) async {
    final CollectionReference localCollectionRef =
        _firestore.collection(FIREBASE_TABLE_REF);

    Map<String, dynamic> modelData = model.toJson();
    await localCollectionRef.doc(model.id.toString()).set(modelData);
  }

  @override
  void update(int id, SectionDTO dto) async {
    _collectionRef.doc(id.toString()).update(dto.toJson());
  }

  @override
  void delete(int id) {
    _collectionRef.doc(id.toString()).delete();
  }

  @override
  Future<SectionDTO?> getByID(int id) async {
    try {
      var docSnapshot = await _collectionRef.doc(id.toString()).get();
      if (docSnapshot.exists) {
        return SectionDTO.fromJson(docSnapshot.data()! as Map<String, Object?>);
      } else {
        return null;
      }
    } catch (error) {
      Logger.log('Error fetching SectionDTO by ID: $error');
      return null;
    }
  }

  @override
  Future<SectionDTO?> getByIndex(int index) async {
    try {
      var querySnapshot =
          await _collectionRef.orderBy('id').limit(index + 1).get();
      if (querySnapshot.size > index) {
        return SectionDTO.fromJson(
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
  List<SectionDTO> initialiseSections() {
    if(initialised) {
      return [];
    }

    final rep = HardCodedSectionRepository();

    var sections = rep.initialiseSections();
    for (SectionDTO section in sections) {
      add(section);
    }

    initialised = true;

    return sections;
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
