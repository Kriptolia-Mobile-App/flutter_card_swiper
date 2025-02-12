import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PriorityCardSwipeDetector extends StatelessWidget {
  final Widget child;
  final GestureTapDragUpCallback onTap;
  final GestureTapDragStartCallback onPanStart;
  final GestureTapDragUpdateCallback onPanUpdate;
  final GestureTapDragEndCallback onPanEnd;

  const PriorityCardSwipeDetector({
    required this.child,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      behavior: HitTestBehavior.opaque,
      gestures: {
        _PriorityGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<_PriorityGestureRecognizer>(
          () => _PriorityGestureRecognizer(debugOwner: this),
          (_PriorityGestureRecognizer instance) {
            instance.onTapUp = onTap;
            instance.onDragStart = onPanStart;
            instance.onDragUpdate = onPanUpdate;
            instance.onDragEnd = onPanEnd;
          },
        ),
      },
      child: child,
    );
  }
}

class _PriorityGestureRecognizer extends TapAndPanGestureRecognizer {
  _PriorityGestureRecognizer({super.debugOwner});

  @override
  void addAllowedPointer(PointerDownEvent event) {
    super.addAllowedPointer(event);

    // This line accepts the gesture immediately
    //Look [EagerGestureRecognizer] from flutter source code to understand this better
    resolve(GestureDisposition.accepted);
  }
}
