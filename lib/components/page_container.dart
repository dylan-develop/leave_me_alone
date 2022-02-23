import 'package:flutter/material.dart';
import 'package:slide_puzzle/components/app_header.dart';

class PageContainer extends StatelessWidget {
  final Widget child;

  const PageContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(),
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
