// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tourney_craft/app/shared/themes/themes.dart';

import '../../../shared/components/base_bottom_message.dart';

// ignore: must_be_immutable
class SwitchesWidgets extends StatefulWidget {
  bool loosersOption;
  bool winnerLowerOption;
  bool quartersOption;
  bool octavesOption;
  final int playersQuant;
  SwitchesWidgets({
    Key? key,
    required this.loosersOption,
    required this.winnerLowerOption,
    required this.quartersOption,
    required this.octavesOption,
    required this.playersQuant,
  }) : super(key: key);

  @override
  State<SwitchesWidgets> createState() => _SwitchesWidgetsState();
}

class _SwitchesWidgetsState extends State<SwitchesWidgets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Switch.adaptive(
                  value: widget.loosersOption,
                  onChanged: (value) {
                    setState(() {
                      widget.loosersOption = value;
                    });
                  },
                ),
                SizedBox(width: 5),
                Text(
                  'Loosers Game',
                  style: AppTextStyle.subtitleStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Switch.adaptive(
                  value: widget.quartersOption,
                  onChanged: (value) {
                    setState(() {
                      widget.quartersOption = value;
                      widget.playersQuant >= 16
                          ? widget.octavesOption = !value
                          : null;
                      if (widget.quartersOption == true)
                        widget.winnerLowerOption = false;
                    });
                  },
                ),
                SizedBox(width: 5),
                Text(
                  'Quartas',
                  style: AppTextStyle.subtitleStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Switch.adaptive(
                  value: widget.winnerLowerOption,
                  onChanged: (value) {
                    setState(() {
                      widget.winnerLowerOption = value;
                      if (widget.winnerLowerOption == true) {
                        widget.quartersOption = false;
                        widget.octavesOption = false;
                      }
                    });
                  },
                ),
                SizedBox(width: 5),
                Text(
                  'Winner/Lower',
                  style: AppTextStyle.subtitleStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Switch.adaptive(
                  value: widget.octavesOption,
                  onChanged: (value) {
                    if (widget.playersQuant < 16) {
                      BaseBottomMessage.showMessage(
                        context,
                        'Quantidade de jogadores insuficiente\npara oitavas de final!',
                        AppColors.secondaryBlack,
                      );
                    } else {
                      setState(() {
                        widget.quartersOption = !value;
                        widget.octavesOption = value;

                        if (widget.octavesOption == true)
                          widget.winnerLowerOption = false;
                      });
                    }
                  },
                ),
                SizedBox(width: 5),
                Text(
                  'Oitavas',
                  style: AppTextStyle.subtitleStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
