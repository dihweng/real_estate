import 'package:flutter/material.dart';
import 'package:real_estate/utils/helper_widgets.dart';
import 'package:real_estate/widgets/animated_container_width.dart';
import '../utils/colors.dart';
import 'app_text.dart';
import 'expand_zero_max_container.dart';

class BackCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String screenTitle;
  final Function backPress;

  const BackCustomAppBar({
    Key? key,
    required this.screenTitle,
    required this.backPress
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
      final maxWidth = constraints.maxWidth;
        return AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainerWidth(maxWidth: maxWidth * 0.4),
                ExpandZeroMaxContainer(),
              ],
            ),
          ),
        );
      }
    );
  }
}
