import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:leave_me_alone/components/animated_icon_button.dart';
import 'package:leave_me_alone/components/animated_text_button.dart';
import 'package:leave_me_alone/components/audio_control.dart';
import 'package:leave_me_alone/components/difficulties_list.dart';
import 'package:leave_me_alone/components/responsive_layout_builder.dart';

class DifficultiesPage extends StatelessWidget {
  const DifficultiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayoutBuilder(
        small: (context, child) => child,
        large: (context, child) => child,
        child: (size) {
          final icon = size == ResponsiveLayoutSize.large
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 96),
                  child: AnimatedTextButton(
                    initDelay: const Duration(milliseconds: 2480),
                    text: 'HOME',
                    onPressed: () {
                      context.beamToNamed('/');
                    },
                  ),
                )
              : AnimatedIconButton(
                  initDelay: const Duration(milliseconds: 2480),
                  imageUrl: 'assets/icons/arrow.svg',
                  onPressed: () {
                    context.beamToNamed('/');
                  },
                );

          return Stack(
            children: [
              DifficultiesList(
                onPressedCallback: () {
                  context.beamToNamed('/puzzle');
                },
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                child: icon,
              ),
              const Positioned(
                right: 32,
                top: 32,
                child: AudioControl(),
              ),
            ],
          );
        },
      ),
    );
  }
}
