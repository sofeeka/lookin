import '../widgets/section_widget.dart';

abstract class ISectionService {
  List<SectionWidget> getSections({
    required double width,
    bool onPressedActive = false,
    Function(int)? onPressed,
  });
}
