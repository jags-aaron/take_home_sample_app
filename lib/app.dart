import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common_platform/i_platform_client.dart';
import 'common_platform/mobile_platform_client.dart';
import 'app_router.dart';
import 'common_platform/theme/theme_data.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IPlatformClient>.value(
          value: MobilePlatformClient(),
        ),
        Provider<AppRouter>.value(
          value: AppRouter(),
        ),
      ],
      child: Builder(
        builder: (BuildContext context) {
          return MaterialApp.router(
            theme: themeData(),
            routerConfig: AppRouter.of(context).router,
          );
        },
      ),
    );
  }
}
