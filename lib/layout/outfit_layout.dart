import 'package:fire_Social/layout/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/cubit/cubit.dart';
import '../modules/drawer/app.dart';
import '../modules/new_post/new_post_screen.dart';
import '../modules/search/searchScreen.dart';
import '../shared/components/components.dart';
import '../shared/styles/icon_broken.dart';
import 'cubit/states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          navigateTo(
            context,
            NewPostScreen(),
          );
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          drawer: const AwesomeAnimatedDrawerApp(),
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.dark_mode,
                ),
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
              ),
              IconButton(
                icon: const Icon(
                  IconBroken.Notification,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  IconBroken.Search,
                ),
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Notification,
                ),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Paper_Upload),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Category,
                ),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Profile,
                ),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
