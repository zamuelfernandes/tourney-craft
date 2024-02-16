import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourney_craft/app/modules/complete_tourney/widgets/group_widget.dart';
import 'package:tourney_craft/app/shared/components/base_app_bar.dart';
import 'package:tourney_craft/app/shared/themes/themes.dart';

import '../../../shared/components/base_bottom_message.dart';
import '../../../shared/models/tourney.dart';
import '../cubit/complete_tourney_cubit.dart';
import '../cubit/complete_tourney_state.dart';

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
      body: BlocConsumer<CompleteTourneyCubit, CompleteTourneyState>(
        bloc: widget.cubit,
        listener: (context, state) {
          if (state.isSuccess) {
            //faz algo
          }

          if (state.isError) {
            //faz algo
          }
        },
        builder: (context, state) {
          return Column(
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
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: sizeOf.height * 0.6,
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
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : GroupWidget(
                        playersList: state.groupsList[selectedGroup - 1],
                        onAddPlayer: () {
                          List<PlayerModel> avaliablePlayers =
                              widget.playersList
                                  .where(
                                    (player) => !state.groupsList
                                        .any((group) => group.contains(player)),
                                  )
                                  .toList();

                          widget.cubit.addPlayersToGroupDialog(
                            context,
                            players: avaliablePlayers,
                            selectedGroup: selectedGroup,
                          );
                        },
                        onTapRemove: () {
                          widget.cubit.removePlayer(
                            context,
                            players: state.groupsList[selectedGroup - 1],
                            selectedGroup: selectedGroup,
                          );
                        },
                      ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: sizeOf.width * .55,
                height: sizeOf.height * .08,
                child: ElevatedButton(
                  onPressed: () async {
                    print(state.groupsList
                        .map((e) => e.map((e) => e.playerName)));

                    final result = await widget.cubit.registerGroups(
                      groupsList: state.groupsList,
                    );

                    BaseBottomMessage.showMessage(
                      context,
                      result,
                      AppColors.secondaryBlack,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Confirmar Grupos'.toUpperCase(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
