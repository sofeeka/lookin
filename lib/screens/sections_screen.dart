import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../base_app_bar.dart';
import '../models/logger.dart';
import '../models/section_dto.dart';
import '../repositories/firestore_section_repository.dart';
import '../repositories/i_section_repository.dart';
import '../services/i_section_service.dart';
import '../services/section_service.dart';
import '../widgets/error_dialog.dart';
import '../widgets/section_widget.dart';

class SectionsScreen extends StatefulWidget {
  const SectionsScreen({
    super.key,
    this.onPressedActive = false,
    this.onSectionPressed,
  });

  final bool onPressedActive;
  final Function(int)? onSectionPressed;

  @override
  _SectionsScreenState createState() => _SectionsScreenState();
}

class _SectionsScreenState extends State<SectionsScreen> {
  static const CROSS_AXIS_COUNT = 3;
  late ISectionService sectionService;
  late ISectionRepository sectionRepository;
  Function()? onAddButtonPressed;

  Future<List<SectionWidget>>? futureSections;
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    sectionRepository = FirestoreSectionRepository();
    sectionService = SectionService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        onRightWidgetPressed: openSectionBox,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: sectionRepository.getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return ErrorDialog(
              context: context,
              errorMessage: 'Error: ${snapshot.error}',
            );
          } else {
            return buildSectionsGrid(
              sectionService.getSectionWidgets(
                    json: snapshot.data!.docs
                        as List<QueryDocumentSnapshot<SectionDTO>>,
                    width: MediaQuery.of(context).size.width /
                        (CROSS_AXIS_COUNT + 1),
                    onPressed: widget.onPressedActive
                        ? widget.onSectionPressed
                        : (i) => Logger.log("default onPressed, id: $i"),
                  ) ??
                  [],
            );
          }
        },
      ),
    );
  }

  Widget buildSectionsGrid(List<SectionWidget> sections) {
    return Padding(
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
    );
  }

  // Function to open section dialog
  void openSectionBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Section"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 16),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              SectionDTO section = SectionDTO(
                id: 10, // TODO get max id + 1
                color: Colors.red, // TODO use flutter_colorpicker
                name: textController.text,
                iconData: Icons.bug_report, // TODO choose icon
              );
              sectionRepository.add(section);
              Navigator.pop(context);
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }
}
