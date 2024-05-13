import 'package:flutter/material.dart';
import 'package:lookin_empat/base_app_bar.dart';
import 'package:lookin_empat/models/section_dto.dart';
import 'package:lookin_empat/repositories/firestore_section_repository.dart';
import 'package:lookin_empat/screens/sections_screen.dart';
import 'package:lookin_empat/widgets/error_dialog.dart';

import '../widgets/scrollable_section_widget.dart';

class AddNewLookScreen extends StatefulWidget {
  const AddNewLookScreen({super.key});

  @override
  State<AddNewLookScreen> createState() => _AddNewLookScreenState();
}

class _AddNewLookScreenState extends State<AddNewLookScreen> {
  late List<ScrollableSectionWidget> clothingSections;

  Future<bool> addNewSection(int id) async {
    var frs = FirestoreSectionRepository();
    SectionDTO? sectionDTO = await frs.getByID(id);

    if (sectionDTO == null) {
      return false;
    }

    setState(() {
      clothingSections.add(ScrollableSectionWidget(sectionDTO: sectionDTO));
    });

    return true;
  }

  @override
  void initState() {
    clothingSections = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        onRightWidgetPressed: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SectionsScreen(
                leftAppBarWidget: GestureDetector(
                  child: Icon( // todo change icon
                    Icons.arrow_back,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                onPressedActive: true,
                onSectionPressed: (id) async {
                  if (!(await addNewSection(id))) {
                    ErrorDialog.show(
                      context: context,
                      errorMessage: "Could not add section with id: $id",
                    );
                  }
                  Navigator.of(context).pop();
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
              children: [...clothingSections],
            ),
    );
  }
}
