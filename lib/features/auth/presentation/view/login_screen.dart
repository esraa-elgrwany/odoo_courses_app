import 'package:courses_app/features/auth/presentation/view/widgets/header.dart';
import 'package:courses_app/features/auth/presentation/view/widgets/text_field_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cache/shared_preferences.dart';
import '../../../../core/utils/styles/colors.dart';
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
                        Header("Login", "Enter username and password"),
                        const SizedBox(height: 40),
                        Container(
                          height: MediaQuery.of(context).size.height /1.9,
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
                                      SizedBox(height: 20),
                                      Text("Username",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:Colors.black)),
                                      SizedBox(height: 8),
                                      TextFieldItem(
                                          controller: userController,
                                          hint: "username",
                                          icon: Icons.person,
                                          validateTxt:
                                              "please enter your userName"),
                                      SizedBox(height: 20),
                                      Text("Password",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      const SizedBox(height: 8),
                                      TextFormField(
                                        controller: passwordController,
                                        obscureText: secure ? true : false,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: secondPrimary,
                                          hintText: "password",
                                          hintStyle:TextStyle(color:thirdPrimary,fontSize: 14),
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
                                                    color: primaryColor)
                                                : Icon(
                                                    Icons.visibility,
                                                    color: primaryColor,
                                                  ),
                                          ),
                                          prefixIcon: Icon(Icons.lock,
                                              color: primaryColor),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "please enter your password";
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 60),
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
                                                              fontSize: 14),
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
                                                  "Login",
                                                  style: TextStyle(
                                                      color: Colors.white),
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
                                                      TextStyle(fontSize: 22),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                    ],
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
