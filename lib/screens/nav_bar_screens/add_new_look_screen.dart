import 'package:flutter/material.dart';
import 'package:lookin_empat/base_app_bar.dart';
import 'package:lookin_empat/models/section_dto.dart';
import 'package:lookin_empat/repositories/firestore_section_repository.dart';
import 'package:lookin_empat/screens/choose_section_screen.dart';
import 'package:lookin_empat/widgets/error_dialog.dart';

import '../../models/logger.dart';
import '../../widgets/scrollable_section_widget.dart';

class AddNewLookScreen extends StatefulWidget {
  const AddNewLookScreen({super.key});

  @override
  State<AddNewLookScreen> createState() => _AddNewLookScreenState();
}

class _AddNewLookScreenState extends State<AddNewLookScreen> {
  late List<ScrollableSectionWidget> clothingSections;
  late FirestoreSectionRepository firestoreSectionRepository;

  @override
  void initState() {
    clothingSections = [];
    firestoreSectionRepository = FirestoreSectionRepository();
    super.initState();
  }

  Future<bool> addNewSection(BuildContext context, int id) async {
    SectionDTO? sectionDTO = await firestoreSectionRepository.getByID(id);

    if (sectionDTO == null) {
      return false;
    }

    setState(() {
      clothingSections.add(
        ScrollableSectionWidget(
          sectionDTO: sectionDTO,
          firestoreSectionRepository: firestoreSectionRepository,
        ),
      );
    });

    Logger.log(clothingSections.length.toString());

    Navigator.of(context).pop();

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        onRightWidgetPressed: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChooseSectionScreen(
                leftAppBarWidget: GestureDetector(
                  child: Icon(
                    // todo change icon
                    Icons.arrow_back,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                onPressedActive: true,
                onSectionPressed: (context, id) async {
                  if (!(await addNewSection(context, id))) {
                    show(
                      context: context,
                      errorMessage: "Could not add section with id: $id",
                    );
                  }
                },
              ),
            ),
          )
        },
      ),
      body: clothingSections.isEmpty
          ? Center(
              child: Text(
                "No clothing sections. Press plus to add one.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [...clothingSections],
            ),
    );
  }

  static void show({
    required BuildContext context,
    required String errorMessage,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ErrorDialog(
          context: context,
          errorMessage: errorMessage,
        );
      },
    ).then((_) {
      Navigator.of(context).pop();
    });
  }
}
