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
    this.onPressed,
    this.waveColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 600),
  });
  
  @override
  State<WaveButton> createState() => _WaveButtonState();
}

class _WaveButtonState extends State<WaveButton>
    with SingleTickerProviderStateMixin {
  // El animation controller maneja el progreso de la animacion 0-100%
  late AnimationController _animationController;

  // La animacion que controla el radio expansivo de la onda
  late Animation<double> _radiusAnimation;

  // La animacion que controla la opacidad
  late Animation<double> _opacityAnimation;

  // guarda la posicion en la que el usuario hace tap
  Offset? _tapPosition;

  // guarda el tamaño del botón
  Size? _buttonSize;

  @override
  void initState() {
    super.initState();
    // Inicializa al animation controller. vsync es necesario para evitar
    // el consumo excesivo de recursos cuando no se esta en pantalla
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration, // configura el tiempo total de la animacion
    );

    // Define como el radio de la animacion cambia en el tiempo
    // CurvedAnimation lo hace sentir mas suave
    _radiusAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic, // la curva inicia rapido y termina lento.
      ),
    );

    // Define como la transparencia cambia en el tiempo.
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut, // hace que se desvanezca suave
      ),
    );

    // agrega un listener. cualquier valor de la animacion cambia, 
    // le notifica a flutter rehacer este widget, asi la onda puede ser re-dibujada.
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Esta funcion es llamada cuando el usuario hace tap e inicia la animacion
  void _handleTapDown(TapDownDetails details) {
    // verifica que hay un callback!
    if (widget.onPressed == null) return;
    setState(() {
      _tapPosition = details.localPosition;
    });
    _animationController.reset();
    _animationController.forward();
  }

  double _getMaxRadius(Size size) {
    if (_tapPosition == null) return 0.0;

    final double dx = math.max(_tapPosition!.dx, size.width - _tapPosition!.dx);
    final double dy = math.max(_tapPosition!.dy, size.height - _tapPosition!.dy);
    return math.sqrt(dx * dx + dy * dy); // c^2 = a^2 + b^2
  }

  void customButtonLogic() {
    print('Custom button logic!');
    widget.onPressed!();
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback es utilizado para obtener el tamaño
    // del boton despues de que se ha dibujado en la pantalla.
    // Este es importante porque necesitamos que el tamaño del boton para 
    // calcular la maxima onda.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        if (_buttonSize != renderBox.size) {
          setState(() {
            _buttonSize = renderBox.size;
          });
        }
      }
    });

    return GestureDetector(
      onTapDown: _handleTapDown, // se ejecuta la animacion en este evento.
      onTap: customButtonLogic, // Ejecuta el codigo que necesitamos ejecutar.
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 220,
            height: 60,
            child: ElevatedButton(
              onPressed: customButtonLogic,
              style: ElevatedButton.styleFrom(
                // Remueve el efecto de splash para evitar el conflicto con nuestra onda
                splashFactory: NoSplash.splashFactory,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
              child: widget.child,
            ),
          ),
          if (_tapPosition != null && _buttonSize != null)
            Positioned.fill(
              child: CustomPaint(
                painter: _WavePainter(
                  tapPosition: _tapPosition!, // el centro de la onda
                  // El radio actual de la onda, escalado por el progreso de la animacion
                  animationRadius: _radiusAnimation.value * _getMaxRadius(_buttonSize!),
                  animationOpacity: _opacityAnimation.value, // la transparencia actual de la onda.
                  waveColor: widget.waveColor, // El color de la onda
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// un Custom painter es responsable de dibujar la expansion y desaparacion de la onda.
class _WavePainter extends CustomPainter {
  /// el punto central de la onda
  final Offset tapPosition;

  /// el tamaño del circulo.
  final double animationRadius;
  final double animationOpacity;

  /// El color de la onda
  final Color waveColor;

  _WavePainter({
    required this.tapPosition,
    required this.animationRadius,
    required this.animationOpacity,
    required this.waveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = waveColor.withOpacity(animationOpacity)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(tapPosition, animationRadius, paint);
  }

  @override
  // Este metodo le dice a flutter que es lo que debe de redibujar
  bool shouldRepaint(_WavePainter oldDelegate) {
    return oldDelegate.animationRadius != animationRadius ||
        oldDelegate.animationOpacity != animationOpacity ||
        oldDelegate.tapPosition != tapPosition;
  }
}