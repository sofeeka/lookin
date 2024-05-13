import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SvgPicture.asset(
          'lib/assets/icons/404.svg',
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
