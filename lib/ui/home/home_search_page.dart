import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/util/component/back_button.dart';
import 'package:flutter_firebase_ott/util/component/sub_title_text.dart';
import 'package:flutter_firebase_ott/util/component/title_text.dart';

import '../../util/app_colors.dart';
import '../../util/dimensions.dart';
import '../../util/strings.dart';

class HomeSearchPage extends StatefulWidget {
  const HomeSearchPage({Key? key}) : super(key: key);

  @override
  State<HomeSearchPage> createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends State<HomeSearchPage> {
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.containerBg,
      body: Padding(
        padding: EdgeInsets.only(left: 16,right: 16,top: MediaQuery.of(context).padding.top+30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ButtonBack(),
                SubTitleText(text: Strings.search,fontSize: Dimensions.textSizeXLarge,color: AppColors.white,),
                SizedBox(height: 32,width: 20,)
              ],
            ),
            const SizedBox(height: 20,),
           searchView(),
            const SizedBox(height: 20,),
            const SubTitleText(text: 'All Movies',color: AppColors.grey,fontSize: Dimensions.textSizeLarge,fontWeight: FontWeight.w500,),
            const SizedBox(height: 10,),
            movieBody(),
          ],
        ),
      ),
    );
  }

  Widget searchView(){
    return Container(
      decoration: BoxDecoration(
        color: AppColors.navyBlueContainerColor,
        // border: Border.all(color: AppColors.containerBorder),
        borderRadius: BorderRadius.circular(Dimensions.cornerRadiusMedium),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: Strings.search,
          prefixIcon: IconButton(
            icon: Image.asset(
              "assets/images/search.png",
              color: AppColors.grey,
              height: 20,
              width: 20,
            ),
            onPressed: null,
          ),
          hintStyle: const TextStyle(
              color: AppColors.grey,
              fontSize: Dimensions.textSizeSmall,
              fontWeight: FontWeight.w500),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(left: 40,right: 16),
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: const ImageIcon(
                AssetImage('assets/images/close.png'),
                color: AppColors.grey,
              ),
            ),
          ),
          border: InputBorder.none,
        ),
        style: const TextStyle(
            fontSize: Dimensions.textSizeMedium,
            fontWeight: FontWeight.w400,
            color: AppColors.white),
        onChanged: (text) {
         searchText = text;
          },
      ),
    );
  }

  Widget movieBody() {
   return Expanded(
     child: ListView.separated(
       scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return movieList(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
      ),
   );
  }

  Widget movieList(int index){
    return Container(
      padding: const EdgeInsets.only(left: 16,right: 10),
      decoration: BoxDecoration(
        color: AppColors.navyBlueContainerColor,
        // border: Border.all(color: AppColors.containerBorder),
        borderRadius: BorderRadius.circular(Dimensions.cornerRadiusMedium),
      ),
      height: 110,
      child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  width: 150,
                  height: 70,
                  imageUrl: "https://wallpapercave.com/wp/wp6239429.jpg",
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
              const SizedBox(width: 20,),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "**Jab We Met**",
                      maxLines: 2,
                      overflow:TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Dimensions.textSizeMedium,
                        fontWeight: FontWeight.w400,
                      color: AppColors.white),
                    ),
                    SizedBox(height: 2,),
                    SizedBox(
                      width: 180,
                      child: Text(
                        "A Beautiful Love Story Written by Imtiaz Ali. Primarily based in Mumbai, Bhatinda, and Shimla, Jab We Met tells the story of a feisty Punjabi girl, Geet Dhillon, who is sent off track when she bumps into a depressed Mumbai businessman, Aditya Kashyap, on an overnight train to Delhi.",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Dimensions.textSizeSmall,
                          fontWeight: FontWeight.w400,
                            color: AppColors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }

  void refreshState(){
    setState(() {});
  }
}
