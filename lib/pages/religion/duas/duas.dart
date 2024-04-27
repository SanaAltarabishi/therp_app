import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_task_app/pages/religion/duas/duas_model.dart';
import 'package:multi_task_app/pages/religion/duas/duas_provider.dart';
import 'package:multi_task_app/pages/religion/duas/favourite.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class DuasPage extends StatefulWidget {
  const DuasPage({super.key});

  @override
  State<DuasPage> createState() => _DuasPageState();
}

class _DuasPageState extends State<DuasPage> {
  final PageController _pageController =
      PageController(viewportFraction: 0.5, initialPage: 2);
  int _currentPageIndex = 2;
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth =MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xfff3dbcc),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: SizedBox(
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: PageView.builder(
                      scrollDirection: Axis.vertical,
                      controller: _pageController,
                      itemCount: duas.length,
                      itemBuilder: (context, index) {
                        return DuasCard(
                            duas: duas[index],
                            isCurrentPage: _currentPageIndex == index);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ).animate().fade(delay: .5.seconds, duration: .5.seconds),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xffa96054),
                ),
              ),
              Text(
                "DUAS",
                style: GoogleFonts.bagelFatOne(
                  fontSize:  screenWidth / 15,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffa96054),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child:const FavouritePage(),
                          type: PageTransitionType.fade));
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Color(0xffa96054),
                ),
              ),
            ],
          ).animate().fade(delay: .2.seconds, duration: .3.seconds),
        ],
      ),
    );
  }
}

class DuasCard extends StatelessWidget {
  const DuasCard({super.key, required this.duas, required this.isCurrentPage});
  final DuasModel duas;
  final bool isCurrentPage;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DuasProvider>(context);
    return AnimatedContainer(
      padding:const EdgeInsets.all(20),
      duration:const Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(
          vertical: 10, horizontal: isCurrentPage ? 0.0 : 16),
      height: isCurrentPage ? 300 : 250,
      width: isCurrentPage ? 250 : 200,
      decoration: BoxDecoration(
        color: isCurrentPage
            ?const Color(0xffa96054)
            :const Color(0xffa96054).withOpacity(0.6),
        borderRadius: BorderRadius.circular(15),
        boxShadow:const [
          BoxShadow(
            color: Color(0xff795a59),
            offset: Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
       const   SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              duas.duas,
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              style:const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xfff3dbcc),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: IconButton(
              icon: provider.isExist(duas.duas)
                  ?const Icon(
                      Icons.favorite,
                      color: Color(0xfff3dbcc),
                    )
                  :const Icon(
                      Icons.favorite_border,
                      color: Color(0xfff3dbcc),
                    ),
              onPressed: () {
                provider.addDuas(duas.duas);
              },
            ),
          )
        ],
      ),
    );
  }
}
