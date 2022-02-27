import 'dart:math';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leave_me_alone/components/app_elevated_button.dart';
import 'package:leave_me_alone/components/character_block.dart';
import 'package:leave_me_alone/components/responsive_layout_builder.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _focusNode = FocusNode()..requestFocus();
    return Scaffold(
      body: ResponsiveLayoutBuilder(
        mobile: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _OnboardTitle(
                    fontSize: 48,
                  ),
                  const _OnboardSubtitle(
                    fontSize: 24,
                  ),
                  const _CharactersRow(
                    minWidth: 264,
                  ),
                  _OnboardStartButton(
                    fontSize: 24,
                    minWidth: 264,
                    parentFocusNode: _focusNode,
                  ),
                ],
              ),
            ),
          ),
        ),
        desktop: Container(
          padding: EdgeInsets.symmetric(
            vertical: 128 * MediaQuery.of(context).size.height / 1024,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const _OnboardTitle(
                      fontSize: 96,
                    ),
                    const _OnboardSubtitle(
                      fontSize: 36,
                    ),
                    const Flexible(
                      child: _CharactersRow(),
                    ),
                    _OnboardStartButton(
                      fontSize: 36,
                      parentFocusNode: _focusNode,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardTitle extends StatelessWidget {
  final double fontSize;

  const _OnboardTitle({
    Key? key,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'LEAVE ME ALONE',
      style: TextStyle(
        fontFamily: 'ThinkBig',
        fontSize: fontSize,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _OnboardSubtitle extends StatelessWidget {
  final double fontSize;

  const _OnboardSubtitle({
    Key? key,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'a stupid game',
      style: TextStyle(
        fontFamily: 'HandWriting',
        fontSize: fontSize,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _CharactersRow extends StatelessWidget {
  final double? minWidth;

  const _CharactersRow({
    Key? key,
    this.minWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 72 * MediaQuery.of(context).size.height / 1024,
              horizontal: 24
            ),
            width: minWidth == null
                ? constraints.maxWidth
                : min(minWidth!, constraints.maxWidth),
            child: Row(
              children: [
                const Expanded(
                  flex: 8,
                  child: CharacterBlock(
                    shakeOnHover: true,
                    imageUrl: 'assets/images/charactera.png',
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                const Expanded(
                  flex: 8,
                  child: CharacterBlock(
                    shakeOnHover: true,
                    imageUrl: 'assets/images/characterb.png',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OnboardStartButton extends StatelessWidget {
  final double fontSize;
  final double? minWidth;
  final FocusNode parentFocusNode;

  const _OnboardStartButton({
    Key? key,
    required this.fontSize,
    this.minWidth,
    required this.parentFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AppElevatedButton(
            width: minWidth == null
                ? constraints.maxWidth
                : min(minWidth!, constraints.maxWidth),
            height: fontSize * 1.5,
            title: 'start now',
            fontSize: fontSize,
            onTap: () {
              context.beamToNamed('/difficulties');
            },
            parentFocusNode: parentFocusNode,
            defaultPhysicalKey: PhysicalKeyboardKey.enter,
          );
        },
      ),
    );
  }
}
