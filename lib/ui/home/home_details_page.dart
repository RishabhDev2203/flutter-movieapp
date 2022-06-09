import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/bloc/cubit/home_cubit.dart';
import 'package:flutter_firebase_ott/util/component/back_button.dart';
import 'package:flutter_ideal_ott_api/dto/continue_watching_dto.dart';
import 'package:flutter_ideal_ott_api/dto/library_dto.dart';
import 'package:flutter_ideal_ott_api/repository/home_repository.dart';
import 'package:video_player/video_player.dart';
import '../../bloc/api_resp_state.dart';
import '../../locale/application_localizations.dart';
import '../../util/app_colors.dart';
import '../../util/component/more_description.dart';
import '../../util/constants.dart';
import '../../util/dimensions.dart';
import '../../util/strings.dart';
import '../../util/utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/videoplayer/video_player_page.dart';

class HomeDetailPage extends StatefulWidget {
  String? id;
  String? coverImage;
  ContinueWatchingDto? watchingDto;
  String? heroTag;

  HomeDetailPage({Key? key, this.id, this.coverImage,this.watchingDto,this.heroTag}) : super(key: key);

  @override
  State<HomeDetailPage> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  HomeCubit? _movieDetailCubit;
  HomeCubit? _updateVideoCubit;
  LibraryDto? dto;
  bool isVideoPlay = false;

  @override
  void initState() {
    _movieDetailCubit = HomeCubit(HomeRepository());
    _updateVideoCubit = HomeCubit(HomeRepository());
    getMovieDetails();
    super.initState();
  }

  @override
  void dispose() {
    //_updateVideoCubit?.updateVideo(widget.watchingDto?.continueWatchingId, 35);
    _movieDetailCubit = null;
    _updateVideoCubit = null;
    _movieDetailCubit?.close();
    _updateVideoCubit?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<HomeCubit, ResponseState>(
            bloc: _movieDetailCubit,
            listener: (context, state) {
              if (state is ResponseStateLoading) {
              } else if (state is ResponseStateError) {
                Utility.hideLoader(context);
                var error = state.errorMessage;
                Utility.showAlertDialog(context, error);
              } else if (state is ResponseStateSuccess) {
                Utility.hideLoader(context);
                if (state.data != null) {
                  dto = state.data;
                  setState(() {});
                }
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: getBody(),
        ));
  }

  getBody() {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 370,
              width: MediaQuery.of(context).size.width,
              child: isVideoPlay == true
                  ? Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  alignment: FractionalOffset.topCenter,
                  child: VideoPlayerPage(
                    url: dto?.videoContent?.outputUrl ?? "",
                    showAds: false,
                    startedAt: widget.watchingDto?.watchDurationInSec,
                    id: dto?.libraryId ?? "",
                  ))
                  : Hero(
                tag: widget.heroTag ?? "",
                    child: CachedNetworkImage(
                height: 300,
                width: MediaQuery.of(context).size.width,
                imageUrl: widget.coverImage ?? "",
                fit: BoxFit.cover,
                alignment: FractionalOffset.topCenter,
                placeholder: (context, url) => Container(
                    color: Colors.black38,
                    alignment: Alignment.center,
                    height: 300,
                    // child: Image.asset(
                    //   "assets/images/user_placeholder.png",
                    //   fit: BoxFit.cover,
                    //   height: 300,
                    //   width: MediaQuery.of(context).size.width,
                    // ),
                ),
                errorWidget: (context, url, error) => Container(
                    color: Colors.black38,
                    alignment: Alignment.center,
                    height: 300,
                    // child: Image.asset("assets/images/user_placeholder.png",
                    //     fit: BoxFit.cover,
                    //     height: 300,
                    //     width: MediaQuery.of(context).size.width),
                ),
              ),
                  ),
            ),
            isVideoPlay == false
                ?AppColors.gradientOverlay(
                370, MediaQuery.of(context).size.width, 0)
                :Container(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top+10, left: 10),
                  child: const ButtonBack(),
                ),
                isVideoPlay == true
                    ? const SizedBox(
                  height: 150,
                )
                    : Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isVideoPlay = true;
                      });
                    },
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
                ),
                SizedBox(
                  height:
                  dto?.title != null && dto!.title!.length > 25 ? 60 : 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(dto?.title ?? "",
                      style: const TextStyle(
                          fontSize: 28,
                          fontFamily: Constants.fontFamily,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white)),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                      "${dto?.type?[0] ?? ""} • ${dto?.videoContent?.duration ?? 0} mins",
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: Constants.fontFamily,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary)),
                )
              ],
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Divider(
            thickness: 1,
            color: Colors.blueGrey,
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(left: 16, right: 16),
            children: [
               Text( ApplicationLocalizations.of(context)!.translate("storyLine"),
                   style: Theme.of(context).textTheme.labelMedium
               ),
              const SizedBox(
                height: 10,
              ),
              ReadMoreText(
                dto?.description ?? "",
                trimLines: 3,
                colorClickableText: AppColors.red,
                trimMode: TrimMode.Line,
                trimCollapsedText:  ApplicationLocalizations.of(context)!.translate("readMore"),
                trimExpandedText:  ApplicationLocalizations.of(context)!.translate("less"),
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text(
                    ApplicationLocalizations.of(context)!.translate("recommended"),
                      style: Theme.of(context).textTheme.headline4
                  ),
                  Text(
                    ApplicationLocalizations.of(context)!.translate("seeAll"),
                      style: Theme.of(context).textTheme.headline5
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
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
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _recommendedList(int index) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.containerBg,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              height: 130,
              width: 100,
              imageUrl:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGwCtb_x-r40cuFN5J2aZ-xBiOdDO0CJDhpg&usqp=CAU",
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.black38,
                alignment: Alignment.center,
                // child: Image.asset("assets/images/user_placeholder.png"),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.black38,
                alignment: Alignment.center,
                // child: Image.asset("assets/images/user_placeholder.png"),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
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

  getMovieDetails() {
    _movieDetailCubit?.getMoviesDetail(widget.id);
  }
}
