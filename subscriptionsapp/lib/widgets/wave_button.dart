import 'package:flutter/material.dart';
import 'dart:math' as math;


class WaveButton extends StatefulWidget {

  final Widget child;
  final VoidCallback? onPressed;
  final Color waveColor;
  final Duration animationDuration;

  const WaveButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.waveColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 600),
  });


  @override
  State<WaveButton> createState() => _WaveButtonState();
}


class _WaveButtonState extends State<WaveButton> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;

  late Animation<double> _radiusAnimation;

  late Animation<double> _opacityAnimation;

  Offset? _tapPosition;

  Size? _buttonSize;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration
      );

      _radiusAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic)
      );

      _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut)
      );

      _animationController.addListener(() {
        setState((){});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails detail) {
    if (widget.onPressed == null) return;
    setState(() {
      _tapPosition = detail.localPosition;
    });
    _animationController.reset();
    _animationController.forward();
  }

  double _getMaxRadius(Size size) {
    if(_tapPosition == null) return 0.0;
    final double dx = math.max(_tapPosition!.dx, size.width - _tapPosition!.dx);
    final double dy = math.max(_tapPosition!.dy, size.height - _tapPosition!.dy);
    return math.sqrt(dx * dx + dy * dy); // c^2 = a^2 + b^;
  }

  void buttonLogic() {
    print('button logic to execute');
    widget.onPressed!();
  }

  @override
  Widget build(BuildContext context) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if(context.mounted) {
          final RenderBox renderBox = context.findRenderObject() as RenderBox;
          if (_buttonSize != renderBox.size) {
            setState(() {
              _buttonSize = renderBox.size;
            });
          }
        }
      });

      return GestureDetector(
        onTapDown: _handleTapDown,
        onTap: buttonLogic,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 220,
              height: 60,
              child: ElevatedButton(
                onPressed: buttonLogic, 
                style: ElevatedButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white
                ),
                child: widget.child
                ),
            ),
            if(_tapPosition != null && _buttonSize != null) 
            Positioned.fill(child: CustomPaint(
              painter: _WavePainter(
                tapPosition: _tapPosition!,
                animationRadius: _radiusAnimation.value * _getMaxRadius(_buttonSize!),
                animationOpacity: _opacityAnimation.value,
                waveColor: widget.waveColor),
            ))
          ],
        ),
      );
  }

}



class _WavePainter extends CustomPainter {

  final Offset tapPosition;

  final double animationRadius;
  final double animationOpacity;

  final Color waveColor;

  _WavePainter({
    required this.tapPosition,
    required this.animationRadius,
    required this.animationOpacity,
    required this.waveColor
  });

  @override
 void paint(Canvas canvas, Size size) {
  final paint = Paint()
  ..color = waveColor.withOpacity(animationOpacity)
  ..style = PaintingStyle.fill;
  canvas.drawCircle(tapPosition, animationRadius, paint);
 }


 @override
 bool shouldRepaint(_WavePainter oldDelegate) {
  return oldDelegate.animationRadius != animationRadius ||
        oldDelegate.animationOpacity != animationOpacity ||
        oldDelegate.tapPosition != tapPosition;
 }

}