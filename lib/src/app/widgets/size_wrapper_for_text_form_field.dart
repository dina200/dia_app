import 'package:flutter/material.dart';

class SizeWrapperForTextFormField extends StatelessWidget {
  final TextFormField child;

  const SizeWrapperForTextFormField({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      child: child,
    );
  }
}
