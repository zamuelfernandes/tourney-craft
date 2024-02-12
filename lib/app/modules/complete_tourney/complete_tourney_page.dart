import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/base_app_bar.dart';
import 'cubit/complete_tourney_cubit.dart';
import 'cubit/complete_tourney_state.dart';

class CompleteTourneyPage extends StatefulWidget {
  final String tourneyId;
  const CompleteTourneyPage({
    super.key,
    required this.tourneyId,
  });

  @override
  _CompleteTourneyPageState createState() => _CompleteTourneyPageState();
}

class _CompleteTourneyPageState extends State<CompleteTourneyPage> {
  late CompleteTourneyCubit _cubit;

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  void initState() {
    _cubit = CompleteTourneyCubit()
      ..getTourneyById(
        tourneyId: widget.tourneyId,
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(),
      body: BlocConsumer<CompleteTourneyCubit, CompleteTourneyState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state.isSuccess) {
            //faz algo
          }

          if (state.isError) {
            //faz algo
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.55,
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            );
          }

          if (state.isSuccess) {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.55,
              width: MediaQuery.sizeOf(context).height * 0.75,
              child: Center(
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
            );
          }
          if (state.isError) {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.55,
              width: MediaQuery.sizeOf(context).height * 0.75,
              child: Center(
                child: SelectableText(
                  state.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
