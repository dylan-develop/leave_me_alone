import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:leave_me_alone/components/character_block.dart';
import 'package:leave_me_alone/components/elevated_button.dart';
import 'package:leave_me_alone/components/responsive_layout_builder.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: const ResponsiveLayoutBuilder(
                  mobile: Text(
                    'LEAVE ME ALONE',
                    style: TextStyle(
                      fontFamily: 'ThinkBig',
                      fontSize: 48,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  desktop: Text(
                    'LEAVE ME ALONE',
                    style: TextStyle(
                      fontFamily: 'ThinkBig',
                      fontSize: 96,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: const ResponsiveLayoutBuilder(
                  mobile: Text(
                    'a stupid game',
                    style: TextStyle(
                      fontFamily: 'HandWriting',
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  desktop: Text(
                    'a stupid game',
                    style: TextStyle(
                      fontFamily: 'HandWriting',
                      fontSize: 36,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 64,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 272,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Expanded(
                            child: CharacterBlock(
                              shakeOnHover: true,
                              imageUrl: kIsWeb
                                  ? 'images/charactera.png'
                                  : 'assets/images/charactera.png',
                            ),
                          ),
                          ResponsiveLayoutBuilder(
                            mobile: Container(width: 32),
                            desktop: Container(width: 80),
                          ),
                          const Expanded(
                            child: CharacterBlock(
                              shakeOnHover: true,
                              imageUrl: kIsWeb
                                  ? 'images/characterb.png'
                                  : 'assets/images/characterb.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 264,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: CustomElevatedButton(
                      title: 'start now',
                      onPressed: () {
                        context.beamToNamed('/difficulties');
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
