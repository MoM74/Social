import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/comment_model.dart';
import '../../shared/styles/icon_broken.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({Key? key, required this.postId}) : super(key: key);
  final now = DateTime.now();
  final String postId;
  TextEditingController textCommentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialCreateCommentSuccessState) {
          SocialCubit.get(context).getComments(postId: postId);
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Comments"),
            titleSpacing: 0,
            leading: IconButton(
              icon: const Icon(IconBroken.Arrow___Left_2),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildCommentItem(
                        SocialCubit.get(context).comments[index],
                        context,
                        index,
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 8.0,
                      ),
                      itemCount: cubit.comments.length,
                    ),
                  ),
                ),
                TextField(
                  controller: textCommentController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintText: 'Write a Comment ...',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        cubit.createComment(
                          commentText: textCommentController.text,
                          dateTime: now.toString(),
                          postId: postId,
                        );
                        //}
                        textCommentController.clear();
                      },
                      icon: const Icon(
                        IconBroken.Send,
                      ),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black, height: 1),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCommentItem(CommentModel commentModel, context, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 2.0,
        margin: const EdgeInsets.symmetric(
          horizontal: 1.0,
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
                      '${commentModel.image}',
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
                                '${commentModel.name}',
                                style: const TextStyle(
                                  height: 1.4,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                IconBroken.Delete,
                                size: 20.0,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          DateFormat("MMM d, y").format(
                              DateTime.parse('${commentModel.dateTime}')),
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
              if (commentModel.commentText != '')
                Text(
                  '${commentModel.commentText}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              if (commentModel.commentImage != '')
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
                          '${commentModel.commentImage}',
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
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                IconBroken.Heart,
                                size: 16.0,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                '55',
                                //'${SocialCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          //SocialCubit.get(context).getFavoritesList();
                        },
                      ),
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
                                '55 replay',
                                //'${SocialCubit.get(context).comments[index]} Comment',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
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
                            'write a replay ...',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
