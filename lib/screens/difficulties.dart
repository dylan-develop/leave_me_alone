import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:leave_me_alone/components/animated_icon_button.dart';
import 'package:leave_me_alone/components/animated_text_button.dart';
import 'package:leave_me_alone/components/difficulties_list.dart';
import 'package:leave_me_alone/components/responsive_layout_builder.dart';
class DifficultiesPage extends StatefulWidget {
  const DifficultiesPage({Key? key}) : super(key: key);

  @override
  State<DifficultiesPage> createState() => _DifficultiesPageState();
}

class _DifficultiesPageState extends State<DifficultiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayoutBuilder(
        mobile: Stack(
          children: [
            DifficultiesList(
              onPressedCallback: () {
                context.beamToNamed('/puzzle');
              },
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              child: AnimatedIconButton(
                initDelay: const Duration(milliseconds: 3750),
                imageUrl: 'assets/icons/arrow.svg',
                onPressed: () {
                  context.beamToNamed('/');
                },
              ),
            ),
          ],
        ),
        desktop: Stack(
          children: [
            DifficultiesList(
              onPressedCallback: () {
                context.beamToNamed('/puzzle');
              },
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 96,
              ),
              child: AnimatedTextButton(
                initDelay: const Duration(milliseconds: 3750),
                text: 'HOME',
                onPressed: () {
                  context.beamToNamed('/');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}