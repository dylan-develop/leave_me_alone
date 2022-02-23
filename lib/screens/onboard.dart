import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:slide_puzzle/components/character_block.dart';
import 'package:slide_puzzle/components/elevated_button.dart';
import 'package:slide_puzzle/components/responsive_layout_builder.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayoutBuilder(
        mobile: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.2,
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          child: const Text(
                            'LEAVE ME ALONE',
                            style: TextStyle(
                              fontSize: 48,
                              fontFamily: 'ThinkBig',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(
                            bottom: 72,
                          ),
                          child: const Text(
                            'a stupid game',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'HandWriting',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 96,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                  right: 16,
                                ),
                                child: const CharacterBlock(
                                  imageUrl: kIsWeb
                                      ? 'images/charactera.png'
                                      : 'assets/images/charactera.png',
                                  shakeOnHover: true,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                  left: 16,
                                ),
                                child: const CharacterBlock(
                                  imageUrl: kIsWeb
                                      ? 'images/characterb.png'
                                      : 'assets/images/characterb.png',
                                  shakeOnHover: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 12,
                        ),
                        child: CustomElevatedButton(
                          title: 'start now',
                          onPressed: () {
                            context.beamToNamed('/difficulties');
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        desktop: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          child: const Text(
                            'LEAVE ME ALONE',
                            style: TextStyle(
                              fontSize: 96,
                              fontFamily: 'ThinkBig',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(
                            bottom: 72,
                          ),
                          child: const Text(
                            'a stupid game',
                            style: TextStyle(
                              fontSize: 36,
                              fontFamily: 'HandWriting',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 96,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                  right: 40,
                                ),
                                child: const CharacterBlock(
                                  imageUrl: kIsWeb
                                      ? 'images/charactera.png'
                                      : 'assets/images/charactera.png',
                                  shakeOnHover: true,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                  left: 40,
                                ),
                                child: const CharacterBlock(
                                  imageUrl: kIsWeb
                                      ? 'images/characterb.png'
                                      : 'assets/images/characterb.png',
                                  shakeOnHover: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 12,
                        ),
                        child: CustomElevatedButton(
                          title: 'start now',
                          onPressed: () {
                            context.beamToNamed('/difficulties');
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
