import 'package:equatable/equatable.dart';

class LoginScreenModel extends Equatable {
  const LoginScreenModel._({
    required this.title,
    required this.onSuccess,
  });

  factory LoginScreenModel.build({
    required String title,
    bool? onSuccess,
  }) {
    return LoginScreenModel._(
      title: title,
      onSuccess: onSuccess ?? false,
    );
  }

  final String title;
  final bool onSuccess;

  @override
  List<Object?> get props => [
        title,
        onSuccess,
      ];
}
