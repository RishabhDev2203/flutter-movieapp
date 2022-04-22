import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/util/component/back_button.dart';
import 'package:flutter_firebase_ott/util/component/sub_title_text.dart';
import 'package:flutter_firebase_ott/util/component/title_text.dart';

import '../../util/app_colors.dart';
import '../../util/constants.dart';
import '../../util/dimensions.dart';
import '../../util/strings.dart';

class SeeAllPage extends StatefulWidget {
  String? type;

  SeeAllPage({Key? key, this.type}) : super(key: key);

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.containerBg,
      // backgroundColor:AppColors.bg,
      body: Padding(
        padding: EdgeInsets.only(
            left: 16, right: 16, top: MediaQuery.of(context).padding.top + 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ButtonBack(),
                SubTitleText(
                  text: widget.type == "Action Movie"
                      ? "Action Movie"
                      : widget.type == "Adventure Movie"
                          ? "Adventure Movie"
                          : "Romantic Movie",
                  color: AppColors.white,
                  fontSize: Dimensions.textSizeXLarge,
                ),
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            movieListBody(),
          ],
        ),
      ),
    );
  }

  Widget movieListBody() {
    return Expanded(
      child: GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 4 / 5),
          itemCount: 10,
          itemBuilder: (BuildContext ctx, index) {
            return Container(
              decoration: BoxDecoration(
                  color: AppColors.navyBlueContainerColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: 190,
                      width: 190,
                      imageUrl:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBFz-2B5ao74f1IBlKFvDgarz9Rx-1kFwqcw&usqp=CAU",
                      fit: BoxFit.cover,
                      alignment: FractionalOffset.topCenter,
                      /*for align image*/
                      placeholder: (context, url) => Container(
                        color: Colors.black12,
                        alignment: Alignment.center,
                        child:
                            Image.asset("assets/images/user_placeholder.png"),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.black12,
                        alignment: Alignment.center,
                        child:
                            Image.asset("assets/images/user_placeholder.png"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text("Bad Blood",
                        style: TextStyle(
                            fontSize: Dimensions.textSizeSmall,
                            fontFamily: Constants.fontFamily,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white)),
                  ),
                ],
              ),
            );
          }),
    );
  }

  void refreshState() {
    setState(() {});
  }
}
