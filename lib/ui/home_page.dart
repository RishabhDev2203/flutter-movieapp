import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_firebase_ott/util/strings.dart';

import '../util/app_colors.dart';
import '../util/constants.dart';
import '../util/dimensions.dart';
import 'home_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: AppColors.bg,
        body: Column(
          children: [
            const SizedBox(height: 15,),
            Container(
              height: 70,
              padding: const EdgeInsets.only(left: 10,right: 10),
              color: AppColors.header,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      width: 40,
                      height: 40,
                      imageUrl: "https://www.salesforce.com/blog/wp-content/uploads/sites/2/2021/06/2021-12-360BlogHeader-SalesforceAdmin.V3-1500x844-1.png",
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
                    ),
                  ),
                  Image.asset(
                    "assets/images/search.png",
                    width: 20,
                    height: 20,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                children: [
                  CarouselSlider.builder(
                    options: CarouselOptions(
                      aspectRatio: 4 / 3,
                      viewportFraction: 0.6,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      initialPage: 1,
                    ),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                     _getItem(itemIndex),
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(Strings.continuewtching,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: Dimensions.textSizeLarge,
                            fontFamily: Constants.fontFamily,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white),
                      ),

                      Text(Strings.seeall,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: Dimensions.textSizeMedium,
                            fontFamily: Constants.fontFamily,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textSecondary),
                      ),

                    ],
                  ),
                  const SizedBox(height: 15,),
                  SizedBox(
                    height: 130,
                    child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return _continueList(index);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        width: 10,
                      );
                    },
                ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(Strings.actionmovie,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: Dimensions.textSizeLarge,
                            fontFamily: Constants.fontFamily,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white),
                      ),

                      Text(Strings.seeall,
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
                        return _actionList(index);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 15,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(Strings.adventuremovie,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: Dimensions.textSizeLarge,
                            fontFamily: Constants.fontFamily,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white),
                      ),

                      Text(Strings.seeall,
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
                        return _adventureList(index);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 15,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(Strings.romanticmovie,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: Dimensions.textSizeLarge,
                            fontFamily: Constants.fontFamily,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white),
                      ),

                      Text(Strings.seeall,
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
                        return _romanticList(index);
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
  Widget _getItem(int index) {
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeDetailPage()));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          height: 120,
          width: 260,
          imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsqXq71F9jE6knN8oQAYNx16M-tPfaAibucg&usqp=CAU",
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
        ),
      ),
    );
  }
  Widget _continueList(int index){
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: CachedNetworkImage(
        height: 120,
        width: 196,
        imageUrl: "https://variety.com/wp-content/uploads/2016/09/maleficent.jpg?w=681&h=383&crop=1",
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
      ),
    );
  }
  Widget _actionList(int index){
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
                  imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBFz-2B5ao74f1IBlKFvDgarz9Rx-1kFwqcw&usqp=CAU",
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
  Widget _adventureList(int index){
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
              imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRxPaxjy_h_a4o4M0cWfdiRe25D-EZAbo4-w&usqp=CAU",
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

  Widget _romanticList(int index){
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
