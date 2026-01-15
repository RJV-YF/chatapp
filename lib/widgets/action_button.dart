// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class ActionButton extends StatefulWidget {
//   final String text;
//   final VoidCallback onTap;

//   const ActionButton({super.key, required this.text, required this.onTap});

//   @override
//   State<ActionButton> createState() => _ActionButtonState();
// }

// class _ActionButtonState extends State<ActionButton>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 120),
//       lowerBound: 0.0,
//       upperBound: 0.04,
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _onTapDown(_) => _controller.forward();
//   void _onTapUp(_) {
//     _controller.reverse();
//     widget.onTap();
//   }

//   void _onTapCancel() => _controller.reverse();

//   @override
//   Widget build(BuildContext context) {
//     final scale = 1 - _controller.value;

//     return GestureDetector(
//       onTapDown: _onTapDown,
//       onTapUp: _onTapUp,
//       onTapCancel: _onTapCancel,
//       child: Transform.scale(
//         scale: scale,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 120),
//           width: double.infinity,
//           height: 54,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             gradient: const LinearGradient(
//               begin: Alignment.centerLeft,
//               end: Alignment.centerRight,
//               colors: [CupertinoColors.activeGreen, Color(0xFF16A34A)],
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(
//                   _controller.isAnimating ? 0.08 : 0.15,
//                 ),
//                 blurRadius: _controller.isAnimating ? 10 : 18,
//                 offset: Offset(0, _controller.isAnimating ? 4 : 8),
//               ),
//             ],
//           ),
//           alignment: Alignment.center,
//           child: Text(
//             widget.text,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 17,
//               fontWeight: FontWeight.w600,
//               letterSpacing: 0.7,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const ActionButton({super.key, required this.text, required this.onTap});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails _) {
    setState(() => _isPressed = true);
  }

  void _onTapUp(TapUpDetails _) {
    setState(() => _isPressed = false);
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 110),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 110),
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: _isPressed
                  ? const [Color(0xFF16A34A), Color(0xFF15803D)]
                  : const [CupertinoColors.activeGreen, Color(0xFF16A34A)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_isPressed ? 0.08 : 0.16),
                blurRadius: _isPressed ? 8 : 18,
                offset: Offset(0, _isPressed ? 3 : 8),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.7,
            ),
          ),
        ),
      ),
    );
  }
}
