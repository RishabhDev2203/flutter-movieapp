import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ideal_ott_api/dto/app_content_dto.dart';
import 'package:flutter_ideal_ott_api/repository/home_repository.dart';
import '../../bloc/api_resp_state.dart';
import '../../bloc/cubit/home_cubit.dart';
import '../../util/app_colors.dart';
import '../../util/component/back_button.dart';
import '../../util/component/sub_title_text.dart';
import '../../util/component/title_text.dart';
import '../../util/utility.dart';

class AppContentPage extends StatefulWidget {
  final String type;

  const AppContentPage({Key? key, required this.type}) : super(key: key);

  @override
  State<AppContentPage> createState() => _AppContentPageState();
}

class _AppContentPageState extends State<AppContentPage> {
  HomeCubit? _appContentCubit;
  AppContentDto? _appContentDto;

  @override
  void initState() {
    _appContentCubit = HomeCubit(HomeRepository());
    getAppContent();
    super.initState();
  }

  @override
  void dispose() {
    _appContentCubit?.close();
    _appContentCubit = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<HomeCubit, ResponseState>(
            bloc: _appContentCubit,
            listener: (context, state) {
              if (state is ResponseStateLoading) {
              } else if (state is ResponseStateError) {
                Utility.hideLoader(context);
                var error = state.errorMessage;
                Utility.showAlertDialog(context, error);
              } else if (state is ResponseStateSuccess) {
                Utility.hideLoader(context);
                if (state.data != null) {
                  _appContentDto = state.data;
                  setState(() {});
                }
              }
            },
          ),
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).backgroundColor,
          body: _getBody(),
        ));
  }

  Widget _getBody() {
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
              TitleText(
                text: widget.type == "contact_us"
                    ? "Contact us"
                    : widget.type == "terms_condition"
                        ? "Terms & condition"
                        : "Privacy policy",
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
          widget.type == "contact_us"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubTitleText(
                      text: _appContentDto?.email ?? "",
                      color: AppColors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SubTitleText(
                      text: "${_appContentDto?.mobileNumber ?? ""}",
                      color: AppColors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SubTitleText(
                      text: _appContentDto?.address ?? "",
                      color: AppColors.white,
                    ),
                  ],
                )
              : SubTitleText(
                  text: _appContentDto?.content ?? "",
                  color: AppColors.white,
                ),
        ],
      ),
    );
  }

  getAppContent() {
    _appContentCubit?.getAppContent(widget.type);
  }
}
