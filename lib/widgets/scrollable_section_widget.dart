import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lookin_empat/models/section_dto.dart';

import 'clothing_item_widget.dart';

enum ScrollableSectionEvent { next, previous }

class ScrollableSectionCubit extends Cubit<int> {
  ScrollableSectionCubit({required this.len, required this.items}) : super(0);

  int len;
  List<ClothingItemWidget> items;

  void handleEvent(ScrollableSectionEvent event) {
    if (event == ScrollableSectionEvent.next) {
      if (state < len - 1) {
        emit(state + 1);
      }
    } else if (event == ScrollableSectionEvent.previous) {
      if (state > 0) {
        emit(state - 1);
      }
    }
  }
}

class ScrollableSectionWidget extends StatelessWidget {
  const ScrollableSectionWidget({
    super.key,
    required this.sectionDTO,
  });

  final SectionDTO sectionDTO;

  @override
  Widget build(BuildContext context) {
    //todo take items from database with id sectionDto.id
    List<ClothingItemWidget> items = [];

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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  items.length,
                  (index) => Container(
                    width: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text('Item ${items[index]}'),
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
