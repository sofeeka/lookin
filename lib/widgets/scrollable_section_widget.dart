import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lookin_empat/models/item_dto.dart';
import 'package:lookin_empat/services/item_service.dart';

import '../models/logger.dart';
import '../repositories/firestore_item_repository.dart';
import 'clothing_item_widget.dart';

enum ScrollableSectionEvent { next, previous }

class ScrollableSectionCubit extends Cubit<int> {
  ScrollableSectionCubit({required this.len, required this.items}) : super(0);

  int len;
  List<ClothingItemWidget> items;

  void handleEvent(ScrollableSectionEvent event) {
    if (event == ScrollableSectionEvent.next) {
      if (state < len - 1) {
        Logger.log("next");
        emit(state + 1);
      }
    } else if (event == ScrollableSectionEvent.previous) {
      if (state > 0) {
        Logger.log("previous");
        emit(state - 1);
      }
    }
  }
}

class ScrollableSectionWidget extends StatelessWidget {
  const ScrollableSectionWidget({
    super.key,
    required this.sectionId,
    required this.firestoreItemRepository,
    required this.itemService,
  });

  final int sectionId;
  final FirestoreItemRepository firestoreItemRepository;
  final ItemService itemService;

  @override
  Widget build(BuildContext context) {
    double height = 400;
    double width = 500;

    return SizedBox(
      height: height,
      width: width,
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 0) {
            // User swiped right
            context
                .read<ScrollableSectionCubit>()
                .handleEvent(ScrollableSectionEvent.previous);
          } else {
            // User swiped left
            context
                .read<ScrollableSectionCubit>()
                .handleEvent(ScrollableSectionEvent.next);
          }
        },
        onTap: () {
          // todo: show all items from the section
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          child: FutureBuilder<QuerySnapshot>(
            future: firestoreItemRepository.getAll(),
            //todo change to getBySectionID
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Text('No items found');
              } else {
                return buildItemsScrollView(
                  width: width,
                  height: height,
                  sections: itemService.getClothingItemWidgets(
                    json: snapshot.data!.docs
                        as List<QueryDocumentSnapshot<ItemDTO>>,
                    height: height,
                    width: width,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  //todo
  Widget buildItemsScrollView({
    required List<ClothingItemWidget> sections,
    required double width,
    required double height,
  }) {
    return SizedBox(
      height: height,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            sections.length * 5,
            (index) => sections[index % sections.length],
          ),
        ),
      ),
    );
  }
}
