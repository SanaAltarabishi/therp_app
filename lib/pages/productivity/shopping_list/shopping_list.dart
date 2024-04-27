import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_task_app/pages/productivity/shopping_list/bag_content.dart';
import 'package:multi_task_app/pages/productivity/shopping_list/bag_model.dart';
import 'package:multi_task_app/pages/productivity/shopping_list/bag_shape_painter.dart';
import 'package:page_transition/page_transition.dart';

class BagShapeScreen extends StatefulWidget {
  const BagShapeScreen({super.key});
  @override
  State<BagShapeScreen> createState() => _BagShapeScreenState();
}

class _BagShapeScreenState extends State<BagShapeScreen> {
  double fullness = 0.1;
  late String bagName = 'uni needs';
  late List<BagContainerModel> bagContainerModels = [
    BagContainerModel(
      bagName: 'uni needs',
      sliderValue: 33.333,
      checkboxValues: [true, false, false],
      checkboxTexts: ['note book', 'pen', 'bag'],
      fullness: 33.33,
    ),
  ];
  TextEditingController _textAddBagController = TextEditingController();
  Widget _buildContainer(int index) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 80, left: 40, right: 40, bottom: 10),
        child: CustomPaint(
            painter:
                BagShapePainter(fullness:bagContainerModels[index].fullness),//bageContainers[index].
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.open_with_sharp,
                      color: Color(0xff5c666c),
                    ),
                    onPressed: () {
                      _navigateToContainerPage(
                          context, index, fullness, bagName);
                    },
                  ),
                ),
                Text(
                  '${bagContainerModels[index].bagName}\ncomplete: ${(bagContainerModels[index].sliderValue.toInt())}%',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color(0xff5c666c), fontWeight: FontWeight.bold),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Color(0xff5c666c),
                      ),
                      onPressed: () {
                        _deleteContainer(index);
                      },
                    ),
                  ),
                ),
              ],
            )));
  }

  void _navigateToContainerPage(
      BuildContext context, int index, double fullness, String bagName) async {
    final updatedModel = await Navigator.push(
        context,
        PageTransition(
            child: ContainerPage(
              bagContainerModel: bagContainerModels[index],
              // fullness: fullness,
            ),
            type: PageTransitionType.fade));

    if (updatedModel != null) {
      setState(() {
      bagContainerModels[index] = updatedModel;
     bagContainerModels[index].sliderValue = updatedModel.sliderValue;
      bagContainerModels[index].fullness = updatedModel.fullness;
      bagContainerModels[index].bagName = updatedModel.bagName;
      });
    }
  }

  void _deleteContainer(int index) {
    setState(() {
      bagContainerModels.removeAt(index);
    });
  }

  Future<void> _addContainer() async {
    // final text =
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xfff3dbcc).withOpacity(0.9),
          title: const Text(
            'Enter the name',
            style: TextStyle(
                color: Color(0xff5c666c), fontWeight: FontWeight.bold),
          ),
          content: TextField(
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xff5c666c),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff5c666c),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff5c666c),
                ),
              ),
            ),
            cursorColor: const Color(0xfff3dbcc),
            controller: _textAddBagController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    color: Color(0xff5c666c), fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  String newText = _textAddBagController.text;

                  bagContainerModels.add(BagContainerModel(
                    bagName: newText,
                    sliderValue: 0,
                    fullness: 0,
                    checkboxValues: [],
                    checkboxTexts: [],
                  ));
                });
                _textAddBagController.clear();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Add',
                style: TextStyle(
                    color: Color(0xff5c666c), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: const Color(0xff5c666c),
        tooltip: 'Add',
        child: const Icon(
          Icons.add,
          color: Color(0xfff3dbcc),
        ),
        onPressed: () {
          _addContainer();
        },
      ),
      backgroundColor: const Color(0xfff3dbcc),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Shopping list',
                    style: GoogleFonts.bagelFatOne(
                      fontSize: screenWidth / 15,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff5c666c),
                    )).animate().fade(delay: .4.seconds, duration: .5.seconds),
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: bagContainerModels.length,
                    itemBuilder: (context, index) {
                      return _buildContainer(index).animate().fade(delay: .6.seconds, duration: .7.seconds);
                    },
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xff5c666c),
            ),
          ).animate().fade(delay: .2.seconds, duration: .3.seconds),
        ],
      ),
    );
  }
}
