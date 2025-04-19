import 'package:flutter/material.dart';
import 'package:flutter_app/theme/theme.dart';

class StyledAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StyledAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'App Name',
        style: TextStyle(color: AppTheme().appBarTextColor),
      ),
      centerTitle: true,
      backgroundColor: AppTheme().appBarColor,
    );
  }
}
