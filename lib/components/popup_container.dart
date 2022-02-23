import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slide_puzzle/components/responsive_layout_builder.dart';

class PopupContainer extends StatelessWidget {
  final Widget child;

  const PopupContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      mobile: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(8, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: SizedBox(
              width: min(
                MediaQuery.of(context).size.width - 16 * 2,
                MediaQuery.of(context).size.height * 9 / 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset(
                          kIsWeb
                              ? 'icons/delete.svg'
                              : 'assets/icons/delete.svg',
                        ),
                      ),
                    ),
                  ),
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
      desktop: Container(
        margin: const EdgeInsets.symmetric(horizontal: 96),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(),
            ),
            Expanded(
              flex: 6,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(16, 21),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: LayoutBuilder(
                      builder: ((context, constraints) {
                        return SizedBox.square(
                          dimension: min(
                            constraints.maxWidth,
                            constraints.maxHeight,
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(32),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Icon(Icons.close),
                                  ),
                                ),
                                Expanded(
                                  child: child,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
