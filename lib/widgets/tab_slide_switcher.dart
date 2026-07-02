import 'package:flutter/material.dart';

class TabSlideSwitcher extends StatefulWidget {
  const TabSlideSwitcher({
    super.key,
    required this.index,
    required this.children,
    this.duration = const Duration(milliseconds: 280),
  });

  final int index;
  final List<Widget> children;
  final Duration duration;

  @override
  State<TabSlideSwitcher> createState() => _TabSlideSwitcherState();
}

class _TabSlideSwitcherState extends State<TabSlideSwitcher>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late int _currentIndex;
  int? _previousIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..value = 1;
  }

  @override
  void didUpdateWidget(TabSlideSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != oldWidget.index) {
      _previousIndex = _currentIndex;
      _currentIndex = widget.index;
      _controller.forward(from: 0).whenComplete(() {
        if (mounted) {
          setState(() => _previousIndex = null);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isAnimating =>
      _previousIndex != null && (_controller.isAnimating || _controller.value < 1);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final forward = _currentIndex > (_previousIndex ?? _currentIndex);
    final delta = forward ? 1.0 : -1.0;

    return ClipRect(
      child: Stack(
        fit: StackFit.expand,
        children: [
          for (var i = 0; i < widget.children.length; i++)
            if (!_isAnimating && i == _currentIndex)
              widget.children[i]
            else if (!_isAnimating || (i != _currentIndex && i != _previousIndex))
              Offstage(
                offstage: true,
                child: TickerMode(
                  enabled: false,
                  child: widget.children[i],
                ),
              ),
          if (_isAnimating && _previousIndex != null) ...[
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(-delta * _controller.value * width, 0),
                  child: child,
                );
              },
              child: IgnorePointer(child: widget.children[_previousIndex!]),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(delta * (1 - _controller.value) * width, 0),
                  child: child,
                );
              },
              child: widget.children[_currentIndex],
            ),
          ],
        ],
      ),
    );
  }
}
