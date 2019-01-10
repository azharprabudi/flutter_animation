import 'package:flutter/material.dart';

class SlideAnimation extends StatefulWidget {
  @override
  _SlideAnimationState createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation>
    with TickerProviderStateMixin {
  Animation _animationWidth;
  Animation _animationHeight;
  AnimationController _animationWidthController;
  AnimationController _animationHeightController;

  @override
  void initState() {
    _animationWidthController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animationHeightController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animationWidth = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationWidthController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _animationHeight = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationHeightController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _animationWidthController.forward();
    _animationHeightController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationWidthController.dispose();
    _animationHeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height - 100;

    return Scaffold(
      appBar: AppBar(
        title: Text('Slide Animation'),
      ),
      body: AnimatedBuilder(
        animation: _animationWidth,
        builder: (BuildContext context, Widget child) => AnimatedBuilder(
              animation: _animationHeight,
              builder: (BuildContext context, Widget child) => Transform(
                    transform: Matrix4.translationValues(
                      _animationWidth.value * width,
                      _animationHeight.value * height,
                      0,
                    ),
                    child: Container(
                      child: Text('ah enak'),
                    ),
                  ),
            ),
      ),
    );
  }
}
