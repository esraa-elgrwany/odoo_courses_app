import 'package:courses_app/features/home/data/models/get_partner_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../view_model/home_cubit.dart';

class PartnerDialog extends StatefulWidget{
  final Function(PartnerResult partner) onPartnerSelected;
  const PartnerDialog({super.key,required this.onPartnerSelected});

  @override
  State<PartnerDialog> createState() => _PartnerDialogState();
}

class _PartnerDialogState extends State<PartnerDialog> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isSearching
              ? Expanded(
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                if (searchController.text.isNotEmpty) {
                  context.read<HomeCubit>().getPartners(query: searchController.text);
                }
              },
              decoration: InputDecoration(
                hintText: "Search Partners...",
                border: InputBorder.none,
              ),
            ),
          )
              : Text(
            AppLocalizations.of(context)!.selectPartner,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchController.clear();
                  context.read<HomeCubit>().getPartners();
                }
              });
            },
          ),
        ],
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 1.6,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is GetPartnerLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.green),
              );
            } else if (state is GetPartnerError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.red, size: 50),
                    SizedBox(height: 12),
                    Text(
                      "An error occurred.",
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ],
                ),
              );
            } else if (state is GetPartnerSuccess) {
              final partners =context.read<HomeCubit>().partners;
              if (partners.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/customer.png",width: 24,height: 24,),
                      SizedBox(height: 12),
                      Text(
                        "No Partners Found",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Theme.of(context).colorScheme.primary,
                  endIndent: 8,
                  indent: 8,
                  thickness: 1,
                ),
                itemCount: partners.length,
                itemBuilder: (context, index) {
                  final partner = partners[index];
                  return ListTile(
                    leading: Image.asset("assets/images/customer.png",width: 24,height: 24,),
                    title: Text(partner.name ?? "No Name",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    onTap: () {
                      widget.onPartnerSelected(partner);
                      Navigator.pop(context);
                    },
                  );
                },
              );
            }
            return SizedBox(); // Default empty state
          },
        ),
      ),
    );
  }
}
