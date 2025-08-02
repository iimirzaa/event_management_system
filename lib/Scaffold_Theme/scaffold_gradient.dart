import 'package:flutter/material.dart';
class GradientScaffold extends StatelessWidget {
  final PreferredSizeWidget? AppBar;
  final Widget? body;
  const GradientScaffold({super.key,
   this.body,
  this.AppBar});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient:LinearGradient(colors: [
          Color(0xFF1f1c2c),
          Color(0xFF928dab)
        ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,),

      ),
      child:  Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar,
        body: body
        ),



    );
  }
}
