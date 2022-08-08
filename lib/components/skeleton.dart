import 'package:flutter/material.dart';

Decoration myBoxDec(animation, {isCircle = false}) {
  return BoxDecoration(
    shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xfff6f7f9),
        Color(0xffe9ebee),
        Color(0xfff6f7f9),
        // Color(0xfff6f7f9),
      ],
      stops: [
        // animation.value * 0.1,
        animation.value - 1,
        animation.value,
        animation.value + 1,
        // animation.value + 5,
        // 1.0,
      ],
    ),
  );
}

class PKCardSkeleton extends StatefulWidget {
  final bool isCircularImage;
  final bool isBottomLinesActive;
  PKCardSkeleton(
      {this.isCircularImage = true, this.isBottomLinesActive = true});
  @override
  _PKCardSkeletonState createState() => _PKCardSkeletonState();
}


class _PKCardSkeletonState extends State<PKCardSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = Tween<double>(begin: -1.0, end: 2.0).animate(
        CurvedAnimation(curve: Curves.easeInOutSine, parent: _controller));

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: width * 0.13,
                      width: width * 0.13,
                      decoration:
                      myBoxDec(animation, isCircle: widget.isCircularImage),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: width * 0.13,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: height * 0.008,
                            width: width * 0.3,
                            decoration: myBoxDec(animation),
                          ),
                          Container(
                            height: height * 0.007,
                            width: width * 0.2,
                            decoration: myBoxDec(animation),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                widget.isBottomLinesActive
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: height * 0.007,
                      width: width * 0.7,
                      decoration: myBoxDec(animation),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: height * 0.007,
                      width: width * 0.8,
                      decoration: myBoxDec(animation),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: height * 0.007,
                      width: width * 0.5,
                      decoration: myBoxDec(animation),
                    ),
                  ],
                )
                    : Offstage()
              ],
            ),
          ),
        );
      },
    );
  }
}



class PKImageSkeleton extends StatefulWidget {
  final bool isCircularImage;
  final double padding;
  PKImageSkeleton(
      {this.isCircularImage = true, this.padding = 16});
  @override
  _PKImageSkeletonState createState() => _PKImageSkeletonState();
}

class _PKImageSkeletonState extends State<PKImageSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = Tween<double>(begin: -1.0, end: 2.0).animate(
        CurvedAnimation(curve: Curves.easeInOutSine, parent: _controller));

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          height: height,
          width: width,
          color: Colors.white,
          padding: EdgeInsets.all(widget.padding),
          child: Container(
            decoration:
            myBoxDec(animation, isCircle: widget.isCircularImage),
          ),
        );
      },
    );
  }
}


class PKCardPageSkeleton extends StatefulWidget {
  final int totalLines;
  PKCardPageSkeleton({this.totalLines = 5});
  @override
  _PKCardPageSkeletonState createState() => _PKCardPageSkeletonState();
}

class _PKCardPageSkeletonState extends State<PKCardPageSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = Tween<double>(begin: -1.0, end: 2.0).animate(
        CurvedAnimation(curve: Curves.easeInOutSine, parent: _controller));

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                    widget.totalLines,
                        (i) => Column(
                      children: <Widget>[
                        Container(
                          height: height * 0.007,
                          width: width * 0.7,
                          decoration: myBoxDec(animation),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: height * 0.007,
                          width: width * 0.8,
                          decoration: myBoxDec(animation),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: height * 0.007,
                          width: width * 0.5,
                          decoration: myBoxDec(animation),
                        ),
                      ],
                    )).toList(),
              )),
        );
      },
    );
  }
}


// /// 骨架屏-卡片
Widget cardListSkeleton() {
  return PKCardSkeleton(
    isCircularImage: true,
    isBottomLinesActive: true,
  );
}

// /// 页面骨架屏
Widget pageSkeleton({int lines = 5}) {
  return PKCardPageSkeleton(
    totalLines: lines,
  );
}

// /// 图片-骨架屏
Widget imageSkeleton({bool isCircularImage = false, double padding = 0}) {
  return PKImageSkeleton(
    isCircularImage: isCircularImage,
    padding: padding,
  );
}
