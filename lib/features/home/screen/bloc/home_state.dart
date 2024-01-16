import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entity/article_entity.dart';

enum BlocHomeResult {
  initial,
  loading,
  error,
  success,
}

@immutable
class BlocHomeState extends Equatable {
  const BlocHomeState({
    this.status = BlocHomeResult.initial,
    this.articles = const [],
  });

  final BlocHomeResult? status;
  final List<TopHeadlineSourceEntity> articles;

  @override
  List<Object?> get props => [
    status,
    articles,
  ];

  BlocHomeState copyWith({
    required BlocHomeResult status,
    List<TopHeadlineSourceEntity>? articles,
  }) {
    return BlocHomeState(
      status: status,
      articles: articles ?? [],
    );
  }
}
