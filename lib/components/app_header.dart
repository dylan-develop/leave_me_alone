import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slide_puzzle/components/responsive_layout_builder.dart';
import 'package:slide_puzzle/components/side_menu.dart';
import 'package:slide_puzzle/helpers/modal_helper.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      mobile: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 32,
        ),
        child: Row(
          children: [
            Visibility(
              visible: ModalRoute.of(context)?.settings.name == '/difficulties',
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset(
                    kIsWeb ? 'icons/arrow.svg' : 'assets/icons/arrow.svg',
                  ),
                ),
              ),
            ),
            Visibility(
              visible: ModalRoute.of(context)?.settings.name == '/game',
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    showSlideDialog(
                      context: context, 
                      beginOffset: const Offset(-1, 0),
                      child: const SideMenu(),
                    );
                  },
                  child: SvgPicture.asset(
                    kIsWeb ? 'icons/menu.svg' : 'assets/icons/menu.svg',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      desktop: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 96,
        ),
        child: Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                },
                child: const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'ThinkBig',
                  ),
                ),
              ),
            ),
            Visibility(
              visible: ModalRoute.of(context)?.settings.name == '/game',
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .popUntil(ModalRoute.withName('/difficulties'));
                      },
                      child: const Text(
                        'Difficulty',
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'ThinkBig',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
