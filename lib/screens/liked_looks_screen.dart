import 'package:flutter/material.dart';
import 'package:lookin_empat/widgets/coming_soon.dart';

import '../base_app_bar.dart';

class SavedLooksScreen extends StatelessWidget {
  const SavedLooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BaseAppBar(),
      body: ComingSoon(),
    );
  }
}
