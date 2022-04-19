import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/util/app_colors.dart';

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
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Image.asset("assets/images/arrow_left.png",height: 20,width: 20,color: AppColors.white,),
        ));
  }
}
