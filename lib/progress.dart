import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProgressDialog {
  final BuildContext context;
  var isShow = false;

  ProgressDialog(this.context);

  void show() {
    if (isShow) return;

    isShow = true;

    showDialog(
        context: context,
        builder: (ctx){
          return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            child: Container(
              alignment: Alignment.center,
              child: Lottie.asset('assets/Car.json'),
            ),
          );
        }
    );
  }

  void hide(){
    if (isShow){
      Navigator.of(context).pop();
      isShow = false;
    }
  }
}