import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:courses_app/core/utils/styles/colors.dart';
import 'package:courses_app/features/home/data/models/get_courses_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailsScreen extends StatelessWidget {
  static const String routeName = "courseDetailsScreen";

  const CourseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CoursesResult args =
        ModalRoute.of(context)?.settings.arguments as CoursesResult;
    Uint8List? bytes;

    if (args.gradImage != null && args.gradImage!.isNotEmpty) {
      try {
        bytes = base64Decode(args.gradImage!);
      } catch (e) {
        bytes = null;
      }
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.courseDetails,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                bytes != null
                    ? Image.memory(
                        bytes,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 240,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      )
                    : const Icon(Icons.image_not_supported, size: 60),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      height: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: secondPrimary,
                          borderRadius: BorderRadiusDirectional.circular(16)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/id-card_6785365.png",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            AppLocalizations.of(context)!.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                        flex: 14,
                        child: Column(children: [
                          Text(
                            args.name ?? "no name",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ]))
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      height: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: secondPrimary,
                          borderRadius: BorderRadiusDirectional.circular(16)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/telephone_18112096.png",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            AppLocalizations.of(context)!.phone,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      args.phone ?? "no phone",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                        onTap: () {
                          _openWhatsApp(args.phone);
                        },
                        child: Image.asset(
                          "assets/images/whatsapp_3670051.png",
                          width: 40,
                          height: 40,
                        )),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      height: 40,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: secondPrimary,
                          borderRadius: BorderRadiusDirectional.circular(16)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/money_14858977.png",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            AppLocalizations.of(context)!.paymentMethod,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      args.payMethod ?? "no payment method",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      height: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: secondPrimary,
                          borderRadius: BorderRadiusDirectional.circular(16)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/calendar_3941031.png",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            AppLocalizations.of(context)!.age,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "${args.age ?? 0}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      height: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: secondPrimary,
                          borderRadius: BorderRadiusDirectional.circular(16)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/map_3270996.png",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            AppLocalizations.of(context)!.state,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                        flex: 14,
                        child: Column(children: [
                          Text(
                            args.stateId?[1] ?? "no state",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ]))
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      height: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: secondPrimary,
                          borderRadius: BorderRadiusDirectional.circular(16)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/status_4727553.png",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            AppLocalizations.of(context)!.status,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                        flex: 14,
                        child: Column(children: [
                          Text(
                            args.status?[1] ?? "no status",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ]))
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      height: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: secondPrimary,
                          borderRadius: BorderRadiusDirectional.circular(16)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/city_9087077.png",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            AppLocalizations.of(context)!.city,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      args.city ?? "no city",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      height: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: secondPrimary,
                          borderRadius: BorderRadiusDirectional.circular(16)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/ranking_1199434.png",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            AppLocalizations.of(context)!.batchNum,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "${args.batchNum}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      height: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: secondPrimary,
                          borderRadius: BorderRadiusDirectional.circular(16)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/gender_2102925.png",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            AppLocalizations.of(context)!.gender,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      args.gender ?? "no gender",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 40,
                      decoration: BoxDecoration(
                          color: secondPrimary,
                          borderRadius: BorderRadiusDirectional.circular(16)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/online-surveys_18091734.png",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            AppLocalizations.of(context)!.workStatus,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      args.workStatus ?? "no work status",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      height: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: secondPrimary,
                          borderRadius: BorderRadiusDirectional.circular(16)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/business_1732637.png",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            AppLocalizations.of(context)!.know,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                        flex: 14,
                        child: Column(children: [
                          Text(
                            args.howKnowUs?[1] ?? "no data",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ]))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openWhatsApp(String? phone) async {
    if (phone == null || phone.isEmpty) {
      return;
    }
    String formattedPhone =
        phone.replaceAll(RegExp(r'\D'), ''); // Remove non-digits

    if (!formattedPhone.startsWith("1") && !formattedPhone.startsWith("2")) {
      formattedPhone =
          "20$formattedPhone"; // Add country code if missing (Example: Egypt)
    }

    final Uri whatsappUrl = Uri.parse("https://wa.me/$formattedPhone");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {}
  }
}
