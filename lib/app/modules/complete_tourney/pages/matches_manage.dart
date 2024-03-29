import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourney_craft/app/modules/complete_tourney/widgets/data_table_widget.dart';
import 'package:tourney_craft/app/shared/components/base_elevated_button.dart';

import '../../../shared/components/base_app_bar.dart';
import '../../../shared/components/base_bottom_message.dart';
import '../../../shared/themes/themes.dart';
import '../cubit/complete_tourney_cubit.dart';
import '../cubit/complete_tourney_state.dart';

class MatchesManagePage extends StatefulWidget {
  final CompleteTourneyCubit cubit;
  final int selectedGroup;
  final List<int> groups;

  const MatchesManagePage({
    super.key,
    required this.cubit,
    required this.selectedGroup,
    required this.groups,
  });

  @override
  State<MatchesManagePage> createState() => _MatchesManagePageState();
}

class _MatchesManagePageState extends State<MatchesManagePage> {
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
      appBar: BaseAppBar(
        title: 'Rodadas Preview',
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return widget.groups.map((int group) {
                return PopupMenuItem<int>(
                  value: group,
                  child: Text('Grupo $group'),
                );
              }).toList();
            },
            onSelected: (int value) {
              setState(() {
                selectedGroup = value;
              });
            },
            icon: Icon(Icons.filter_list_rounded),
          ),
        ],
      ),
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
          final groupMatches = widget.cubit.generateMatches(
            players: state.groupsList[selectedGroup - 1],
          );

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5),

                //========== JODOS DE IDA ==========
                Text(
                  'Jogos de Ida'.toUpperCase(),
                  style: AppTextStyle.subtitleStyle,
                ),
                Container(
                  height: sizeOf.height * 0.32,
                  margin: const EdgeInsets.all(10),
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
                  child: DataTableWidget(
                    cubit: widget.cubit,
                    matches: groupMatches,
                    isReturn: false,
                  ),
                ),
                const SizedBox(height: 10),
                //========= JODOS DE VOLTA ==========
                Text(
                  'Jogos de Volta'.toUpperCase(),
                  style: AppTextStyle.subtitleStyle,
                ),
                Container(
                  height: sizeOf.height * 0.32,
                  margin: const EdgeInsets.all(10),
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
                  child: DataTableWidget(
                    cubit: widget.cubit,
                    matches: groupMatches,
                    isReturn: true,
                  ),
                ),
                const SizedBox(height: 25),
                BaseElevatedButton(
                  onPressed: () async {
                    // print(state.groupsList
                    //     .map((e) => e.map((e) => e.playerName)));

                    // print(state.groupsList[selectedGroup - 1]
                    //     .map((e) => e.playerName));

                    final result = await widget.cubit.registerMatches();

                    BaseBottomMessage.showMessage(
                      context,
                      result,
                      AppColors.secondaryBlack,
                    );
                  },
                  label: 'Confirmar Chaveamento',
                ),

                const SizedBox(height: 50),
              ],
            ),
          );
        },
      ),
    );
  }
}
