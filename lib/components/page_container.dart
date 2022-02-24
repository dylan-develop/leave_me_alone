import 'package:flutter/material.dart';
import 'package:leave_me_alone/components/app_header.dart';

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
              padding: const EdgeInsets.symmetric(vertical: 64),
              child: child,
            ),
          ),
          const AppHeader(),
        ],
      )),
    );
  }
}
