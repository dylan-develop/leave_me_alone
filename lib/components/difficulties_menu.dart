import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leave_me_alone/components/difficulties_list.dart';

class DifficultiesMenu extends StatelessWidget {
  const DifficultiesMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DifficultiesList(
            isAnimated: false,
            onPressedCallback: () {
              Navigator.of(context).pop();
            }
          ),
          Padding(
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
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 14),
                          child: SvgPicture.asset(
                            'assets/icons/delete.svg',
                          ),
                        ),
                        const Text(
                          'Close',
                          style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'ThinkBig',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
