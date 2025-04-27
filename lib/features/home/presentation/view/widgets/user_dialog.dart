import 'package:courses_app/features/home/data/models/get_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../view_model/home_cubit.dart';

class UserDialog extends StatefulWidget{
  final Function(UserResult customer) onUserSelected;
  const UserDialog({super.key,required this.onUserSelected});

  @override
  State<UserDialog> createState() => _UserDialogState();
}

class _UserDialogState extends State<UserDialog> {
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
                  context.read<HomeCubit>().getUsers(query: searchController.text);
                }
              },
              decoration: InputDecoration(
                hintText: "Search Users...",
                border: InputBorder.none,
              ),
            ),
          )
              : Text(
            AppLocalizations.of(context)!.selectUser,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchController.clear();
                  context.read<HomeCubit>().getUsers();
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
            if (state is GetUserLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.green),
              );
            } else if (state is GetUserError) {
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
            } else if (state is GetUserSuccess) {
              final users =context.read<HomeCubit>().users;
              if (users.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/people_8532963.png",width: 24,height: 24,),
                      SizedBox(height: 12),
                      Text(
                        "No Users Found",
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
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final customer = users[index];
                  return ListTile(
                    leading: Image.asset("assets/images/people_8532963.png",width: 24,height: 24,),
                    title: Text(customer.name ?? "No Name",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    onTap: () {
                      widget.onUserSelected(customer);
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
