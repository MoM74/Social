import 'package:fire_Social/models/outfit_post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/styles/icon_broken.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Favorites"),
          ),
          body: ListView.separated(
            itemBuilder: (context, index) => buildPostItemmm(
                SocialCubit.get(context).favoritesList[index], context, index),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: SocialCubit.get(context).favoritesList.length,
          ),
        );
      },
    );
  }
}

Widget buildPostItemmm(PostModel postModel, context, index) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    '${postModel.image}',
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${postModel.name}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                height: 1.4,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              SocialCubit.get(context)
                                  .removeFromFavorites(postModel.uId);
                            },
                            icon: Icon(
                              IconBroken.Delete,
                              size: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        DateFormat("MMM d, y")
                            .format(DateTime.parse('${postModel.dateTime}')),
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${postModel.text}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            if (postModel.postImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 15.0),
                child: Container(
                  height: 140.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      4.0,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${postModel.postImage}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
