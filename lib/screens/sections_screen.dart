import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lookin_empat/base_app_bar.dart';
import 'package:lookin_empat/repositories/i_section_repository.dart';
import 'package:lookin_empat/repositories/section_repository.dart';
import 'package:lookin_empat/services/firestore_section_service.dart';
import 'package:lookin_empat/services/section_service.dart';

import '../models/logger.dart';
import '../models/section_dto.dart';
import '../services/i_section_service.dart';

class SectionsScreen extends StatefulWidget {
  SectionsScreen(
      {super.key, this.onPressedActive = false, this.onSectionPressed}) {
    assert(!onPressedActive || onPressedActive && onSectionPressed != null);
  }

  bool onPressedActive;
  Function(int)? onSectionPressed;

  @override
  State<SectionsScreen> createState() => _SectionsScreenState();
}

class _SectionsScreenState extends State<SectionsScreen> {
  static const CROSS_AXIS_COUNT = 3;
  late ISectionService sectionService;
  late ISectionRepository sectionRepository;
  Function()? onAddButtonPressed;

  final FirestoreSectionService firestoreSectionService =
      FirestoreSectionService();
  final TextEditingController textController = TextEditingController();

  // add section
  void openSectionBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Section'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            // SizedBox(height: 16),
            // CircleColorPicker(
            //   initialColor: Colors.blue, // Set initial color
            //   onChanged: (color) => setState(() => selectedColor = color),
            // ),
            SizedBox(height: 16),
            // Additional input fields for icon and SVG path
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              SectionDTO section = SectionDTO(
                id: 10, // TODO get max id + 1
                color: Colors.red,// TODO use flutter_colorpicker
                name: textController.text,
                iconData: Icons.bug_report, // TODO choose icon
              );
              firestoreSectionService.addSection(section);
              Navigator.pop(context);
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    sectionRepository = SectionRepository();
    sectionService = SectionService(sectionRepository);

    onAddButtonPressed = () => {
      openSectionBox()
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sectionWidth =
        MediaQuery.of(context).size.width / (CROSS_AXIS_COUNT + 1);
    var sections = sectionService.getSections(
        width: sectionWidth,
        onPressed: widget.onPressedActive
            ? widget.onSectionPressed
            : (i) => {
                  // todo delete logger
                  Logger.log("default onPressed, id: $i")
                });

    return Scaffold(
      appBar: BaseAppBar(
        onRightWidgetPressed: onAddButtonPressed,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: CROSS_AXIS_COUNT,
          crossAxisSpacing: 24,
          mainAxisSpacing: 16,
          itemCount: sections.length,
          itemBuilder: (BuildContext context, int index) {
            return sections[index];
          },
          staggeredTileBuilder: (int index) {
            return const StaggeredTile.fit(1);
          },
        ),
      ),
    );
  }
}
