import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lookin_empat/models/section_dto.dart';
import 'package:lookin_empat/repositories/firestore_section_repository.dart';

import '../models/logger.dart';
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
    required this.sectionDTO,
    required this.firestoreSectionRepository,
  });

  final SectionDTO sectionDTO;
  final FirestoreSectionRepository firestoreSectionRepository;

  @override
  Widget build(BuildContext context) {
    //todo take items from database with id sectionDto.id
    List<ClothingItemWidget> items = [
      ClothingItemWidget(
        sectionId: 1,
        firestoreSectionRepository: firestoreSectionRepository,
      ),
      ClothingItemWidget(
        sectionId: 2,
        firestoreSectionRepository: firestoreSectionRepository,
      ),
      ClothingItemWidget(
        sectionId: 3,
        firestoreSectionRepository: firestoreSectionRepository,
      ),
      ClothingItemWidget(
        sectionId: 4,
        firestoreSectionRepository: firestoreSectionRepository,
      ),
      ClothingItemWidget(
        sectionId: 5,
        firestoreSectionRepository: firestoreSectionRepository,
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
                  children: List.generate(
                    items.length,
                    (index) => Container(
                      width: 150,
                      height: 400,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: Text('Item ${items[index].sectionId}'),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
