import 'package:flutter/material.dart';
import 'package:image/screens/explore_screens.dart';
import 'package:image/screens/favorite_screens.dart';
import 'package:image/screens/home_screens.dart';
import 'package:image/utils/my_state.dart';
import 'package:image/utils/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterDownloader.initialize(debug: false);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController controller = PageController();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  List<Widget> pages = [
    const HomePage(),
    const ExplorePage(),
    const FavoritePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeState()),
        ChangeNotifierProvider(create: (context) => PageState()),
      ],
      builder: (context, child) {
        final themeState = Provider.of<ThemeState>(context);
        final pageState = Provider.of<PageState>(context);
        themeState.getTheme();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SpashScreen(
            controller: controller,
            pages: pages,
            pageState: pageState,
          ),
          themeMode: themeState.currentThemeMode,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            canvasColor: Colors.white,
            primaryColor: Colors.white,
            colorScheme: const ColorScheme.light(),
          ),
          darkTheme: themeState.getDarkTheme(),
        );
      },
    );
  }
}
