import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:musiq/bloc/FeatchLibraty/featch_library_cubit.dart';
import 'package:musiq/core/colors.dart';
import 'package:musiq/core/sized.dart';
import 'package:musiq/main.dart';
import 'package:musiq/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:musiq/presentation/commanWidgets/textfeild.dart';
import 'package:musiq/presentation/screens/LibraryScreen/library_screen.dart';
import 'package:musiq/presentation/screens/homeScreen/home_screen.dart';
import 'package:musiq/bloc/home_screen_cubit/home_screen_cubit.dart';
import 'package:musiq/bloc/ThemeCubit/theme_cubit.dart';
import 'package:musiq/presentation/screens/homeScreen/widgets/drawer_widget.dart';
import 'package:musiq/presentation/screens/searchScreen/search_screen.dart';
import 'package:musiq/presentation/screens/settingsScreen/setting_screen.dart';
import 'package:musiq/presentation/screens/loginScreen/login_screen.dart';
import 'package:musiq/services/auth.dart'; // Import the login screen

Auth auth = Auth();

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    // LibraryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkToken();
    context.read<HomeScreenCubit>().loadData();
    // context.read<FavoriteBloc>().add(FeatchFavoriteSongEvent());
    // context.read<FeatchLibraryCubit>().featchLibrary();
  }

  Future<void> _refreshData() async {
    context.read<HomeScreenCubit>().loadData();
    // context.read<FeatchLibraryCubit>().featchLibrary();
    // context.read<FavoriteBloc>().add(FeatchFavoriteSongEvent());
  }

  void _checkToken() async {
    // Replace with your actual token check logic
    String? token = await auth.getToken();
    if (token == null || token.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= ScreenBreakpoints.tablet) {
              // Desktop or Tablet Layout
              return Scaffold(
                body: Row(
                  children: [
                    NavigationRail(
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? black
                              : white,
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: _onItemTapped,
                      labelType: NavigationRailLabelType.selected,
                      destinations: <NavigationRailDestination>[
                        NavigationRailDestination(
                          indicatorColor: colorList[colorIndex],
                          icon: Icon(Icons.home),
                          label: Text('Home'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.favorite),
                          label: Text('Favorites'),
                        ),
                      ],
                      selectedIconTheme: IconThemeData(
                        color: colorList[colorIndex],
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.settings,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _refreshData,
                        child: Row(
                          children: [
                            Expanded(
                                child:
                                    _widgetOptions.elementAt(_selectedIndex)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // Mobile Layout
              return Scaffold(
                appBar: AppBar(
                  title: _selectedIndex == 0
                      ? Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(18),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SearchScreen(),
                                    ),
                                  );
                                },
                                child: AbsorbPointer(
                                  child: CustomTextFeild(
                                    hintText: "Search",
                                    icon: Icon(
                                      Icons.search,
                                      color: colorList[colorIndex],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const Text("Library"),
                ),
                drawer: isMobile(context) ? const DrawerWidget() : null,
                body: Stack(
                  children: [
                    RefreshIndicator(
                      onRefresh: _refreshData,
                      child: Center(
                        child: _widgetOptions.elementAt(_selectedIndex),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: GNav(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  backgroundColor: Colors.transparent,
                  color: Colors.grey[800],
                  haptic: true,
                  activeColor: colorList[colorIndex],
                  tabBackgroundColor: colorList[colorIndex].withOpacity(0.1),
                  gap: 5,
                  padding: const EdgeInsets.all(10),
                  tabMargin: EdgeInsets.all(14),
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    // GButton(
                    //   icon: Icons.library_music_sharp,
                    //   text: 'Library',
                    // ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: _onItemTapped,
                ),
              );
            }
          },
        );
      },
    );
  }
}
