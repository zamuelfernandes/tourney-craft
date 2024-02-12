import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/base_app_bar.dart';
import 'cubit/sample_cubit.dart';
import 'cubit/sample_state.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({super.key});

  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  late SampleCubit _cubit;

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  void initState() {
    _cubit = SampleCubit()..fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: BaseAppBar(),
      body: BlocConsumer<SampleCubit, SampleState>(
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
              height: sizeOf.height * 0.55,
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
              height: sizeOf.height * 0.55,
              width: sizeOf.height * 0.75,
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
              height: sizeOf.height * 0.55,
              width: sizeOf.height * 0.75,
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
