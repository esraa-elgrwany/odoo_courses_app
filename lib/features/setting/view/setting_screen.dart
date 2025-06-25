import 'package:courses_app/features/auth/presentation/view/login_screen.dart';
import 'package:courses_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/cache/shared_preferences.dart';
import '../../../core/utils/styles/colors.dart';
import '../model_view/setting_cubit.dart';

class SettingScreen extends StatefulWidget {
  static const String routeName = "settingScreen";

  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          title: Text(AppLocalizations.of(context)!.setting),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * .65,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Card(
                  elevation: 16,
                  color: Theme.of(context).colorScheme.onBackground,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onBackground,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context)!.lang,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontSize: 16,fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(AppLocalizations.of(context)!.en,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 14)),
                              ],
                            ),
                            Spacer(),
                            Image.asset(
                              "assets/images/lang.png",
                              width: 40,
                              height: 40,
                            ),
                          ],
                        ),
                        Divider(
                          endIndent: 16,
                          indent: 16,
                          color: primaryColor,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context)!.translate,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontSize: 16,fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(AppLocalizations.of(context)!.ar,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 14)),
                              ],
                            ),
                            Spacer(),
                            BlocBuilder<SettingCubit, SettingState>(
                                builder: (context, state) {
                              return Switch(
                                value: SettingCubit.get(context).isArabic,
                                activeColor: Colors.white,
                                activeTrackColor: primaryColor,
                                inactiveTrackColor: thirdPrimary,
                                onChanged: (value) {
                                  SettingCubit.get(context)
                                      .changeLanguage(value ? "ar" : "en");
                                },
                              );
                            }),
                          ],
                        ),
                        Divider(
                          endIndent: 16,
                          indent: 16,
                          color: primaryColor,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context)!.logout,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontSize: 16,fontWeight: FontWeight.w600)),
                              ],
                            ),
                            Spacer(),
                            InkWell(
                                onTap: () {
                                  CacheData.removeData("userId");
                                  CacheData.removeData("password");
                                  CacheData.removeData("sessionId");
                                  Navigator.pushReplacementNamed(
                                      context, LoginScreen.routeName);
                                },
                                child: Image.asset(
                                  "assets/images/log-out_11713255.png",
                                  width: 45,
                                  height: 45,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
