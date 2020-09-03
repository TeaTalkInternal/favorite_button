import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StarButton extends StatefulWidget {
  StarButton({
    double iconSize,
    Color iconColor,
    @required Function valueChanged,
    Key key,
  })  : _iconSize = iconSize ?? 60.0,
        _iconColor = iconColor ?? Colors.yellow,
        _valueChanged = valueChanged,
        super(key: key);

  final double _iconSize;
  final Color _iconColor;
  final Function _valueChanged;

  @override
  _StarButtonState createState() => _StarButtonState();
}

class _StarButtonState extends State<StarButton> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _colorAnimation;
  Animation<double> _sizeAnimation;

  CurvedAnimation _curve;

  double _maxIconSize = 0.0;
  double _minIconSize = 0.0;

  final int _animationTime = 400;

  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();

    _maxIconSize = (widget._iconSize < 20.0)
        ? 20.0
        : (widget._iconSize > 100.0) ? 100.0 : widget._iconSize;
    final double _sizeDifference = _maxIconSize * 0.30;
    _minIconSize = _maxIconSize - _sizeDifference;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _animationTime),
    );

    _curve = CurvedAnimation(curve: Curves.slowMiddle, parent: _controller);
    _colorAnimation = ColorTween(
      begin: Colors.grey[400],
      end: widget._iconColor,
    ).animate(_curve);

    _sizeAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: _minIconSize,
            end: _maxIconSize,
          ),
          weight: 50,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: _maxIconSize,
            end: _minIconSize,
          ),
          weight: 50,
        ),
      ],
    ).animate(_curve);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isFavorite = true;
        widget._valueChanged(_isFavorite);
      } else if (status == AnimationStatus.dismissed) {
        _isFavorite = false;
        widget._valueChanged(_isFavorite);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        return InkResponse(
          onTap: () {
            setState(() {
              if (_isFavorite == true) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
            });
          },
          child: Icon(
            (Icons.star),
            color: _colorAnimation.value,
            size: _sizeAnimation.value,
          ),
        );
      },
    );
  }
}
