// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tourney_craft/app/shared/models/tourney.dart';
import 'package:tourney_craft/app/shared/themes/themes.dart';

class GroupWidget extends StatefulWidget {
  final List<PlayerModel> itemList;

  const GroupWidget({
    Key? key,
    required this.itemList,
  }) : super(key: key);

  @override
  State<GroupWidget> createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  @override
  Widget build(BuildContext context) {
    final items = widget.itemList;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.4,
      child: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final item = items.removeAt(oldIndex);
            items.insert(newIndex, item);
          });
        },
        children: [
          for (final item in items)
            Container(
              key: UniqueKey(),
              height: 80,
              margin: const EdgeInsets.only(bottom: 5),
              child: Card(
                child: ListTile(
                  leading: Icon(
                    Icons.account_circle_rounded,
                    size: 30,
                  ),
                  title: Text(
                    item.playerName,
                    style: AppTextStyle.titleSmallStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    item.teamName,
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
            ),
        ],
        footer: InkWell(
          onTap: () {},
          child: Container(
            height: 80,
            child: Card(
              elevation: 2,
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
