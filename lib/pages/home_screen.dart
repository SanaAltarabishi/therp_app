// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:multi_task_app/pages/entertainment/entertainment_screen.dart';
import 'package:multi_task_app/pages/health/health_screen.dart';
import 'package:multi_task_app/pages/productivity/productivity_screen.dart';
import 'package:multi_task_app/pages/religion/religion_screen.dart';
import 'package:multi_task_app/pages/tools/tools_screen.dart';

//0xfff1d9c9
class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  late Color customColor;

  List<NavigationItems> items = [
    const NavigationItems(
      icon: Icon(Icons.account_tree_rounded),
      title: Text(
        'Tools',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      color: Color(0xffcb8780),
      //screen: ToolsScreen(),
    ),
    const NavigationItems(
      icon: Icon(Icons.healing_outlined),
      title: Text(
        'Health',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      color: Color(0xffa36168),
      // screen: HealthScreen(),
    ),
    const NavigationItems(
      icon: Icon(Icons.add_reaction_outlined),
      title: Text(
        'Entertainment',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      color: Color(0xff7a6c5b),
      // screen: EntertainmentScreen(),
    ),
    const NavigationItems(
      icon: Icon(Icons.auto_stories_sharp),
      title: Text(
        'Religion',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      color: Color(0xffa96054),
      // screen: ReligionScreen(),
    ),
    const NavigationItems(
      icon: Icon(Icons.ads_click_rounded),
      title: Text(
        'Productivity',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      color: Color(0xff5c666c),
      //screen: ProductivityScreen(),
    ),
  ];

  Widget _buildItem(NavigationItems item, bool isSelect) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 370),
      height: double.maxFinite,
      width: isSelect ? 190 : 50,
      decoration: isSelect
          ? BoxDecoration(
              color: item.color.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(50)))
          : null,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding:const EdgeInsets.all(8), //!maby will change this
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconTheme(
                  data: IconThemeData(
                      size: 30,
                      color: isSelect ? item.color :const Color(0xff795a59)),
                  child: item.icon,
                ),
                Padding(
                  padding:const EdgeInsets.only(left: 8),
                  child: isSelect
                      ? DefaultTextStyle.merge(
                          style: TextStyle(
                            color: item.color,
                          ),
                          child: item.title)
                      : Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> itemsScreen =const [
    ToolsScreen(),
    HealthScreen(),
    EntertainmentScreen(),
    ReligionScreen(),
    ProductivityScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xfff3dbcc),
      bottomNavigationBar: Container(
        padding:const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        height: 70,
        decoration:const BoxDecoration(color: Color(0xfff3dbcc), boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
          )
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.map((e) {
            var itemIndex = items.indexOf(e);
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = itemIndex;
                });
              },
              child: _buildItem(e, selectedIndex == itemIndex),
            );
          }).toList(),
        ),
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: selectedIndex,
            children: itemsScreen,
          ),
          Align(
            alignment:const Alignment(-1, -1),
            child: ClipPath(
              clipper: CustomMenuCliper(),
              child: Container(
                alignment: Alignment.centerLeft,
                width: 35,
                height: 110,
                //! need to take the items color
                color: selectedIndex == 0
                    ?const Color(0xffcb8780)
                    : (selectedIndex == 1
                        ?const Color(0xffa36168)
                        : (selectedIndex == 2
                            ?const Color(0xff7a6c5b)
                            : (selectedIndex == 3
                                ?const Color(0xffa96054)
                                :const Color(0xff5c666c)))),
                child:const Icon(
                  Icons.menu_open_sharp,
                  color: Color(0xfff3dbcc),
                )
                    .animate(
                      onPlay: (controller) => controller.repeat(),
                    )
                    .shimmer(duration: 2.seconds),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//models:
class NavigationItems {
  final Icon icon;
  final Text title;
  final Color color;
  const NavigationItems({
    required this.icon,
    required this.title,
    required this.color,
  });
}

class CustomMenuCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);

    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 9, 0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
