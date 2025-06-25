import 'package:courses_app/features/auth/presentation/view/widgets/header.dart';
import 'package:courses_app/features/auth/presentation/view/widgets/text_field_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/cache/shared_preferences.dart';
import '../../../../core/utils/styles/colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../home/presentation/view/screens/home_screen.dart';
import '../view_model/login_cubit.dart';

class LoginScreen extends StatefulWidget{
  static const String routeName = "LoginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool secure = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => LoginCubit(),
  child: BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isLoading = state is LoginLoading;
        return Stack(
          children: [
            Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Header(AppLocalizations.of(context)!.login,AppLocalizations.of(context)!.loginWelcome),
                        SizedBox(height: 24.h),
                        Container(
                          height: MediaQuery.of(context).size.height /1.8,
                          child: Center(
                            child: SingleChildScrollView(
                              child: Card(
                                elevation: 8,
                                margin: EdgeInsets.all(8),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusDirectional.only(
                                        topStart: Radius.circular(24),
                                        topEnd: Radius.circular(24),
                                        bottomStart: Radius.circular(24),
                                        bottomEnd: Radius.circular(100))),
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20.h),
                                        Text(AppLocalizations.of(context)!.userName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.sp,
                                                color:Colors.black)),
                                        SizedBox(height: 8.h),
                                        TextFieldItem(
                                            controller: userController,
                                            hint: AppLocalizations.of(context)!.usernameHint,
                                            icon: Icons.person,
                                            validateTxt:
                                            AppLocalizations.of(context)!.userValid),
                                        SizedBox(height: 20.h),
                                        Text(AppLocalizations.of(context)!.password,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.sp,
                                                color: Colors.black)),
                                        SizedBox(height: 8.h),
                                        TextFormField(
                                          style: TextStyle(color:Colors.black,fontSize: 16.sp,fontWeight:FontWeight.w500),
                                          controller: passwordController,
                                          obscureText: secure ? true : false,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: secondPrimary,
                                            hintText: AppLocalizations.of(context)!.passHint,
                                            hintStyle:TextStyle(color:thirdPrimary,fontSize: 16.sp,fontWeight:FontWeight.w500),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                    color: secondPrimary)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                    color: secondPrimary)),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                secure = !secure;
                                                setState(() {});
                                              },
                                              icon: secure
                                                  ? Icon(Icons.visibility_off,
                                                      color: primaryColor,size: 22)
                                                  : Icon(
                                                      Icons.visibility,
                                                      color: primaryColor,
                                                       size: 22,
                                                    ),
                                            ),
                                            prefixIcon: Icon(Icons.lock,
                                                color: primaryColor,size: 22,),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return AppLocalizations.of(context)!.passValid;
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(height: 40.h),
                                        // Login Button
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            BlocConsumer<LoginCubit, LoginState>(
                                              listener: (context, state) {
                                                if (state is LoginFailure) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      backgroundColor:
                                                          Colors.grey[200],
                                                      title: Text(
                                                        "Error",
                                                        style: TextStyle(
                                                            color: primaryColor),
                                                      ),
                                                      content: Text(
                                                        state.failure.errormsg,
                                                        style: TextStyle(
                                                            color: primaryColor),
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text("okay",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white))),
                                                      ],
                                                    ),
                                                  );
                                                } else if (state
                                                    is LoginSuccess) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Center(
                                                          child: Text(
                                                            "Login successfully",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontSize: 16.sp),
                                                          ),
                                                        ),
                                                        backgroundColor:
                                                            Colors.green,
                                                        duration:
                                                            Duration(seconds: 4),
                                                        behavior: SnackBarBehavior
                                                            .floating,
                                                        margin:
                                                            EdgeInsets.all(24),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(24),
                                                        ),
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                vertical: 12,
                                                                horizontal: 4)),
                                                  );
                                                  CacheData.saveId(data:state.loginModel.result?.partnerDisplayName??"no partner",
                                                      key: "responsible");
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomeScreen(),
                                                      ));
                                                }
                                              },
                                              builder: (context, state) {
                                                return ElevatedButton(
                                                  onPressed: () {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      CacheData.saveId(
                                                          data: passwordController
                                                              .text,
                                                          key: "password");
                                                      LoginCubit.get(context)
                                                          .login(
                                                              userController.text,
                                                              passwordController
                                                                  .text);
                                                    }
                                                  },
                                                  child: Text(
                                                    AppLocalizations.of(context)!.login,
                                                    style: TextStyle(
                                                        color: Colors.white,fontWeight:FontWeight.bold),
                                                  ),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                       primaryColor,
                                                    padding: EdgeInsets.only(
                                                        bottom: 10,
                                                        top: 10,
                                                        left: 40,
                                                        right: 40),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadiusDirectional
                                                                .circular(12)),
                                                    textStyle:
                                                        TextStyle(fontSize: 18.sp),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ), SizedBox(height: 20.h),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                // Semi-transparent background
                child: Center(
                  child: CircularProgressIndicator(color: Colors.green),
                ),
              ),
          ],
        );
      },
    ),
);
  }
}
