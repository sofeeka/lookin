import '../models/section_dto.dart';

abstract class ISectionRepository {
  List<SectionDTO> initialiseSections();
  SectionDTO? getByID(int id);
  SectionDTO getByIndex(int i);
}