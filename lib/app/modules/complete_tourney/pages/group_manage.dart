import 'package:flutter/material.dart';
import 'package:tourney_craft/app/modules/complete_tourney/widgets/group_widget.dart';
import 'package:tourney_craft/app/shared/components/base_app_bar.dart';
import 'package:tourney_craft/app/shared/themes/themes.dart';

import '../../../shared/models/tourney.dart';

class GroupManagePage extends StatefulWidget {
  final List<PlayerModel> playersList;
  final List<int> groups;
  final int selectedGroup;

  const GroupManagePage({
    super.key,
    required this.groups,
    required this.selectedGroup,
    required this.playersList,
  });

  @override
  State<GroupManagePage> createState() => _GroupManagePageState();
}

class _GroupManagePageState extends State<GroupManagePage> {
  int selectedGroup = -1;
  int selectedBusinessId = -1;

  @override
  void initState() {
    selectedGroup = widget.selectedGroup;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: BaseAppBar(title: 'Organizar Grupos'),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Card(
            elevation: 5,
            surfaceTintColor: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<int>(
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(5),
                value: selectedGroup,
                items: widget.groups.map((int group) {
                  return DropdownMenuItem<int>(
                    value: group,
                    child: Text('Grupo $group'),
                  );
                }).toList(),
                onChanged: (int? value) {
                  if (value != null) {
                    setState(() {
                      selectedGroup = value;
                    });
                    //   _cubit.filter(
                    //   books: books,
                    //   selectedDate: DateTime(
                    //     DateTime.now().year,
                    //     state.selectedMonth!,
                    //   ),
                    //   selectedBusinessId: i,
                    // );
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: sizeOf.height * 0.7,
            child: GroupWidget(
              playersList: widget.playersList,
            ),
          )
        ],
      ),
    );
  }
}
