import 'package:flutter/material.dart';
import 'package:tourney_craft/app/modules/complete_tourney/cubit/complete_tourney_cubit.dart';
import 'package:tourney_craft/app/shared/models/tourney.dart';

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
    return DataTable(
      columnSpacing: 30,
      columns: [
        DataColumn(label: Text('Confronto')),
        DataColumn(label: Text('Home Team')),
        DataColumn(label: Text('Away Team')),
      ],
      rows: List<DataRow>.generate(widget.matches.length, (index) {
        MatchModel match = widget.matches[index][widget.isReturn ? 1 : 0];
        final player1 = widget.cubit.pickPlayerById(id: match.player1Id);
        final player2 = widget.cubit.pickPlayerById(id: match.player2Id);
        return DataRow(
          cells: [
            DataCell(Center(child: Text(index.toString()))),
            DataCell(Center(child: Text(player1.playerName))),
            DataCell(Center(child: Text(player2.playerName))),
          ],
        );
      }),
    );
  }
}
