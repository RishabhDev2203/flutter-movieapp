import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/util/component/back_button.dart';
import 'package:flutter_firebase_ott/util/component/sub_title_text.dart';
import 'package:flutter_ideal_ott_api/dto/category_dto.dart';

import '../../util/app_colors.dart';
import '../../util/constants.dart';
import '../../util/dimensions.dart';

class SeeAllPage extends StatefulWidget {
  final String type;
  List<CategoryDto?>? seeAllList;
   SeeAllPage({Key? key, required this.type,required this.seeAllList}) : super(key: key);

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.bg,
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
                  text: widget.type,
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
            const SizedBox(height: 50,),
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
          itemCount: widget.seeAllList?.length ?? 0 ,
          itemBuilder: (BuildContext ctx, index) {
            return Container(
              decoration: BoxDecoration(
                  color: AppColors.containerBg,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: 190,
                      width: 190,
                      imageUrl:widget.seeAllList?[index]?.avatar??"",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.black38,
                        alignment: Alignment.center,
                        // child: Image.asset(
                        //     "assets/images/user_placeholder.png"),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.black38,
                        alignment: Alignment.center,
                        // child: Image.asset(
                        //     "assets/images/user_placeholder.png"),
                      ),
                    ),),
                  const SizedBox(height: 5,),

                   Text(widget.seeAllList?[index]?.title??"",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: Dimensions.textSizeSmall,
                          fontFamily: Constants.fontFamily,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white)),
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
