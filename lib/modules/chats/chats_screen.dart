import 'package:fire_Social/models/outfit_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../chats_details/chats_details_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) =>
              chatItemBuilder(SocialCubit.get(context).users[index], context),
          separatorBuilder: (context, index) => const SizedBox(height: 0),
          itemCount: SocialCubit.get(context).users.length,
        );
      },
    );
  }

  Widget chatItemBuilder(UserModel model, context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: InkWell(
          onTap: () {
            navigateTo(
                context,
                ChatsDetailsScreen(
                  model: model,
                ));
          },
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
              const SizedBox(width: 10.0),
              Text(
                '${model.name}',
                style: const TextStyle(
                  height: 1.4,
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
            ],
          ),
        ),
      );
}
