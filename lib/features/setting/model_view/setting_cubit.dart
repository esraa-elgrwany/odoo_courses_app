import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/cache/shared_preferences.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  static SettingCubit get(context) => BlocProvider.of(context);

  SettingCubit() : super(SettingInitial()) {
    _loadSettings();
  }

  String languageCode="en";
  bool isArabic=false;

  changeLanguage(String langCode){
    languageCode=langCode;
    if (langCode == "ar") {
      isArabic = true;
    } else {
      isArabic = false;
    }
    CacheData.saveId(data: languageCode, key: "lang");
    CacheData.saveId(data: isArabic, key:"arabicSwitch");
    emit(ChangeLanguage());
  }


  Future<void> _loadSettings() async {
    languageCode = CacheData.getData(key: "lang") ?? "en";
    isArabic = CacheData.getData(key: "arabicSwitch") ?? false;

    if (languageCode == "ar") {
      isArabic = true;
    } else {
      isArabic = false;
    }
    emit(SettingInitial());
  }

}
