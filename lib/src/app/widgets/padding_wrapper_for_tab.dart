import 'package:flutter/material.dart';

class PaddingWrapperForTab extends StatelessWidget {
  final Widget child;

  const PaddingWrapperForTab({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
      child: child,
    );
  }
}
