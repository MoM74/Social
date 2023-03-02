import 'package:buildcondition/buildcondition.dart';
import 'package:fire_Social/models/outfit_post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';
import '../comment_screen/comment_screen.dart';
import '../profile/profile_user/profile_user.dart';

class FeedScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialCreateRateSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return BuildCondition(
          condition: SocialCubit.get(context).posts.isNotEmpty &&
              SocialCubit.get(context).model != null,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildPostItem(cubit.posts[index], context, index),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8.0),
                  itemCount: cubit.posts.length,
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
          fallback: (context) =>
              const Center(child: (CircularProgressIndicator())),
        );
      },
    );
  }
}

bool isLiked = false;
bool isColored = false;

Widget buildPostItem(PostModel postModel, context, index) => Card(
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
                InkWell(
                    child: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        '${postModel.image}',
                      ),
                    ),
                    onTap: () {
                      navigateTo(context, const ProfileUser());
                    }),
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
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        DateFormat("MMM d, y")
                            .format(DateTime.parse('${postModel.dateTime}')),
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.4,
                            ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 16.0,
                  ),
                  onPressed: () {
                    ShowModel(context, postModel, index);
                  },
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            if (postModel.location != '')
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11.0),
                child: Row(
                  children: [
                    const Icon(
                      IconBroken.Location,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 5.0),
                    Expanded(
                      child: Text(
                        '${postModel.location}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              height: 1.4,
                              color: Colors.blue,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            if (postModel.text != '')
              Text(
                '${postModel.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            if (postModel.postImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * .35,
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
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
              ),
              child: Row(
                children: [
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            size: 20.0,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            '${SocialCubit.get(context).likesNumber[SocialCubit.get(context).postsId[index]]}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      if (isLiked == false) {
                        SocialCubit.get(context)
                            .likePost(SocialCubit.get(context).postsId[index]);
                        isLiked = true;
                      } else {
                        SocialCubit.get(context).unlikePost(
                            SocialCubit.get(context).postsId[index]);
                        isLiked = false;
                      }
                    },
                    onLongPress: () {
                      //navigateTo(context, const FavoritesScreen());
                    },
                  ),
                  const Spacer(),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Star,
                            size: 20.0,
                            color: Colors.yellow,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            '10/10',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                  const Spacer(),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            IconBroken.Chat,
                            size: 16.0,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            //'view all 55 comment',
                            'view all ${SocialCubit.get(context).commentsNumber[SocialCubit.get(context).postsId[index]]} comment',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      navigateTo(
                          context,
                          CommentScreen(
                              postId: SocialCubit.get(context).postsId[index]));
                      SocialCubit.get(context).getComments(
                          postId: SocialCubit.get(context).postsId[index]);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18.0,
                          backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).model!.image}',
                          ),
                        ),
                        const SizedBox(width: 15.0),
                        Text(
                          'write a comment ...',
                          style:
                              Theme.of(context).textTheme.caption!.copyWith(),
                        ),
                      ],
                    ),
                    onTap: () {
                      navigateTo(
                          context,
                          CommentScreen(
                              postId: SocialCubit.get(context).postsId[index]));
                      SocialCubit.get(context).getComments(
                          postId: SocialCubit.get(context).postsId[index]);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

void ShowModel(context, PostModel, index) {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          height: 250,
          padding: const EdgeInsetsDirectional.only(top: 10),
          decoration: const BoxDecoration(
            //color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(20),
              topEnd: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).addToFavorites(
                        dateTime: PostModel.dateTime,
                        image: PostModel.image,
                        name: PostModel.name,
                        text: PostModel.text,
                        location: PostModel.location,
                        postImage: PostModel.postImage,
                        postsId: PostModel.uId,
                        uId: PostModel.uId,
                      );
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Add to favorites",
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Add this to your favorites item",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).addToWatchLater(
                        dateTime: PostModel.dateTime,
                        image: PostModel.image,
                        name: PostModel.name,
                        text: PostModel.text,
                        location: PostModel.location,
                        postImage: PostModel.postImage,
                        postsId: PostModel.uId,
                        uId: PostModel.uId,
                      );
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Time_Circle,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Add to watch later",
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Add this to your watch later item",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
