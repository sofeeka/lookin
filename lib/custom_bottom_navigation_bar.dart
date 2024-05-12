import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      currentIndex: selectedIndex,
      onTap: onDestinationSelected,
      items: [
        _buildNavigationBarItem(
          context: context,
          iconPath: 'lib/assets/icons/home.svg',
          index: 0,
        ),
        _buildNavigationBarItem(
          context: context,
          iconPath: 'lib/assets/icons/search.svg',
          index: 1,
        ),
        _buildNavigationBarItem(
          context: context,
          iconPath: 'lib/assets/icons/plus.svg',
          index: 2,
        ),
        _buildNavigationBarItem(
          context: context,
          iconPath: 'lib/assets/icons/heart.svg',
          index: 3,
        ),
        _buildNavigationBarItem(
          context: context,
          iconPath: 'lib/assets/icons/user.svg',
          index: 4,
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildNavigationBarItem({
    required BuildContext context,
    required String iconPath,
    required int index,
  }) {
    final isSelected = selectedIndex == index;

    ThemeData theme = Theme.of(context);
    return BottomNavigationBarItem(
      label: '',
      icon: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SvgPicture.asset(
          iconPath,
          color: isSelected ?
          theme.bottomNavigationBarTheme.selectedItemColor :
          theme.bottomNavigationBarTheme.unselectedItemColor,
        ),
      ),
    );
  }
}
