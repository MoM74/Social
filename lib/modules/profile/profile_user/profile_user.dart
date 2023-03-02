import 'package:buildcondition/buildcondition.dart';
import 'package:fire_Social/models/outfit_post_model.dart';
import 'package:fire_Social/models/outfit_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../layout/cubit/cubit.dart';
import '../../../layout/cubit/states.dart';
import '../../../shared/styles/icon_broken.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).model;
        return Scaffold(
          appBar: AppBar(
            title: Text("${model?.name}",
                style: const TextStyle(
                  fontSize: 16,
                )),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 200.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            height: 160.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(
                                  4.0,
                                ),
                                topRight: Radius.circular(
                                  4.0,
                                ),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  '${model?.cover}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 65.0,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage: NetworkImage(
                              '${model?.image}',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '${model?.name}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '${model?.bio}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  //"100",
                                  "${SocialCubit.get(context).userPosts.length}",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Posts',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '300',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Photos',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '5k',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Followers',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '1',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Followings',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            SocialCubit.get(context).addFollowers(
                              image: model?.image,
                              name: model?.name,
                              uId: model?.uId,
                            );
                          },
                          child: const Text(
                            'Follow',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MaterialButton(
                          color: Colors.blue,
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Icon(
                                IconBroken.Message,
                                size: 24.0,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                'Message',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                          size: 24.0,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return buildPostItem(
                          SocialCubit.get(context).posts[index],
                          model!,
                          context,
                          index);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 5),
                    itemCount: SocialCubit.get(context).posts.length,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildPostItem(
        PostModel postModel, UserModel userModel, context, index) =>
    BuildCondition(
      condition: (postModel.uId == userModel.uId),
      builder: (context) {
        return Padding(
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
                  const SizedBox(width: 15.0),
                  IconButton(
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 16.0,
                    ),
                    onPressed: () {},
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
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
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
              if (postModel.postImage != '' && postModel.uId == userModel.uId)
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
                        SocialCubit.get(context)
                            .likePost(SocialCubit.get(context).postsId[index]);
                      },
                    ),
                    const SizedBox(width: 25.0),
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
                              '7/10',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        //RatingModel(context);
                      },
                    ),
                    Expanded(
                      child: InkWell(
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
                                'view all ${SocialCubit.get(context).commentsNumber[SocialCubit.get(context).postsId[index]]} Comment',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          /*navigateTo(
                                context,
                                CommentScreen(postId: SocialCubit.get(context).postsId[index]));*/
                        },
                      ),
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
                        /*navigateTo(
                              context,
                              CommentScreen(postId: SocialCubit.get(context).postsId[index]));*/
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      fallback: (context) => Container(),
    );
