import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourney_craft/app/shared/components/base_bottom_message.dart';
import 'package:tourney_craft/app/shared/themes/themes.dart';

import '../../../shared/components/base_app_bar.dart';
import '../cubit/complete_tourney_cubit.dart';
import '../cubit/complete_tourney_state.dart';

class PlayerManagePage extends StatefulWidget {
  final CompleteTourneyCubit cubit;
  const PlayerManagePage({
    super.key,
    required this.cubit,
  });

  @override
  State<PlayerManagePage> createState() => _PlayerManagePageState();
}

class _PlayerManagePageState extends State<PlayerManagePage> {
  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.of(context).size;

    return Scaffold(
      appBar: BaseAppBar(title: 'Gerênciar Jogadores'),
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
          final playersList = state.tourney!.players;

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: sizeOf.height * 0.05,
                  child: Center(
                    child: Text(
                      'Finalizar cadastro\nde Jogadores'.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    height: sizeOf.height * 0.8,
                    child: state.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: playersList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 2,
                                child: ListTile(
                                  onTap: () {
                                    BaseBottomMessage.showMessage(
                                      context,
                                      'Ainda não implementado',
                                      AppColors.secondaryBlack,
                                    );
                                  },
                                  leading: CircleAvatar(
                                    child: Text(
                                      playersList[index].playerName[0],
                                    ),
                                  ),
                                  title: Text(
                                    playersList[index].playerName,
                                    style: AppTextStyle.titleSmallStyle
                                        .copyWith(fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    playersList[index].teamName,
                                    style: AppTextStyle.subtitleStyle
                                        .copyWith(fontSize: 14),
                                  ),
                                  trailing: Card(
                                    surfaceTintColor: AppColors.white,
                                    elevation: 2,
                                    child: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        BaseBottomMessage.showMessage(
                                          context,
                                          'Ainda não implementado',
                                          AppColors.secondaryBlack,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          widget.cubit.registerPlayerDialog(context);
        },
        label: Text('Add Jogador'),
        icon: Icon(Icons.add),
        backgroundColor: AppColors.secondaryBlack,
      ),
    );
  }
}
