import 'package:lookin_empat/repositories/i_section_repository.dart';
import 'package:lookin_empat/repositories/section_repository.dart';
import 'package:lookin_empat/services/i_section_service.dart';
import '../widgets/section_widget.dart';

class SectionService implements ISectionService{
  final ISectionRepository _sectionRepository;

  SectionService(this._sectionRepository);

  @override
  List<SectionWidget> getSections({
    required double width,
    bool onPressedActive = false,
    Function(int)? onPressed,
  }) {

    if (SectionRepository.sectionDTOs == null) {
      _sectionRepository.initialiseSections();
    }

    return SectionRepository.sectionDTOs!
        .map(
          (dto) => SectionWidget(
            sectionDTO: dto,
            onPressed: onPressed ?? (i) => {},
            width: width,
          ),
        )
        .toList();
  }
}
