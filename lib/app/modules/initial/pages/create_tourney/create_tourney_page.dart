import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/components/base_app_bar.dart';
import 'cubit/create_tourney_cubit.dart';
import 'cubit/create_tourney_state.dart';

class CreateTourneyPage extends StatefulWidget {
  const CreateTourneyPage({super.key});

  @override
  _CreateTourneyPageState createState() => _CreateTourneyPageState();
}

class _CreateTourneyPageState extends State<CreateTourneyPage> {
  late CreateTourneyCubit _cubit;

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  void initState() {
    _cubit = CreateTourneyCubit()..fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(),
      body: BlocConsumer<CreateTourneyCubit, CreateTourneyState>(
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
            print(state.data.first);

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
                child: Text(
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
