import 'dart:async';
import 'package:courses_app/features/home/presentation/view/widgets/editable_field.dart';
import 'package:courses_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:courses_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/get_courses_model.dart';

class CoursePhoneRow extends StatefulWidget {
  final CoursesResult args;
  final TextEditingController controller;

  const CoursePhoneRow({Key? key, required this.args, required this.controller}) : super(key: key);

  @override
  _CoursePhoneRowState createState() => _CoursePhoneRowState();
}

class _CoursePhoneRowState extends State<CoursePhoneRow> {
  late String phone;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    phone = widget.args.phone ?? "";
    widget.controller.text = phone;
    widget.controller.addListener(_onPhoneChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    widget.controller.removeListener(_onPhoneChanged);
    super.dispose();
  }

  void _onPhoneChanged() {
    final currentText = widget.controller.text;
    if (currentText != phone) {
      _debounce?.cancel();
      _debounce = Timer(const Duration(seconds: 1), () {
        _savePhone(currentText);
      });
    }
  }

  void _savePhone(String newPhone) {
    if (newPhone != phone && newPhone.trim().isNotEmpty) {
      context.read<HomeCubit>().editCourse(
        courseId: widget.args.id!,
        phone: newPhone,
      );
      setState(() {
        phone = newPhone;
      });
    }
  }

  void _openWhatsApp(String? phone) async {
    if (phone == null || phone.isEmpty) return;

    String formattedPhone = phone.replaceAll(RegExp(r'\D'), '');
    if (!formattedPhone.startsWith("1") && !formattedPhone.startsWith("2")) {
      formattedPhone = "20$formattedPhone";
    }

    final Uri whatsappUrl = Uri.parse("https://wa.me/$formattedPhone");
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: EditableField(
            controller: widget.controller,
            label: AppLocalizations.of(context)!.phone,
            iconPath: "assets/images/telephone_18112096.png",
            initialValue: phone,
            keyboardType: TextInputType.phone,
            onSave: (value) => _savePhone(value),
          ),
        ),
        InkWell(
          onTap: () => _openWhatsApp(widget.controller.text),
          child: Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Image.asset(
              "assets/images/whatsapp_3670051.png",
              width: 28.w,
              height: 28.h,
            ),
          ),
        ),
      ],
    );
  }
}

