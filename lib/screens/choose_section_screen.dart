import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lookin_empat/style/colors.dart';

import '../base_app_bar.dart';
import '../models/logger.dart';
import '../models/section_dto.dart';
import '../repositories/firestore_section_repository.dart';
import '../repositories/i_section_repository.dart';
import '../services/i_section_service.dart';
import '../services/section_service.dart';
import '../widgets/error_dialog.dart';
import '../widgets/section_widget.dart';

class ChooseSectionScreen extends StatefulWidget {
  const ChooseSectionScreen({
    super.key,
    this.onPressedActive = false,
    this.onSectionPressed,
    this.leftAppBarWidget,
  });

  final bool onPressedActive;
  final Function(BuildContext, int)? onSectionPressed;
  final Widget? leftAppBarWidget;

  @override
  _ChooseSectionScreenState createState() => _ChooseSectionScreenState();
}

class _ChooseSectionScreenState extends State<ChooseSectionScreen> {
  static const CROSS_AXIS_COUNT = 3;
  late ISectionService sectionService;
  late ISectionRepository sectionRepository;
  Function()? onAddButtonPressed;

  Future<List<SectionWidget>>? futureSections;
  final TextEditingController sectionNameController = TextEditingController();

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
          leftWidget: widget.leftAppBarWidget,
          // in base app bar default right widget is plus buttonIcon, can add onRightWidgetPressed
          rightWidget: const SizedBox(),
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
            return buildSectionsGrid(sectionService.getSectionWidgets(
              json: snapshot.data!.docs
                  as List<QueryDocumentSnapshot<SectionDTO>>,
              width: MediaQuery.of(context).size.width / (CROSS_AXIS_COUNT + 1),
              onPressed: widget.onPressedActive
                  ? (BuildContext context, int id) {
                      if (widget.onSectionPressed != null) {
                        widget.onSectionPressed!(context, id);
                      }
                    }
                  : (BuildContext context, int id) =>
                      Logger.log("default onPressed, id: $id"),
            ));
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

  void openAddSectionBottomPopUp() async {

    // 5 first ids for basic hardcoded sections
    // in /lib/repositories/hardcoded_section_repository.dart
    // used to init when user presses light-bulb button
    int maxId = max(await sectionRepository.getMaxId() ?? 0, 5);
    int newSectionId = maxId + 1;

    showBottomSheet(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Center(
              child: Text(
                "Category",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 48,
                  child: TextField(
                    controller: sectionNameController,
                    decoration: const InputDecoration(labelText: "Name"),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Icon",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    IconButton(
                      icon: const Icon(Icons.assignment_late_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Color",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    SectionDTO section = SectionDTO(
                      id: newSectionId,
                      color: CColors.red, // Todo: Use color_picker
                      name: sectionNameController.text,
                      svgIconPath:
                          "lib/assets/icons/not_found.svg", // Todo: Let user choose an icon
                    );
                    sectionRepository.add(section);
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
