import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StarButton extends StatefulWidget {
  StarButton({
    double iconSize,
    Color iconColor,
    bool isStarred,
    @required Function valueChanged,
    Key key,
  })  : _iconSize = iconSize ?? 60.0,
        _iconColor = iconColor ?? Colors.yellow,
        _isStarred = isStarred ?? false,
        _valueChanged = valueChanged,
        super(key: key);

  final double _iconSize;
  final Color _iconColor;
  final bool _isStarred;
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

  bool _isStarred = false;
  bool _isAnimationCompleted = false;

  @override
  void initState() {
    super.initState();

    _isStarred = widget._isStarred;
    _maxIconSize = (widget._iconSize < 20.0)
        ? 20.0
        : (widget._iconSize > 100.0)
            ? 100.0
            : widget._iconSize;
    final double _sizeDifference = _maxIconSize * 0.30;
    _minIconSize = _maxIconSize - _sizeDifference;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _animationTime),
    );

    _curve = CurvedAnimation(curve: Curves.slowMiddle, parent: _controller);
    Animation<Color> _selectedColorAnimation = ColorTween(
      begin: widget._iconColor,
      end: Colors.grey[400],
    ).animate(_curve);

    Animation<Color> _deSelectedColorAnimation = ColorTween(
      begin: Colors.grey[400],
      end: widget._iconColor,
    ).animate(_curve);

    // _colorAnimation = ColorTween(
    //   begin: Colors.grey[400],
    //   end: widget._iconColor,
    // ).animate(_curve);

    _colorAnimation = (_isStarred == true)
        ? _selectedColorAnimation
        : _deSelectedColorAnimation;
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
        _isAnimationCompleted = true;
        _isStarred = !_isStarred;
        widget._valueChanged(_isStarred);
      } else if (status == AnimationStatus.dismissed) {
        _isAnimationCompleted = false;
        _isStarred = !_isStarred;
        widget._valueChanged(_isStarred);
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
    //print("NEW _isFavorite $_isStarred");
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        return InkResponse(
          onTap: () {
            setState(() {
              if (_isAnimationCompleted == true) {
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
