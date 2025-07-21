import 'package:courses_app/features/home/data/models/get_partner_model.dart';
import 'package:courses_app/features/home/presentation/view/widgets/partner_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/styles/colors.dart';
import '../../view_model/home_cubit.dart';

class PartnerRow extends StatefulWidget{
  final String label;
  final String iconPath;
  final String initialValue;
  final void Function(PartnerResult) onSave;

  const PartnerRow({
    Key? key,
    required this.label,
    required this.iconPath,
    required this.initialValue,
    required this.onSave,
  }) : super(key: key);

  @override
  State<PartnerRow> createState() => _PartnerRowState();
}

class _PartnerRowState extends State<PartnerRow> {
  late String selectedPartnerName;
  PartnerResult? selectedPartner;
  bool hasChanged = false;

  @override
  void initState() {
    super.initState();
    selectedPartnerName = widget.initialValue;
  }

  void _showStateSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => HomeCubit()..getPartners(),
        child: PartnerDialog(
          onPartnerSelected: (PartnerResult newPartner) {
            setState(() {
              selectedPartner = newPartner;
              selectedPartnerName = newPartner.name??"no name";
              hasChanged = true;
            });
          },
        ),
      ),
    );
  }

  void _saveState() {
    if (selectedPartner != null) {
      widget.onSave(selectedPartner!);
      setState(() {
        hasChanged = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40.h,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: secondPrimary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Image.asset(widget.iconPath, width: 24.w, height: 24.h),
                SizedBox(width: 4.w),
                Text(
                  widget.label,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: InkWell(
              onTap: _showStateSelectionDialog,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color:secondPrimary),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedPartnerName,
                        style: TextStyle(fontSize: 14.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, color: primaryColor),
                    if (hasChanged)
                      InkWell(
                        onTap: _saveState,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child:Icon(Icons.check_box_rounded, color: Colors.green, size: 32.sp),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}