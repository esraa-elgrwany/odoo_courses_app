import 'package:courses_app/features/home/data/models/get_know_us_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../view_model/home_cubit.dart';

class KnowUsDialog extends StatefulWidget{
  final Function(KnowUsResult customer) onKnowUsSelected;
  const KnowUsDialog({super.key,required this.onKnowUsSelected});

  @override
  State<KnowUsDialog> createState() => _KnowUsDialogState();
}

class _KnowUsDialogState extends State<KnowUsDialog> {
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
                  context.read<HomeCubit>().getKnowUs(query: searchController.text);
                }
              },
              decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
              ),
            ),
          )
              : Text(
            AppLocalizations.of(context)!.selectHowKnow,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchController.clear();
                  context.read<HomeCubit>().getKnowUs();
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
            if (state is GetKnowUsLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.green),
              );
            } else if (state is GetKnowUsError) {
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
            } else if (state is GetKnowUsSuccess) {
              final knowUs =context.read<HomeCubit>().knowUs;
              if (knowUs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/business_1732637.png",width: 28,height: 28,),
                      SizedBox(height: 12),
                      Text(
                        "No Result Found",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Theme.of(context).colorScheme.primary,
                  thickness: 1,
                  endIndent: 8,
                  indent: 8,
                ),
                itemCount:knowUs.length,
                itemBuilder: (context, index) {
                  final item = knowUs[index];
                  return ListTile(
                    leading: Image.asset("assets/images/business_1732637.png",width: 28,height: 28,),
                    title: Text(item.name ?? "No Name",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    onTap: () {
                      widget.onKnowUsSelected(item);
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
