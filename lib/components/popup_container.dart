import 'dart:math';

import 'package:flutter/material.dart';
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
              child,
            ],
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
                  child: SizedBox.square(
                    dimension: min(
                        (MediaQuery.of(context).size.width - 96 * 2) * 6 / 11,
                        MediaQuery.of(context).size.height * 0.9),
                    child: Container(
                      margin: const EdgeInsets.all(32),
                      child: Column(
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
