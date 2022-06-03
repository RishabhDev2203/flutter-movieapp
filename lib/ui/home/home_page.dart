import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/ui/home/see_all_page.dart';
import 'package:flutter_firebase_ott/ui/home/sub_category_page.dart';
import 'package:flutter_ideal_ott_api/dto/category_dto.dart';
import 'package:flutter_ideal_ott_api/dto/continue_watching_dto.dart';
import 'package:flutter_ideal_ott_api/dto/library_dto.dart';
import 'package:flutter_ideal_ott_api/dto/user_dto.dart';
import 'package:flutter_ideal_ott_api/repository/home_repository.dart';
import '../../bloc/api_resp_state.dart';
import '../../bloc/cubit/home_cubit.dart';
import '../../util/app_colors.dart';
import '../../util/app_session.dart';
import '../../util/constants.dart';
import '../../util/dimensions.dart';
import '../../util/strings.dart';
import '../../util/utility.dart';
import '../profile/profile_page.dart';
import 'home_details_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeCubit? _bannerCubit;
  HomeCubit? _categoryCubit;
  HomeCubit? _continueWatchingCubit;
  List<LibraryDto?>? _libraryList;
  List<CategoryDto>? _categoryList;
  List<ContinueWatchingDto>? _continueWatchList;
  UserDto _userDto = UserDto();
  final AppSession _appSession = AppSession();

  @override
  void initState() {
    _appSession.init().then((value) => getDetail());
    _bannerCubit = HomeCubit(HomeRepository());
    _categoryCubit = HomeCubit(HomeRepository());
    _continueWatchingCubit = HomeCubit(HomeRepository());
    getBannerMovieList();
    getFeaturedLists();
    getContinueWatchingList();
    super.initState();
  }

  @override
  void dispose() {
    _bannerCubit?.close();
    _bannerCubit = null;
    _categoryCubit?.close();
    _categoryCubit = null;
    _continueWatchingCubit?.close();
    _continueWatchingCubit = null;
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
                _libraryList?.clear();
                if(state.data != null){
                  _libraryList = state.data;
                  setState(() {});
                  print("_libraryList?[0]?.videoContent.contentId>>>>>>>>>>>>>>>>>>> : ${_libraryList?[0]?.videoContent?.contentId ?? ""}");
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
                _categoryList?.clear();
                if(state.data != null){
                  _categoryList = state.data;
                  setState(() {});
                }
              }
            },
          ),
          BlocListener<HomeCubit, ResponseState>(
            bloc: _continueWatchingCubit,
            listener: (context, state) {
              if (state is ResponseStateLoading) {
              } else if (state is ResponseStateError) {
                Utility.hideLoader(context);
                var error  = state.errorMessage;
                Utility.showAlertDialog(context, error);
              } else if (state is ResponseStateSuccess) {
                Utility.hideLoader(context);
                if(state.data != null){
                  _continueWatchList = state.data;
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
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top,bottom: MediaQuery.of(context).padding.bottom),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage())).then((value) => {
                      _appSession.init().then((value) => getDetail()),
                      getBannerMovieList(),
                      getFeaturedLists(),
                      getContinueWatchingList()
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      width: 40,
                      height: 40,
                      imageUrl: _userDto.avatar ?? "",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.black38,
                        alignment: Alignment.center,
                        child: Image.asset(
                            "assets/images/user_placeholder.png"),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.black38,
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
                    ).then((value) => {
                      getFeaturedLists()
                    });
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
                _continueWatchList != null && _continueWatchList!.isNotEmpty
                    ? Row(
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
                )
                    : Container(),
                const SizedBox(height: 15,),
                _continueWatchList != null && _continueWatchList!.isNotEmpty
                    ?SizedBox(
                  height: 130,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: _continueWatchList?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return _continueList(index);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        width: 10,
                      );
                    },
                  ),
                ):Container(),
                const SizedBox(height: 16,),
                ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _categoryList != null && _categoryList!.isNotEmpty ?_categoryList?.length ?? 0 :0,
                  itemBuilder: (BuildContext context, int categoryIndex) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _categoryList?[categoryIndex].library != null && _categoryList![categoryIndex].library!.isNotEmpty ?Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Text(_categoryList?[categoryIndex].title ?? "",
                              style: const TextStyle(
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
                                      builder: (context) =>  SubCategoryPage(type: _categoryList?[categoryIndex].title ?? "",id: _categoryList?[categoryIndex].categoryId,)),
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
                        ):Container(),
                        _categoryList?[categoryIndex].library != null && _categoryList![categoryIndex].library!.isNotEmpty ?const SizedBox(height: 20,):Container(),
                        _categoryList?[categoryIndex].library != null && _categoryList![categoryIndex].library!.isNotEmpty ?SizedBox(
                          height: 162,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: _categoryList![categoryIndex].library?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return _categoryListView(_categoryList?[categoryIndex].library?[index],categoryIndex);
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(
                                width: 10,
                              );
                            },
                          ),
                        ):Container(),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int categoryIndex) {
                    return SizedBox(
                      height: _categoryList?[categoryIndex].library != null && _categoryList![categoryIndex].library!.isNotEmpty ?20:0,
                    );
                  },
                ),
                // const SizedBox(height: 50,),
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
                builder: (context) => HomeDetailPage(id: _libraryList?[index]?.libraryId,coverImage: _libraryList?[index]?.thumbnails?[0].url,))).then((value) => {
          _appSession.init().then((value) => getDetail()),
          getBannerMovieList(),
          getFeaturedLists(),
          getContinueWatchingList()
        });
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
    List<double> progress = [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1];
    var data = 81/10;
    var time;
    int watchTime = _continueWatchList?[index].watchDurationInSec ?? 0;
    int reminder = data.toInt();
    if((reminder*1) >= watchTime){
      time = progress[0];
    }else if((reminder*2) >= watchTime){
      time = progress[1];
    }else if((reminder*3) >= watchTime){
      time = progress[2];
    }else if((reminder*4) >= watchTime){
      time = progress[3];
    }else if((reminder*5) >= watchTime){
      time = progress[4];
    }else if((reminder*6) >= watchTime){
      time = progress[4];
    }else if((reminder*7) >= watchTime){
      time = progress[6];
    }else if((reminder*8) >= watchTime){
      time = progress[7];
    }else if((reminder*9) >= watchTime){
      time = progress[8];
    }else if((reminder*10) >= watchTime){
      time = progress[9];
    }
    print(">>>>>>>>>>>>>>> time : $time");
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeDetailPage(id: _continueWatchList?[index].libraryContent?.libraryId,coverImage: _continueWatchList?[index].libraryContent?.thumbnails?[0].url,watchingDto:_continueWatchList?[index]))).then((value) => {
          _appSession.init().then((value) => getDetail()),
          getBannerMovieList(),
          getFeaturedLists(),
          getContinueWatchingList()
        });
        print("_continueWatchList>>>>>>>>>>>>>>>>>> ${_continueWatchList?[index].libraryContent?.libraryId}");

      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              height: 120,
              width: 196,
              imageUrl: _continueWatchList?[index].libraryContent?.thumbnails?[1].url ?? "",
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
            child: LinearProgressIndicator(
              value: time,color:Colors.white,
              valueColor:  const AlwaysStoppedAnimation<Color>(AppColors.red),
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
      ),
    );
  }

  Widget _categoryListView(LibraryDto? dto,int categoryIndex){
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeDetailPage(id: dto?.libraryId,coverImage: dto?.thumbnails?[0].url))).then((value) => {
          _appSession.init().then((value) => getDetail()),
          getBannerMovieList(),
          getFeaturedLists(),
          getContinueWatchingList()
        });
        },
      child: Container(
        padding: EdgeInsets.zero,
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
                imageUrl: dto?.thumbnails != null && dto!.thumbnails!.isNotEmpty ? dto.thumbnails![0].url ?? "" : "",
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.black38,
                  height: 130,
                  width: 100,
                  // child: Image.asset(
                  //     "assets/images/user_placeholder.png"),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.black38,
                  height: 130,
                  width: 100,
                  // child: Image.asset(
                  //     "assets/images/user_placeholder.png"),
                ),
              ),),
            const SizedBox(height: 5,),
            SizedBox(
              width: 80,
              child: Text(Utility.capitalized(dto?.title??""),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: Dimensions.textSizeSmall,
                      fontFamily: Constants.fontFamily,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white)),
            ),
          ],
        ),
      ),
    );
  }

  getDetail() {
    _appSession.getUserDetail().then((value) => {
      setState(() {
        if(value != null){
          _userDto = value;
        }
      })
    });
  }

  getBannerMovieList(){
    _bannerCubit?.getBannerMovies();
  }

  getFeaturedLists(){
    _categoryCubit?.getFeaturedList();
  }

  getContinueWatchingList(){
    _continueWatchingCubit?.getContinueWatching();
  }
}
