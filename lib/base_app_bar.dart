import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leftWidget;
  final Widget? rightWidget;
  final Widget? centerWidget;
  final Color? backgroundColor;
  final Function()? onRightWidgetPressed;

  const BaseAppBar({
    super.key,
    this.leftWidget,
    this.rightWidget,
    this.centerWidget,
    this.backgroundColor,
    this.onRightWidgetPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 100,
      leading: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: leftWidget,
        ),
      ),
      actions: [
        rightWidget ??
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    if (rightWidget != null) rightWidget!,
                    IconButton(
                      onPressed: onRightWidgetPressed,
                      icon: SvgPicture.asset(
                        'lib/assets/icons/plus.svg',
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .selectedItemColor,
                        width: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ],
      title: centerWidget ??
          Text(
            "LookIn",
            style: Theme.of(context).textTheme.titleMedium,
          ),
      elevation: 0,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size(100, kToolbarHeight);
}
