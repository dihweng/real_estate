import 'package:flutter/material.dart';
import 'package:real_estate/widgets/animated_container_width.dart';
import 'size_transition_container.dart';

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
          toolbarHeight: 70.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: SizedBox(
            // height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainerWidth(
                    maxWidth: maxWidth * 0.5, location: 'Lagos Ekeja',),
                 SizeTransitionContainer(
                  maxSize: 50,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: AssetImage('assets/images/user.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}