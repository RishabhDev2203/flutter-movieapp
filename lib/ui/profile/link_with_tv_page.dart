import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ideal_ott_api/repository/auth_repository.dart';
import '../../bloc/api_resp_state.dart';
import '../../bloc/cubit/auth_cubit.dart';
import '../../util/app_colors.dart';
import '../../util/app_session.dart';
import '../../util/component/back_button.dart';
import '../../util/component/button_fill.dart';
import '../../util/component/my_container.dart';
import '../../util/component/title_text.dart';
import '../../util/dimensions.dart';
import '../../util/strings.dart';
import '../../util/utility.dart';

class LinkWithTV extends StatefulWidget {
  String? title;
  LinkWithTV({Key? key,this.title}) : super(key: key);

  @override
  State<LinkWithTV> createState() =>
      _LinkWithTVState();
}

class _LinkWithTVState extends State<LinkWithTV> {

  final _controller = TextEditingController();
  String authCode = "";
  String userAuthID = "";
  AuthCubit? _authCubit;
  String _scanBarcode = 'Unknown';
  StreamSubscription? _authSubscription;

  @override
  void initState() {
    super.initState();
    _authCubit = AuthCubit(AuthRepository());
    _getUserAuthID();
  }

  @override
  void dispose() {
    _authCubit?.close();
    _authCubit = null;
    _authSubscription?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, ResponseState>(
            bloc: _authCubit,
            listener: (context, state) {
              if (state is ResponseStateLoading) {
              } else if (state is ResponseStateError) {
                Utility.hideLoader(context);
                var error  = state.errorMessage;
                Utility.showAlertDialog(context, error);
              } else if (state is ResponseStateSuccess) {
                Utility.hideLoader(context);
                if(state.data as bool){
                  _controller.clear();
                  Utility.showAlertDialog(context, "Successfully Authenticate.");
                }
                else {
                  Utility.showAlertDialog(context, "Invalid or Expired Auth Code !");
                }
              }
            },
          ),
        ],
        child: _getBody());
  }

  _getBody(){
    return  Container(
      decoration: AppColors.bgGradientBoxDecoration(),
      child: Scaffold(
          backgroundColor: AppColors.transparent,
          body: Container(
              padding: const EdgeInsets.only(
                left: Dimensions.marginMedium,
                right: Dimensions
                    .marginMedium, /* top: MediaQuery.of(context).padding.top + 30*/
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: ButtonBack(),
                    ),
                    const SizedBox(height: 20),
                    TitleText(
                      text: widget.title??"",
                      fontSize: 28,
                    ),
                    const SizedBox(height: 25),
                    MyContainer(
                        child: TextField(
                          controller: _controller,
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6)
                          ],
                          decoration:  InputDecoration(
                            hintText: Strings.enter6dCode,
                            hintStyle: TextStyle(
                              color: AppColors.white.withOpacity(.2),
                              fontSize: Dimensions.textSizeXLarge,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            letterSpacing: 8.0,
                            color: AppColors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                          onChanged: (text) {
                            authCode = text;
                          },
                        )
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ButtonFill(
                        text: Strings.getConnect,
                        onPressed: () {
                          //scanQR();
                          if(_validate()) {
                            _verifyAuthCode();
                          }
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                    const Center(
                      child: Text(
                         "Or",
                        style: TextStyle(fontSize: 14,color: AppColors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonFill(
                        text: "Scan QR Code",
                        onPressed: () {
                          scanQR();
                        }),
                  ]))),
    );
  }

  _verifyAuthCode(){
    Utility.showLoader(context);
    _authCubit?.verifyAuthCode(userAuthID, authCode);
  }

  bool _validate() {
    var valid = true;
    if (authCode.isEmpty || authCode.length != 6) {
      valid = false;
      Utility.showAlertDialog(context, "Please enter a valid auth code");
    }
    return valid;
  }

  _getUserAuthID() {
    AppSession().getUserDetail().then((value) => {
      setState(() {
        if(value != null){
          userAuthID = value.authorizationId??"";
        }
      })
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      authCode = barcodeScanRes;
      print(">>>>>>>>>>> + ${barcodeScanRes}");
      if(authCode.isNotEmpty && authCode != "-1"){
        _verifyAuthCode();
      }
      setState((){});
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

}
