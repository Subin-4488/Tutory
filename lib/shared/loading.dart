import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingShared extends StatelessWidget {
  const LoadingShared({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness==Brightness.light?Colors.white:Colors.black,
      child: SpinKitCubeGrid(
        color: Colors.purple,
      ),
    );
  }
}
