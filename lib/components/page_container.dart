import 'package:flutter/material.dart';
import 'package:leave_me_alone/components/app_header.dart';
import 'package:leave_me_alone/components/audio_control.dart';

class PageContainer extends StatelessWidget {
  final Widget child;

  const PageContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 64),
                child: child,
              ),
            ),
            const AppHeader(),
            const Positioned(
              right: 32,
              top: 32,
              child: AudioControl(),
            ),
          ],
        ),
      ),
    );
  }
}
