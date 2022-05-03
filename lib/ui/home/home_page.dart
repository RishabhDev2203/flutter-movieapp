import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/bloc/cubit/home_cubit.dart';
import 'package:flutter_firebase_ott/ui/home/home_search_page.dart';
import 'package:flutter_firebase_ott/ui/home/see_all_page.dart';
import 'package:flutter_firebase_ott/ui/profile/profile_page.dart';
import 'package:flutter_firebase_ott/util/strings.dart';
import 'package:flutter_ideal_ott_api/dto/category_dto.dart';
import 'package:flutter_ideal_ott_api/dto/library_dto.dart';
import 'package:flutter_ideal_ott_api/repository/home_repository.dart';
import '../../bloc/api_resp_state.dart';
import '../../util/app_colors.dart';
import '../../util/constants.dart';
import '../../util/dimensions.dart';
import '../../util/utility.dart';
import 'home_details_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeCubit? _bannerCubit;
  HomeCubit? _categoryCubit;
  List<LibraryDto?>? _libraryList;
  List<CategoryDto?>? _categoryList;

  @override
  void initState() {
    _bannerCubit = HomeCubit(HomeRepository());
    _categoryCubit = HomeCubit(HomeRepository());
    getBannerMovieList();
    getCategoryMovieList();
    super.initState();
  }

  @override
  void dispose() {
    _bannerCubit?.close();
    _bannerCubit = null;
    _categoryCubit?.close();
    _categoryCubit = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<HomeCubit, ResponseState>(
            bloc: _bannerCubit,
            listener: (context, state) {
              if (state is ResponseStateLoading) {
              } else if (state is ResponseStateError) {
                Utility.hideLoader(context);
                var error  = state.errorMessage;
                Utility.showAlertDialog(context, error);
              } else if (state is ResponseStateSuccess) {
                Utility.hideLoader(context);
                if(state.data != null){
                  _libraryList = state.data;
                  setState(() {});
                }
              }
            },
          ),
          BlocListener<HomeCubit, ResponseState>(
            bloc: _categoryCubit,
            listener: (context, state) {
              if (state is ResponseStateLoading) {
              } else if (state is ResponseStateError) {
                Utility.hideLoader(context);
                var error  = state.errorMessage;
                Utility.showAlertDialog(context, error);
              } else if (state is ResponseStateSuccess) {
                Utility.hideLoader(context);
                if(state.data != null){
                  _categoryList = state.data;
                  setState(() {});
                }
              }
            },
          ),
        ],
        child: Scaffold(
            backgroundColor: AppColors.bg,
            body: _getBody()
        )
    );
  }

  _getBody(){
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top,),
      child: Column(
        children: [
          Container(
            height: 70,
            padding: const EdgeInsets.only(left: 10,right: 10),
            color: AppColors.header,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){

                     Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
                  },
                  child: ClipRRect(
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
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeSearchPage()),
                    );
                    // getBannerMovieList();
                  //  getCategoryMovieList();
                  },
                  child: Image.asset(
                    "assets/images/search.png",
                    width: 20,
                    height: 20,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                CarouselSlider.builder(
                  options: CarouselOptions(
                    aspectRatio: 4 / 3,
                    viewportFraction: 0.6,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    initialPage: 1,
                  ),
                  itemCount: _libraryList?.length ?? 10,
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                      _getItem(itemIndex),
                ),
                const SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(Strings.continueWatching,
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
                const SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    const Text(Strings.actionMovie,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: Dimensions.textSizeLarge,
                          fontFamily: Constants.fontFamily,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white),
                    ),

                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  SeeAllPage(type: Strings.actionMovie,seeAllList: _categoryList,)),
                        );
                      },
                      child: const Text(Strings.seeAll,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: Dimensions.textSizeMedium,
                            fontFamily: Constants.fontFamily,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textSecondary),
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 162,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: _categoryList?.length ?? 0,
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
                const SizedBox(height: 50,),
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
                builder: (context) => HomeDetailPage(id: _libraryList?[index]?.id,coverImage:_libraryList?[index]?.thumbnails?[0].url ,)));
        print("_libraryList?[index]?.thumbnails?[0].url ?? "" ?????????? ${_libraryList?[index]?.videoContent?.outputUrl ?? ""}");
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          height: 120,
          width: 260,
          imageUrl: _libraryList?[index]?.thumbnails?[0].url ?? "",
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
        ),
      ),
    );
  }

  Widget _continueList(int index){
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            height: 120,
            width: 196,
            imageUrl: "https://variety.com/wp-content/uploads/2016/09/maleficent.jpg?w=681&h=383&crop=1",
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
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 35,left:10,right: 10 ),
          alignment: Alignment.bottomCenter,
          width: 196,
          child: const LinearProgressIndicator(
            value: 0.5,color:Colors.white,
            valueColor:  AlwaysStoppedAnimation<Color>(AppColors.red),
            minHeight: 1.7,
          ),
        ),

        Container(
          padding: const EdgeInsets.only(bottom: 20,left:10,right: 10 ),
          alignment: Alignment.bottomCenter,
          width: 196,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("1:10:20",
                  style: TextStyle(
                      fontSize: Dimensions.textSmall,
                      fontFamily: Constants.fontFamily,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white)),
              Text("2:5:20",
                  style: TextStyle(
                      fontSize: Dimensions.textSmall,
                      fontFamily: Constants.fontFamily,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white)),
            ],
          ),
        )
      ],
    );
  }

  Widget _actionList(int index){
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeDetailPage(id: _categoryList?[index]?.library?.id,coverImage:_libraryList?[index]?.thumbnails?[0].url)));
      },
      child: Container(
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
                imageUrl: _categoryList?[index]?.avatar??"",
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

             Text(_categoryList?[index]?.title??"",
                 maxLines: 1,
                 overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: Dimensions.textSizeSmall,
                    fontFamily: Constants.fontFamily,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white)),

          ],
        ),
      ),
    );
  }

  getBannerMovieList(){
    // _bannerCubit = HomeCubit(HomeRepository());
    _bannerCubit?.getBannerMovies();
  }

  getCategoryMovieList(){
    _categoryCubit?.getMovieCategory();
  }
}
