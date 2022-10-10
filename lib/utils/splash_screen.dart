import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/utils/my_state.dart';
import 'package:image/widgets/bottom_nav_bar.dart';

class SpashScreen extends StatefulWidget {
  const SpashScreen({
    Key? key,
    required this.controller,
    required this.pages,
    required this.pageState,
  }) : super(key: key);
  final PageController controller;
  final List<Widget> pages;
  final PageState pageState;

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
        reverseCurve: Curves.bounceInOut);
    _animationController.forward();
    Timer(
      const Duration(milliseconds: 3000),
      () => Navigator.push(context, MaterialPageRoute(
        builder: (_) {
          return WillPopScope(
            child: Scaffold(
              body: PageView(
                physics: const BouncingScrollPhysics(),
                controller: widget.controller,
                children: widget.pages,
                onPageChanged: (value) {
                  widget.pageState.changePage(value);
                },
              ),
              bottomNavigationBar: BottomNavBar(
                pageController: widget.controller,
              ),
            ),
            onWillPop: () async {
              if (widget.pageState.currentPage != 0) {
                widget.pageState.changePage(0);
                widget.controller.jumpTo(0);
                return false;
              } else {
                return true;
              }
            },
          );
        },
      )),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.red,
          Colors.pink,
          Colors.purple,
        ])),
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Image.asset("assets/images/splash.gif"),
          ),
        ),
      ),
    );
  }
}
