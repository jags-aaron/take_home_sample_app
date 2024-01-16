import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:take_home_sample_app/features/home/navigation/favorites_route.dart';
import 'home_screen_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.model,
  });

  final HomeScreenModel model;

  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();

    void scrollUp() {
      controller.animateTo(
        controller.position.minScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: scrollUp,
        child: const Icon(Icons.arrow_upward),
      ),
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Text('favorites', style: TextStyle(color: Colors.white)),
            onPressed: () {
              // TODO Move to controller
              GoRouter.of(context).goNamed(
                FavoritesRoute.routePath,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          controller: controller,
          itemBuilder: (context, index) {
            final article = model.articles[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 2,
                child: ListTile(
                  title: Text(
                    article.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    article.description,
                  ),
                  onTap: () => model.articlesPressed(article),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
