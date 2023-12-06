import 'package:flutter/material.dart';

import 'loading.dart';

class StackLoading extends StatelessWidget {
  const StackLoading({
    super.key,
    required this.child,
    required this.loadingCondition,
  });

  final Widget child;
  final Function loadingCondition;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        loadingCondition()
            ? Container(
                color: Colors.black54,
              )
            : Container(),
        loadingCondition()
            ? Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: Container(
                    color: const Color(0xFF31363B),
                    child: const Loading(),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
