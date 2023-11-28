import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  final int currentIndex;
  final void Function(int) setBottomBarIndex;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.setBottomBarIndex
  });

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData  theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Container(
      color: Colors.transparent,
      width: size.width,
      height: 80,
      child: Stack(
        // overflow: Overflow.visible,
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: BNBCustomPainter(colorScheme.surface),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
              backgroundColor: colorScheme.primary,
              focusColor: theme.scaffoldBackgroundColor,
              child: Icon(Icons.shopping_basket),
              elevation: 0.1,
              onPressed: () {}
            ),
          ),
          Container(
            color: Colors.transparent,
            width: size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: widget.currentIndex == 0
                        ? colorScheme.primary
                        : colorScheme.onSurface,
                  ),
                  onPressed: () {
                    widget.setBottomBarIndex(0);
                  },
                  highlightColor: theme.scaffoldBackgroundColor,
                ),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: widget.currentIndex == 1
                        ? colorScheme.primary
                        : colorScheme.onSurface,
                  ),
                  onPressed: () {
                    widget.setBottomBarIndex(1);
                  }
                ),
                Container(
                  color: Colors.transparent,
                  width: size.width * 0.20,
                ),
                IconButton(
                  icon: Icon(
                    Icons.bookmark,
                    color: widget.currentIndex == 2
                        ? colorScheme.primary
                        : colorScheme.onSurface,
                  ),
                  onPressed: () {
                    widget.setBottomBarIndex(2);
                  }
                ),
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: widget.currentIndex == 3
                        ? colorScheme.primary
                        : colorScheme.onSurface,
                  ),
                  onPressed: () {
                    widget.setBottomBarIndex(3);
                  },
                  highlightColor: theme.scaffoldBackgroundColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  Color backgroundColor;

  BNBCustomPainter(this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: const Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
