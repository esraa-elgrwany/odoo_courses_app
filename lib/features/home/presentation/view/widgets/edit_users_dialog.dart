import 'package:courses_app/features/home/data/models/edit_user_model.dart';
import 'package:courses_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:courses_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditUsersDialog extends StatefulWidget{
  final Function(EditUserResult customer) onUserSelected;
  const EditUsersDialog({super.key,required this.onUserSelected});


  @override
  State<EditUsersDialog> createState() => _EditUsersDialogState();
}

class _EditUsersDialogState extends State<EditUsersDialog> {
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
                    context.read<HomeCubit>().getEditUsers(query: searchController.text);
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
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
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
              if (state is GetEditUserLoading) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.green),
                );
              } else if (state is GetEditUserError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.warning_amber_rounded, color: Colors.red, size: 50.sp),
                      SizedBox(height: 12.h),
                      Text(
                        "An error occurred.",
                        style: TextStyle(color: Colors.red, fontSize: 20.sp),
                      ),
                    ],
                  ),
                );
              } else if (state is GetEditUserSuccess) {
                final users =context.read<HomeCubit>().editUsers;
                if (users.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/people_8532963.png",width: 24.w,height: 24.h,),
                        SizedBox(height: 12.h),
                        Text(
                          "No Users Found",
                          style: TextStyle(fontSize: 20.sp, color: Colors.grey),
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
                      leading: Image.asset("assets/images/people_8532963.png",width: 28.w,height: 28.h,),
                      title: Text(customer.name ?? "No Name",
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
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
