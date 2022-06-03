import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_ott/ui/home/home_details_page.dart';
import 'package:flutter_ideal_ott_api/dto/category_dto.dart';
import 'package:flutter_ideal_ott_api/dto/library_dto.dart';
import 'package:flutter_ideal_ott_api/repository/home_repository.dart';
import '../../bloc/api_resp_state.dart';
import '../../bloc/cubit/home_cubit.dart';
import '../../util/app_colors.dart';
import '../../util/component/back_button.dart';
import '../../util/component/sub_title_text.dart';
import '../../util/constants.dart';
import '../../util/dimensions.dart';
import '../../util/strings.dart';
import '../../util/utility.dart';

class SubCategoryPage extends StatefulWidget {
  final String type;
  String? id;
  SubCategoryPage({Key? key, required this.type,required this.id}) : super(key: key);

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  HomeCubit? _seeAllCategoryCubit;
  List<CategoryDto>? _categoryList;

  @override
  void initState() {
    _seeAllCategoryCubit = HomeCubit(HomeRepository());
    getCategoryMovieList();
    super.initState();
  }

  @override
  void dispose() {
    _seeAllCategoryCubit?.close();
    _seeAllCategoryCubit = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<HomeCubit, ResponseState>(
            bloc: _seeAllCategoryCubit,
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
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.bg,
          body: _getBody(),
        )
    );
  }

  Widget _getBody(){
    return Padding(
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
                  Row(
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
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 162,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _categoryList![categoryIndex].library?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return _categoryListView(_categoryList?[categoryIndex].library?[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int categoryIndex) {
              return const SizedBox(
                height: 20,
              );
            },
          ),
          const SizedBox(height: 50,),
        ],
      ),
    );
  }

  Widget _categoryListView(LibraryDto? dto){
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeDetailPage(id: dto?.libraryId ?? "",coverImage: dto?.thumbnails != null && dto!.thumbnails!.isNotEmpty ? dto.thumbnails![0].url : "",)));
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

  getCategoryMovieList(){
    _seeAllCategoryCubit?.getSubCategory(widget.id);
  }
}