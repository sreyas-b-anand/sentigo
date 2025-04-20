import 'package:flutter/material.dart';

class StyledAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StyledAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Sentigo' , style: Theme.of(context).appBarTheme.titleTextStyle,),
      centerTitle: true,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor
    );
  }
}
