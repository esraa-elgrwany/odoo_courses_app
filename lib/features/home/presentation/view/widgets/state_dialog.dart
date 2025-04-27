import 'package:courses_app/features/home/data/models/get_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../view_model/home_cubit.dart';

class StateDialog extends StatefulWidget{
  final Function(StateResult customer) onStateSelected;
  const StateDialog({super.key,required this.onStateSelected});

  @override
  State<StateDialog> createState() => _StateDialogState();
}

class _StateDialogState extends State<StateDialog> {
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
                  context.read<HomeCubit>().getStates(query: searchController.text);
                }
              },
              decoration: InputDecoration(
                hintText: "Search States...",
                border: InputBorder.none,
              ),
            ),
          )
              : Text(
            AppLocalizations.of(context)!.selectState,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchController.clear();
                  context.read<HomeCubit>().getStates();
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
            if (state is GetStateLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.green),
              );
            } else if (state is GetStateError) {
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
            } else if (state is GetStateSuccess) {
              final states =context.read<HomeCubit>().states;
              if (states.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/map_3270996.png",width: 24,height: 24,),
                      SizedBox(height: 12),
                      Text(
                        "No States Found",
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
                itemCount: states.length,
                itemBuilder: (context, index) {
                  final state = states[index];
                  return ListTile(
                    leading: Image.asset("assets/images/map_3270996.png",width: 24,height: 24,),
                    title: Text(state.name ?? "No Name",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    onTap: () {
                      widget.onStateSelected(state);
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
