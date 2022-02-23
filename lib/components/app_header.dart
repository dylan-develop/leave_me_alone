import 'package:beamer/beamer.dart';
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
              visible: context.currentBeamLocation.state.routeInformation.location == '/difficulties',
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    context.beamToNamed('/');
                  },
                  child: SvgPicture.asset(
                    kIsWeb ? 'icons/arrow.svg' : 'assets/icons/arrow.svg',
                  ),
                ),
              ),
            ),
            Visibility(
              visible: context.currentBeamLocation.state.routeInformation.location == '/puzzle',
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    showSlideDialog(
                      context: context,
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
                  context.beamToNamed('/');
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
              visible: context.currentBeamLocation.state.routeInformation.location == '/puzzle',
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
                        context.beamToNamed('/difficulties');
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
