import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:take_home_sample_app/features/home/screen/bloc/home_event.dart';

import '../../detail/navigation/detail_route.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_state.dart';
import 'home_screen.dart';
import 'home_screen_model.dart';

class HomeController extends StatelessWidget {
  const HomeController({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(InitialEvent());

    return BlocConsumer<HomeBloc, BlocHomeState>(
      listener: (context, state) {
        // TODO
      },
      builder: (context, state) {
        if (state.status == BlocHomeResult.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return HomeScreen(
          model: HomeScreenModel.build(
            title: 'Home',
            articles: state.articles,
            articlePressed: (article) {
              GoRouter.of(context).goNamed(
                DetailRoute.routePath,
                extra: article,
              );
            },
          ),
        );
      },
    );
  }
}
