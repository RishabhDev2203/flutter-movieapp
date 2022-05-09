import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../../util/utility.dart';
import 'home_details_page.dart';

class SeeAllPage extends StatefulWidget {
  final String type;
  String? id;
  SeeAllPage({Key? key, required this.type,required this.id}) : super(key: key);

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  HomeCubit? _seeAllCategoryCubit;
  CategoryDto? _category;

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
                  _category = state.data;
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
          movieListBody(_category?.library),
          const SizedBox(height: 50,),
        ],
      ),
    );
  }

  Widget movieListBody(List<LibraryDto>? dto) {
    return Expanded(
      child: GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 4 / 5),
          itemCount: dto?.length ?? 0,
          itemBuilder: (BuildContext ctx, index) {
            return InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeDetailPage(id: dto?[index].libraryId ?? "",coverImage: dto?[index].thumbnails != null && dto![index].thumbnails!.isNotEmpty ? dto[index].thumbnails![0].url : "",)));
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
                        height: 190,
                        width: 190,
                        imageUrl: dto?[index].thumbnails != null && dto![index].thumbnails!.isNotEmpty ? dto[index].thumbnails![0].url ?? "" : "",
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
                    Text(Utility.capitalized(dto?[index].title ??""),
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

          }),
    );
  }

  getCategoryMovieList(){
    _seeAllCategoryCubit?.getSeeAllCategory(widget.id);
  }
}