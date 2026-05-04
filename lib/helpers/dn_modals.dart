import 'package:flutter/material.dart';

class DnModals {
  final BuildContext context;

  DnModals({required this.context});

  Future<dynamic> bottomSheet({
    required Widget child,
    bool isScrollControlled = false,
    VoidCallback? onTapCloseButton,
    VoidCallback? onDrag,
  }) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      isScrollControlled: isScrollControlled,
      context: context,
      isDismissible: false,
      enableDrag: false,
      showDragHandle: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
      ),
      builder: (BuildContext context) {
        return _DragWrapper(
          onDrag: onDrag,
          closeButton: onTapCloseButton,
          child: child,
        );
      },
    );
  }

  Future<void> showDialogWidget({
    required Widget child,
    bool barrierDismissible = true,
    Color? barrierColor,
    BorderRadiusGeometry borderRadius = const BorderRadius.all(Radius.circular(16)),
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? Colors.black54,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: child,
        );
      },
    );
  }
}

class _DragWrapper extends StatelessWidget {
  final Widget child;
  final VoidCallback? onDrag;
  final VoidCallback? closeButton;

  const _DragWrapper({
    required this.child,
    this.onDrag,
    this.closeButton,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onVerticalDragStart: (_) => {
              },//(onDrag != null) ? onDrag!() : context.pop(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Container(
                  width: 50,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: closeButton ?? () =>  {},//context.pop(),
              icon: const Icon(Icons.close),
            ),
          ),
          child
        ],
      ),
    );
  }
}
