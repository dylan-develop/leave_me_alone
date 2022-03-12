import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leave_me_alone/components/difficulties_menu.dart';

import 'package:leave_me_alone/components/responsive_layout_builder.dart';
import 'package:leave_me_alone/components/side_menu.dart';
import 'package:leave_me_alone/helpers/modal_helper.dart';

class AppHeader extends StatefulWidget {
  const AppHeader({Key? key}) : super(key: key);

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  double _opacity = 0;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (context, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 32,
          ),
          child: Row(
            children: [
              Visibility(
                visible: context
                        .currentBeamLocation.state.routeInformation.location ==
                    '/difficulties',
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      context.beamToNamed('/');
                    },
                    child: SvgPicture.asset(
                      'assets/icons/arrow.svg',
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: context
                        .currentBeamLocation.state.routeInformation.location ==
                    '/puzzle',
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      showSlideDialog(
                        context: context,
                        child: const SideMenu(),
                        beginOffset: const Offset(-1, 0),
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/icons/menu.svg',
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      large: (context, child) {
        return Padding(
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
                visible: context
                        .currentBeamLocation.state.routeInformation.location ==
                    '/puzzle',
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
                          // context.beamToNamed('/difficulties');
                          showSlideDialog(
                            context: context,
                            beginOffset: const Offset(0, -1),
                            child: const DifficultiesMenu(),
                          );
                        },
                        child: AnimatedOpacity(
                          opacity: _opacity,
                          duration: const Duration(milliseconds: 500),
                          child: const Text(
                            'Difficulty',
                            style: TextStyle(
                              fontSize: 32,
                              fontFamily: 'ThinkBig',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
