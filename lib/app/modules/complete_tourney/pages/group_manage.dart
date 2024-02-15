import 'package:flutter/material.dart';
import 'package:tourney_craft/app/modules/complete_tourney/widgets/group_widget.dart';
import 'package:tourney_craft/app/shared/components/base_app_bar.dart';
import 'package:tourney_craft/app/shared/themes/themes.dart';

import '../../../shared/models/tourney.dart';
import '../cubit/complete_tourney_cubit.dart';

class GroupManagePage extends StatefulWidget {
  final CompleteTourneyCubit cubit;
  final List<PlayerModel> playersList;
  final List<int> groups;
  final int selectedGroup;

  const GroupManagePage({
    super.key,
    required this.groups,
    required this.selectedGroup,
    required this.playersList,
    required this.cubit,
  });

  @override
  State<GroupManagePage> createState() => _GroupManagePageState();
}

class _GroupManagePageState extends State<GroupManagePage> {
  int selectedGroup = -1;
  int selectedBusinessId = -1;

  List<List<PlayerModel>> groupsList = [];

  @override
  void initState() {
    selectedGroup = widget.selectedGroup;
    groupsList = List.generate(widget.groups.length, (index) => []);
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
          Container(
            height: sizeOf.height * 0.7,
            margin: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.secondaryBlack,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(.2),
                  blurRadius: 8,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: GroupWidget(
              playersList: groupsList[selectedGroup - 1],
              onAddPlayer: () {
                print('Adicionar jogador');
              },
            ),
          )
        ],
      ),
    );
  }
}
