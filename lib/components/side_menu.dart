import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.black),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(4, 0),
                  color: Colors.black,
                ),
              ],
              color: Colors.white,
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 56,
                      right: 24,
                    ),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset(
                            'assets/icons/delete.svg',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 56,
                    ),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          context.beamToNamed('/');
                        },
                        child: const Text(
                          'Home',
                          style: TextStyle(
                            fontFamily: 'ThinkBig',
                            fontSize: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 56,
                    ),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          context.beamToNamed('/difficulties');
                        },
                        child: const Text(
                          'Difficulty',
                          style: TextStyle(
                            fontFamily: 'ThinkBig',
                            fontSize: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(),
        ),
      ],
    );
  }
}
