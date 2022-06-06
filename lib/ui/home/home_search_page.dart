import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_ott/util/component/back_button.dart';
import 'package:flutter_ideal_ott_api/dto/library_dto.dart';
import 'package:flutter_ideal_ott_api/repository/home_repository.dart';
import '../../bloc/api_resp_state.dart';
import '../../bloc/cubit/home_cubit.dart';
import '../../locale/application_localizations.dart';
import '../../util/app_colors.dart';
import '../../util/component/back_button.dart';
import '../../util/constants.dart';
import '../../util/dimensions.dart';
import '../../util/utility.dart';

class HomeSearchPage extends StatefulWidget {
  const HomeSearchPage({Key? key}) : super(key: key);

  @override
  State<HomeSearchPage> createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends State<HomeSearchPage> {
  String searchText = "";
  HomeCubit? _searchCubit;
  List<LibraryDto?>? _searchList;

  @override
  void initState() {
    _searchCubit = HomeCubit(HomeRepository());
    apiSeacrhList("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeCubit, ResponseState>(
          bloc: _searchCubit,
          listener: (context, state) {
            if (state is ResponseStateLoading) {
            } else if (state is ResponseStateError) {
              Utility.hideLoader(context);
              var error = state.errorMessage;
              Utility.showAlertDialog(context, error);
            } else if (state is ResponseStateSuccess) {
              Utility.hideLoader(context);
              _searchList?.clear();
              if (state.data != null) {
                _searchList = state.data;
                print(">>_searchList : ${_searchList?.length}");
                setState(() {});
              }
            }
          },
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.containerBg,
        // backgroundColor:AppColors.bg,
        body: Padding(
          padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: MediaQuery.of(context).padding.top + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ButtonBack(),
                  Text(
                      ApplicationLocalizations.of(context)!
                          .translate("search")!,
                      style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(
                    height: 32,
                    width: 20,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              searchView(),
              const SizedBox(
                height: 20,
              ),
              Text(
                  ApplicationLocalizations.of(context)!.translate("allMovies")!,
                  style: Theme.of(context).textTheme.headline4),
              const SizedBox(
                height: 10,
              ),
              movieListBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchView() {
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
          hintText: ApplicationLocalizations.of(context)!.translate("search")!,
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
            padding: const EdgeInsets.only(left: 40, right: 16),
            child: GestureDetector(
              onTap: () {
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
          apiSeacrhList(searchText);
        },
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
              childAspectRatio: 4 / 5.2),
          itemCount: _searchList?.length ?? 0,
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
                      imageUrl: _searchList?[index]?.thumbnails != null &&
                              _searchList![index]!.thumbnails!.isNotEmpty
                          ? _searchList![index]?.thumbnails![0].url ?? ""
                          : "",
                      fit: BoxFit.cover,
                      alignment: FractionalOffset.topCenter,
                      /*for align image*/
                      placeholder: (context, url) => Container(
                        color: Colors.black,
                        alignment: Alignment.center,
                        // child:
                        //     Image.asset("assets/images/user_placeholder.png"),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.black,
                        alignment: Alignment.center,
                        // child:
                        //     Image.asset("assets/images/user_placeholder.png"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    alignment: Alignment.center,
                    child: Text(_searchList?[index]?.title ?? "",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: Dimensions.textSizeMedium,
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

  apiSeacrhList(search) {
    _searchCubit?.getSearchList(search);
  }
}
