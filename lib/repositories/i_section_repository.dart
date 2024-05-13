import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/section_dto.dart';

abstract class ISectionRepository {

  void add(SectionDTO model);
  Stream<QuerySnapshot> get();
  void update(int id, SectionDTO model);
  void delete(int id);

  List<SectionDTO> initialiseSections();
  Future<SectionDTO?> getByID(int id);
  Future<SectionDTO?> getByIndex(int i);
}
