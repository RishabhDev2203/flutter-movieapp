import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../dimensions.dart';

class ButtonBack extends StatefulWidget {
  const ButtonBack({Key? key}) : super(key: key);

  @override
  _ButtonBackState createState() => _ButtonBackState();
}

class _ButtonBackState extends State<ButtonBack> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pop(context);
      },
      child: Container(
        height: 32,width: 32,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset('assets/images/backarrow.png',scale: 4,),
      ),
    );
  }
}