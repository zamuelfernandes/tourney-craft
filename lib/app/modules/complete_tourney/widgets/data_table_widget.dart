import 'package:flutter/material.dart';
import 'package:tourney_craft/app/modules/complete_tourney/cubit/complete_tourney_cubit.dart';
import 'package:tourney_craft/app/shared/models/tourney.dart';
import 'package:tourney_craft/app/shared/themes/themes.dart';

class DataTableWidget extends StatefulWidget {
  final CompleteTourneyCubit cubit;
  final List<List<MatchModel>> matches;
  final bool isReturn;

  DataTableWidget({
    required this.matches,
    required this.isReturn,
    required this.cubit,
  });

  @override
  State<DataTableWidget> createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  @override
  Widget build(BuildContext context) {
    List<List<MatchModel>> rodada = [];
    if (widget.isReturn) {
      rodada = widget.cubit.invertMatches(widget.matches);
    } else {
      rodada = widget.matches;
    }

    return ListView.builder(
      itemCount: rodada.length,
      padding: EdgeInsets.all(12),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Round ${index + 1}'.toUpperCase(),
                    style: AppTextStyle.titleSmallStyle,
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: rodada[index].map((partida) {
                      final player1 =
                          widget.cubit.pickPlayerById(id: partida.player1Id);
                      final player2 =
                          widget.cubit.pickPlayerById(id: partida.player2Id);
                      return Text(
                        '${player1.teamName} x ${player2.teamName}',
                        style: AppTextStyle.subtitleStyle.copyWith(
                          fontSize: 16,
                        ),
                      );
                    }).toList(),
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
