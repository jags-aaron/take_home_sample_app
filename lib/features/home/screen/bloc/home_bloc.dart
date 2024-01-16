import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/use_case/get_top_headlines_use_case.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<BlocHomeEvent, BlocHomeState> {
  final GetTopHeadlinesUseCase getTopHeadUseCase;

  HomeBloc({
    required this.getTopHeadUseCase,
  }) : super(const BlocHomeState()) {
    on<InitialEvent>((event, emit) => _initialStream(event, emit));
  }

  void _initialStream(InitialEvent event, Emitter<BlocHomeState> emit) async {
    try {
      emit(
        state.copyWith(
          status: BlocHomeResult.loading,
        ),
      );

      final result = await getTopHeadUseCase.call();

      emit(
        state.copyWith(
          status: BlocHomeResult.success,
          articles: result,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      emit(
        state.copyWith(
          status: BlocHomeResult.error,
        ),
      );
    }
  }
}
