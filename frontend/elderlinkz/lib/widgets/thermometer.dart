import 'package:flutter/material.dart';

class ThermometerWidget extends ImplicitlyAnimatedWidget {

  const ThermometerWidget({
    super.key,
    super.onEnd,
    super.curve = Curves.easeOutBack,
    super.duration = const Duration(milliseconds: 1000),
    required this.color,
    required this.value,
    this.padding = const EdgeInsets.all(8),
    this.side = const BorderSide(
      width: 6,
      color: Colors.white,
    ),
    this.shadow  = const BoxShadow(
      blurRadius: 6,
      color: Colors.black87,
      offset: Offset(2, 2),
    ),
  });

  final Color color;
  final double value;
  final BorderSide side;
  final BoxShadow? shadow;
  final EdgeInsetsGeometry padding;

  @override
  AnimatedWidgetBaseState<ThermometerWidget> createState() => _ThermometerWidgetState();

}

class _ThermometerWidgetState extends AnimatedWidgetBaseState<ThermometerWidget> {

  ColorTween? _color;
  Tween<double>? _value;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {

    _color = visitor(
      _color,
      widget.color,
      (v) =>
        ColorTween(begin: v)
    ) as ColorTween?;

    _value = visitor(
      _value,
      widget.value,
      (v) =>
        Tween<double>(begin: v)
    ) as Tween<double>?;

  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: widget.padding,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shadows: widget.shadow != null ?
            [ widget.shadow! ] :
            null,
          shape: ThermoShape(
            side: widget.side,
            color: _color
              !.evaluate(animation)!,
            value: _value
              !.evaluate(animation),
          ),
        ),
      )
    );

  }

}









class ThermoShape extends OutlinedBorder {
  const ThermoShape({
    super.side,
    required this.color,
    required this.value,
  });

  final Color color;
  final double value;

  static const kWidthFactor = 0.55;

  @override
  ShapeBorder scale(double t) => this;

  @override
  OutlinedBorder copyWith({BorderSide? side}) {
    return ThermoShape(
      side: side ?? this.side,
      color: color,
      value: value,
    );
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => getOuterPath(rect);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {

    final maxValueRect = Alignment.topCenter
      .inscribe(
        Size(rect.width * kWidthFactor, rect.height),
        rect
      );
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          maxValueRect,
          Radius.circular(
            maxValueRect.width / 2
          )
        )
      )
      ..addOval(
        Alignment.bottomCenter
        .inscribe(
          Size(
            rect.width, rect.width),
            rect
          )
        );

  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
      
    final bulbRect = Alignment.bottomCenter
      .inscribe(
        Size
          .square(rect.width),
        rect
      )
      .deflate(side.width);

    final meterRect = Alignment.bottomCenter
      .inscribe(
        Size(
          rect.width * kWidthFactor - 2 * side.width,
          rect.height - 2 * side.width
        ),
        bulbRect
      );

    final valueRect = Rect
      .lerp(
        meterRect
          .intersect(bulbRect),
        meterRect,
        value
      ) ??
      Rect.zero;

    canvas
      .drawPath(
        getOuterPath(rect),
        Paint()..color = side.color
      );
    
    canvas
      .drawPath(
        Path()
          ..addRRect(
            RRect
              .fromRectAndRadius(
                valueRect,
                Radius
                  .circular(valueRect.width / 2)
              )
          )
          ..addOval(bulbRect),
        Paint()..color = color
      );

  }
}