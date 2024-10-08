import 'package:flutter/cupertino.dart';
 import 'package:restinio_app/src/core/navigation/routes.dart';

class OnErrorScreen extends StatelessWidget {
  const OnErrorScreen({super.key});

 
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Oops! Something went wrong!'),
            const SizedBox(height: 20),
            CupertinoButton(
              onPressed: () {
                FirstTabRoute().go(context);
              },
              child: const Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}
