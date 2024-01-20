import 'package:flutter/material.dart';
import 'package:frontend/common/custom-shapes/circular_container.dart';
import 'package:frontend/common/custom-shapes/curved_edge_widget.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      child: Container(
          color: Color(0xFF4b68ff),
          padding: const EdgeInsets.all(0),
          child: SizedBox(
            height: 450,
            child: Stack(
              children: [
                Positioned(
                    top: -150,
                    right: -250,
                    child: CircularContainer(
                        backgroundColor: Color(0xFF333333).withOpacity(0.1))),
                Positioned(
                    top: 100,
                    right: -300,
                    child: CircularContainer(
                        backgroundColor: Color(0xFF333333).withOpacity(0.1))),
                child,
              ],
            ),
          )),
    );
  }
}
