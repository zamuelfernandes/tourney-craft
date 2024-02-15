// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tourney_craft/app/shared/models/tourney.dart';
import 'package:tourney_craft/app/shared/themes/themes.dart';

class GroupWidget extends StatefulWidget {
  final List<PlayerModel> playersList;
  final void Function()? onAddPlayer;

  const GroupWidget({
    Key? key,
    required this.playersList,
    this.onAddPlayer,
  }) : super(key: key);

  @override
  State<GroupWidget> createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  @override
  Widget build(BuildContext context) {
    final players = widget.playersList;

    return ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final player = players.removeAt(oldIndex);
          players.insert(newIndex, player);
        });
      },
      children: [
        for (final player in players)
          Container(
            key: UniqueKey(),
            height: 80,
            margin: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle_rounded,
                      size: 30,
                    ),
                    title: Text(
                      player.playerName,
                      style: AppTextStyle.titleSmallStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      player.teamName,
                      style: AppTextStyle.subtitleStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.swipe_vertical_outlined,
                      size: 28,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      //ADD PLAYER
                    },
                    child: Icon(
                      Icons.close_sharp,
                      size: 15,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                )
              ],
            ),
          ),
      ],
      footer: GestureDetector(
        onTap: widget.onAddPlayer,
        child: Container(
          height: 80,
          margin: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Card(
            child: Center(
              child: Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
