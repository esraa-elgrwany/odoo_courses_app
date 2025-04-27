import 'dart:convert';
import 'dart:io';
import 'package:courses_app/features/home/data/models/get_status.dart';
import 'package:courses_app/features/home/presentation/view/screens/courses_screen.dart';
import 'package:courses_app/features/home/presentation/view/widgets/button_widget.dart';
import 'package:courses_app/features/home/presentation/view/widgets/drop_down_container.dart';
import 'package:courses_app/features/home/presentation/view/widgets/status_dialog.dart';
import 'package:courses_app/features/home/presentation/view/widgets/text_form_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/utils/styles/colors.dart';
import '../../../data/models/get_know_us_model.dart';
import '../../../data/models/get_state.dart';
import '../../view_model/home_cubit.dart';
import '../widgets/know_us_dialog.dart';
import '../widgets/state_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AddCourseScreen extends StatefulWidget {
  static const String routeName = "AddCourse";

  const AddCourseScreen({super.key});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  StateResult? selectedState;
  bool stateSelected = true;
  StatusResult? selectedStatus;
  bool statusSelected = true;
  KnowUsResult? selectedKnowUs;
  bool knowUsSelected = true;
  var formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController batchController = TextEditingController();
  String? gender;
  String?  workStatus;
  String? payMethod;
  String base64Image="";
  final ImagePicker picker=ImagePicker();
   File? imageFile;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isLoading = state is AddCourseLoading;
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                title: Text(
                  AppLocalizations.of(context)!.addNewCourse,
                ),
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/group-students-watching-online-webinar.png",
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          TextFormItem(
                              controller: nameController,
                              hint: AppLocalizations.of(context)!.name,
                              maxLine: 1,
                              icon: Icons.edit,
                              validateTxt: "please enter task name"),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormItem(
                              controller: phoneController,
                              hint: AppLocalizations.of(context)!.phone,
                              maxLine: 1,
                              icon: Icons.phone,
                              validateTxt: "please enter your phone number"),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormItem(
                              controller: ageController,
                              hint: AppLocalizations.of(context)!.age,
                              maxLine: 1,
                              icon: Icons.person,
                              validateTxt: "please enter your age"),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormItem(
                              controller: cityController,
                              hint: AppLocalizations.of(context)!.city,
                              maxLine: 1,
                              icon: Icons.location_city,
                              validateTxt: "please enter your city"),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormItem(
                              controller: batchController,
                              hint: AppLocalizations.of(context)!.batchNum,
                              maxLine: 1,
                              icon: Icons.numbers,
                              validateTxt: "please enter your batch number"),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context)!.gender),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: "male",
                                  groupValue: gender,
                                  onChanged: (val) =>
                                      setState(() => gender = val!)),
                              Text(AppLocalizations.of(context)!.male),
                              Radio(
                                  value: "female",
                                  groupValue: gender,
                                  onChanged: (val) =>
                                      setState(() => gender = val!)),
                              Text(AppLocalizations.of(context)!.female),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context)!.workStatus),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: "work",
                                  groupValue: workStatus,
                                  onChanged: (val) =>
                                      setState(() => workStatus = val!)),
                              Text(AppLocalizations.of(context)!.work),
                              Radio(
                                  value: "not_work",
                                  groupValue: workStatus,
                                  onChanged: (val) =>
                                      setState(() => workStatus = val!)),
                              Text(AppLocalizations.of(context)!.unWork),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context)!.paymentMethod),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: "cash",
                                  groupValue: payMethod,
                                  onChanged: (val) =>
                                      setState(() => payMethod = val!)),
                              Text(AppLocalizations.of(context)!.cash),
                              Radio(
                                  value: "online",
                                  groupValue: payMethod,
                                  onChanged: (val) =>
                                      setState(() => payMethod = val!)),
                              Text(AppLocalizations.of(context)!.online),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          InkWell(
                              onTap: () {
                                _showStateSelectionDialog();
                              },
                              child: DropDownContainer(
                                  text: selectedState?.name ?? AppLocalizations.of(context)!.selectState)),
                          SizedBox(
                            height: 16,
                          ),
                          InkWell(
                              onTap: () {
                                _showStatusSelectionDialog();
                              },
                              child: DropDownContainer(
                                  text: selectedStatus?.name ??
                                      AppLocalizations.of(context)!.selectStatus)),
                          SizedBox(
                            height: 16,
                          ),
                          InkWell(
                              onTap: () {
                                _showKnowUsSelectionDialog();
                              },
                              child: DropDownContainer(
                                  text: selectedKnowUs?.name ??
                                      AppLocalizations.of(context)!.selectHowKnow)),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  _pickImage();
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2.9,
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(12),
                                      color: primaryColor),
                                  child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.uploadImage,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  )),
                                ),
                              ),
                              Spacer(),
                              imageFile == null
                                  ? Text("No image selected")
                                  : Image.file(imageFile!, height: 80,width: 160,),
                            ],
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          BlocListener<HomeCubit, HomeState>(
                            listener: (context, state) {
                              if (state is AddCourseError) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.grey[200],
                                    title: Text(
                                      "Error",
                                      style: TextStyle(color: primaryColor),
                                    ),
                                    content: Text(
                                      state.failures.errormsg,
                                      style: TextStyle(color: primaryColor),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("okay",
                                              style: TextStyle(
                                                  color: Colors.white))),
                                    ],
                                  ),
                                );
                              } else if (state is AddCourseSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Center(
                                        child: Text(
                                          "Course Added Successfully",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 4),
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(24),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 4)),
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CourseScreen()),
                                );
                              }
                            },
                            child: InkWell(
                                onTap: () {
                                  onConfirm();
                                  if (stateSelected &&
                                      statusSelected &&
                                      knowUsSelected) {
                           HomeCubit.get(context).addCourse(name: nameController.text,
                               city:cityController.text, gender: gender??"male", phone: phoneController.text,
                               workStatus: workStatus??"work", payment: payMethod??"cash", stateId: selectedState?.id??0,
                               status:selectedStatus?.id??0, knowUs:selectedKnowUs?.id??0, batchNum:int.tryParse(batchController.text) ?? 0,
                               age: int.tryParse(ageController.text) ?? 0, img:base64Image);
                                  }
                                },
                                child: ButtonWidget(txt: AppLocalizations.of(context)!.addCourse)),
                          ),
                        ],
                      ),
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
    );
  }

  void _showStateSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => HomeCubit()..getStates(),
        child: StateDialog(
          onStateSelected: (selectedState) {
            setState(() {
              this.selectedState = selectedState;
            });
          },
        ),
      ),
    );
  }

  void _validateStateSelection() {
    setState(() {
      stateSelected =
          selectedState?.name != null && selectedState!.name!.isNotEmpty;
    });

    if (!stateSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select a state.",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center),
          backgroundColor: redColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(12)),
          margin:
              EdgeInsets.only(bottom: 80, left: 20, right: 20), // Adjust margin
        ),
      );
    }
  }

  void _showStatusSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => HomeCubit()..getStatus(),
        child: StatusDialog(
          onStatusSelected: (selectedStatus) {
            setState(() {
              this.selectedStatus = selectedStatus;
            });
          },
        ),
      ),
    );
  }

  void _validateStatusSelection() {
    setState(() {
      statusSelected =
          selectedStatus?.name != null && selectedStatus!.name!.isNotEmpty;
    });

    if (!statusSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select a status.",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center),
          backgroundColor: redColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(12)),
          behavior: SnackBarBehavior.floating,
          margin:
              EdgeInsets.only(bottom: 80, left: 20, right: 20), // Adjust margin
        ),
      );
    }
  }

  void _showKnowUsSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => HomeCubit()..getKnowUs(),
        child: KnowUsDialog(
          onKnowUsSelected: (selectedKnowUs) {
            setState(() {
              this.selectedKnowUs = selectedKnowUs;
            });
          },
        ),
      ),
    );
  }

  void _validateKnowUsSelection() {
    setState(() {
      knowUsSelected =
          selectedKnowUs?.name != null && selectedKnowUs!.name!.isNotEmpty;
    });

    if (!knowUsSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select a knowUs.",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center),
          backgroundColor: redColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(12)),
          margin:
              EdgeInsets.only(bottom: 80, left: 20, right: 20), // Adjust margin
        ),
      );
    }
  }

  void onConfirm() {
    _submitForm();
    _validateStateSelection();
    _validateStatusSelection();
    _validateKnowUsSelection();
  }

  Future<void> _pickImage() async {
   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
   List<int> imageByte=await image!.readAsBytes();
   base64Image=base64.encode(imageByte);
   print(base64Image);
   final imagePath=File(image.path);
   setState(() {
     this.imageFile=imagePath;
   });
   print(imagePath);
  }


  Future<void> _submitForm() async {
    if (formKey.currentState!.validate()) {
      if (imageFile != null) {
        List<int> imageBytes = await imageFile!.readAsBytes();
        setState(() {
          base64Image = base64Encode(imageBytes);
        });
      } else {
        setState(() {
          base64Image = "";
        });
      }
    }
  }

}
