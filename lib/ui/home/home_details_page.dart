import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_firebase_ott/util/component/back_button.dart';

import '../../util/app_colors.dart';
import '../../util/component/more_description.dart';
import '../../util/constants.dart';
import '../../util/dimensions.dart';
import '../../util/strings.dart';

class HomeDetailPage extends StatefulWidget {
  const HomeDetailPage({Key? key}) : super(key: key);

  @override
  State<HomeDetailPage> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondBg,
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 370,
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  imageUrl:'https://variety.com/wp-content/uploads/2016/09/maleficent.jpg?w=681&h=383&crop=1',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.black12,
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/user_placeholder.png",
                      fit: BoxFit.cover,
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.black12,
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/user_placeholder.png",
                        fit: BoxFit.cover,
                        height: 300,
                        width: MediaQuery.of(context).size.width),
                  ),
                ),
              ),
              AppColors.gradientOverlay(
                  370, MediaQuery.of(context).size.width, 0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 40, left: 10),
                    child: ButtonBack(),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Container(
                        height: 56,
                        width: 56,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppColors.red,
                            borderRadius: BorderRadius.circular(60)),
                        child: const ImageIcon(
                          AssetImage('assets/images/play.png'),
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 61,),
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text("Shang - Chi & the Legend of ten rights",
                        style: TextStyle(
                            fontSize: 28,
                            fontFamily: Constants.fontFamily,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white)
                    ),
                  ),
                  const SizedBox(height: 15,),
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text("Action, Crime, Adventure • 124 min",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: Constants.fontFamily,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textSecondary)
                    ),
                  )
                ],
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16,right: 16),
            child: Divider(
              color: AppColors.divider,thickness: 1,),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(left: 16,right: 16),
              children:  [
                const Text("Storyline",
                    style: TextStyle(
                        fontSize: Dimensions.textSizeMedium,
                        fontFamily: Constants.fontFamily,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white)
                ),
                SizedBox(height: 10,),
                const ReadMoreText(
                  "Nunc in fringilla libero, eget auctor nibh. Mauris eu est sagittis dolor accumsan tincidunt vel eu dolor. Mauris sed sollicitudin neque. Mauris egestas justo id tincidunt pulvinar. Mauris egestas justo id tincidunt pulvinar Nunc blandit nibh non leo rutrum porta.",
                  trimLines: 3,
                  colorClickableText: AppColors.red,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' Read More',
                  trimExpandedText: ' Less',
                  style: TextStyle(
                      fontSize: Dimensions.textSizeSmall,
                      fontFamily: Constants.fontFamily,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary),
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  const [
                    Text(Strings.recommended,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: Dimensions.textSizeLarge,
                          fontFamily: Constants.fontFamily,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white),
                    ),

                    Text(Strings.seeAll,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: Dimensions.textSizeMedium,
                          fontFamily: Constants.fontFamily,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary),
                    ),

                  ],
                ),
                const SizedBox(height: 16,),
                SizedBox(
                  height: 162,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return _recommendedList(index);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        width: 10,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16,),


              ],

            ),
          )
        ],
      ),
    );
  }
  Widget _recommendedList(int index){
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
              height: 130,
              width: 100,
              imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGwCtb_x-r40cuFN5J2aZ-xBiOdDO0CJDhpg&usqp=CAU",
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.black12,
                alignment: Alignment.center,
                child: Image.asset(
                    "assets/images/user_placeholder.png"),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.black12,
                alignment: Alignment.center,
                child: Image.asset(
                    "assets/images/user_placeholder.png"),
              ),
            ),),
          const SizedBox(height: 5,),

          const Text("Bad Blood",
              style: TextStyle(
                  fontSize: Dimensions.textSizeSmall,
                  fontFamily: Constants.fontFamily,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white)),

        ],
      ),
    );
  }
}
