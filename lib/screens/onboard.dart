import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:leave_me_alone/components/animated_character_block.dart';
import 'package:leave_me_alone/components/animated_elevated_button.dart';
import 'package:leave_me_alone/components/animated_typer_text.dart';
import 'package:leave_me_alone/components/responsive_builder.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        mobile: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 264,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: const AnimatedTyperText(
                      text: 'LEAVE ME ALONE',
                      fontFamily: 'ThinkBig',
                      fontSize: 48,
                      initDelay: Duration(milliseconds: 1700),
                    ),
                  ),
                  const AnimatedTyperText(
                    text: 'A stupid game',
                    fontSize: 24,
                    initDelay: Duration(milliseconds: 2400),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 64),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Expanded(
                          flex: 5,
                          child: AnimatedCharacterBlock(
                            index: 1,
                            initDelay: Duration(milliseconds: 200),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                        const Expanded(
                          flex: 5,
                          child: AnimatedCharacterBlock(
                            index: 2,
                            initDelay: Duration(milliseconds: 700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) => AnimatedElevatedButton(
                        initDelay: const Duration(milliseconds: 3050),
                        offset: 4.0,
                        width: constraints.maxWidth,
                        height: 40,
                        text: 'Start Now',
                        fontSize: 24,
                        onPressed: () {
                          context.beamToNamed('/difficulties');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        desktop: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(),
            ),
            Expanded(
              flex: 5,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: const AnimatedTyperText(
                        text: 'LEAVE ME ALONE',
                        fontFamily: 'ThinkBig',
                        fontSize: 96,
                        initDelay: Duration(milliseconds: 1700),
                      ),
                    ),
                    const AnimatedTyperText(
                      text: 'A stupid game',
                      fontSize: 36,
                      initDelay: Duration(milliseconds: 2400),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 64),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Expanded(
                            flex: 5,
                            child: AnimatedCharacterBlock(
                              index: 1,
                              initDelay: Duration(milliseconds: 200),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(),
                          ),
                          const Expanded(
                            flex: 5,
                            child: AnimatedCharacterBlock(
                              index: 2,
                              initDelay: Duration(milliseconds: 700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: LayoutBuilder(
                        builder: (context, constraints) => AnimatedElevatedButton(
                          initDelay: const Duration(milliseconds: 3050),
                          offset: 8.0,
                          width: constraints.maxWidth,
                          height: 56,
                          text: 'Start Now',
                          fontSize: 36,
                          onPressed: () {
                            context.beamToNamed('/difficulties');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
