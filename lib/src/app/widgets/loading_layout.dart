import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoadingLayout extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  LoadingLayout({
    Key key,
    @required this.isLoading,
    @required this.child,
  })  : assert(child != null),
        assert(isLoading != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> stack = [
      IgnorePointer(
        ignoring: isLoading,
        child: child,
      ),
    ];

    if (isLoading) {
      stack.add(
        SizedBox.expand(
          child: Container(
            color: Colors.black12,
            child: _LoadingIndicator(),
          ),
        ),
      );
    }

    return Stack(
      children: stack,
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS
          ? CupertinoActivityIndicator()
          : CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}