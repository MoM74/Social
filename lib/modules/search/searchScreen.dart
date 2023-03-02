import 'package:fire_Social/models/outfit_user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

import '../profile/profile_user/profile_user.dart';

class SearchScreen extends StatelessWidget {
  final searchController = TextEditingController();

  SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = SocialCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                  toolbarHeight: 25,
                  leading: const SizedBox(
                    width: 0,
                  ),
                  leadingWidth: 0),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    // const SizedBox(height: 15,),
                    Container(
                      height: 60,
                      child: TextFormField(
                        controller: searchController,
                        validator: (val) {
                          return searchController.text.isEmpty
                              ? "search must not be empty"
                              : null;
                        },
                        onChanged: (input) {
                          print(input);
                          cubit.searchForUser(input: input);
                        },
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.none),
                        decoration: InputDecoration(
                            hintText: "search for user by his Name",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 15),
                            prefixIcon: const Icon(Icons.search),
                            suffix: GestureDetector(
                              child: const Icon(Icons.close),
                              onTap: () {
                                searchController.text = '';
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                        child: cubit.searchData.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: cubit.searchData
                                    .length, // type cubit.searchData.length
                                itemBuilder: (context, index) {
                                  return buildUserItemShown(
                                      model: cubit.searchData[index],
                                      context: context,
                                      cubit: cubit);
                                },
                              )
                            : state is SearchForUserLoadingState
                                ? const CupertinoActivityIndicator()
                                : const Center(
                                    child: Text(
                                      "There is no users to shown",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ))
                  ],
                ),
              ));
        });
  }

  // build the item that user will be shown in this screen => after click on the user, will go to his profile
  Widget buildUserItemShown(
      {required UserModel model,
      required SocialCubit cubit,
      required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfileUser()));
      },
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(model.image!)), // model.image!
        title: Text(model.name!), // model.userName!
        subtitle: Text(model.bio!), // model.bio!
      ),
    );
  }
}
