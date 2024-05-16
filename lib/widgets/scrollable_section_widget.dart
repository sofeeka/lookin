import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lookin_empat/models/section_dto.dart';
import 'package:lookin_empat/repositories/firestore_section_repository.dart';

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
    required this.firestoreSectionRepository,
    required this.firestoreItemRepository,
  });

  final int sectionId;
  final FirestoreSectionRepository firestoreSectionRepository;
  final FirestoreItemRepository firestoreItemRepository;

  @override
  Widget build(BuildContext context) {
    //todo take items from database with id sectionDto.id
    List<ClothingItemWidget> items = [
      ClothingItemWidget(
        sectionId: sectionId,
        firestoreSectionRepository: firestoreSectionRepository,
        firestoreItemRepository: firestoreItemRepository,
      ),
      ClothingItemWidget(
        sectionId: sectionId,
        firestoreSectionRepository: firestoreSectionRepository,
        firestoreItemRepository: firestoreItemRepository,
      ),
      ClothingItemWidget(
        sectionId: sectionId,
        firestoreSectionRepository: firestoreSectionRepository,
        firestoreItemRepository: firestoreItemRepository,
      ),
      ClothingItemWidget(
        sectionId: sectionId,
        firestoreSectionRepository: firestoreSectionRepository,
        firestoreItemRepository: firestoreItemRepository,
      ),
      ClothingItemWidget(
        sectionId: sectionId,
        firestoreSectionRepository: firestoreSectionRepository,
        firestoreItemRepository: firestoreItemRepository,
      ),
    ];

    return BlocProvider(
      create: (_) => ScrollableSectionCubit(len: items.length, items: items),
      child: BlocBuilder<ScrollableSectionCubit, int>(
        builder: (context, currentIndex) {
          return GestureDetector(
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
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: items,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
