import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:multi_task_app/pages/productivity/shopping_list/bag_model.dart';
import 'package:multi_task_app/pages/productivity/shopping_list/bag_shape_painter.dart';

class ContainerPage extends StatefulWidget {
  //double fullness;
  final BagContainerModel bagContainerModel;

  ContainerPage({
    required this.bagContainerModel,
  });

  @override
  State<ContainerPage> createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  late List<String> checkboxTexts;
  late List<bool> checkboxValues;
  late String bagName;
  late double sliderValue;
  late double fullness;
  final TextEditingController _textEditingController = TextEditingController();
  GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    sliderValue = widget.bagContainerModel.sliderValue;
    fullness = widget.bagContainerModel.fullness;
    bagName = widget.bagContainerModel.bagName;
    checkboxValues = List.from(widget.bagContainerModel.checkboxValues);
    checkboxTexts = List.from(widget.bagContainerModel.checkboxTexts);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xfff3dbcc),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Center(
                  child: SizedBox(
                    width: screenWidth / 1.6,
                    height: screenHeight / 1.6,
                    child: CustomPaint(
                      painter: BagShapePainter(fullness: fullness),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 12, top: 2, bottom: 20),
                        child: AnimatedList(
                          key: _listKey,
                          initialItemCount: checkboxValues.length,
                          itemBuilder: (context, index, animation) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _buildCheckboxItem(
                                  index, animation, widget.bagContainerModel),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xff5c666c))),
                  onPressed: () async {
                    await _addCheckbox();
                  },
                  child: const Text(
                    'Add Checkbox',
                    style: TextStyle(color: Color(0xfff3dbcc)),
                  ),
                ),
                Slider(
                  inactiveColor: const Color(0xff5c666c).withOpacity(0.3),
                  activeColor: const Color(0xff5c666c),
                  value: sliderValue,
                  onChanged: (newVal) {
                    setState(() {
                      fullness = newVal;
                    });
                  },
                  min: 0.0,
                  max: 100,
                  divisions:
                      checkboxValues.isNotEmpty ? checkboxValues.length : 1,
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
      floatingActionButton: FloatingActionButton(
        tooltip: "save",
        backgroundColor: const Color(0xff5c666c),
        onPressed: () {
          _returnUpdatedModel();
        },
        child: const Icon(
          Icons.save_outlined,
          color: Color(0xfff3dbcc),
        ),
      ),
    );
  }

  Widget _buildCheckboxItem(int index, Animation<double> animation,
      BagContainerModel bagContainerModel) {
    if (index <= bagContainerModel.checkboxTexts.length) {
      return SizeTransition(
        sizeFactor: animation,
        child: Dismissible(
          key: Key('${bagContainerModel.bagName}_$index'),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            _deleteCheckbox(index);
            setState(() {});
          },
          background: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Container(
              color: Colors.red.shade200,
              alignment: Alignment.centerLeft,
              child: const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
            ),
          ),
          child: CheckboxListTile(
            activeColor: const Color(0xff5c666c),
            title: Text(checkboxTexts[index]), // Use text value
            value: checkboxValues[index],
            onChanged: (value) {
              setState(() {
                checkboxValues[index] = value!;
                sliderValue = _calculateSliderValue();
                fullness = sliderValue;
              });
            },
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Future<void> _addCheckbox() async {
    _textEditingController.clear(); // Clear the text field

    final text = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xfff3dbcc).withOpacity(0.9),
          title: const Text(
            'Enter the item',
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
            controller: _textEditingController,
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
                  final newText = _textEditingController.text;
                  checkboxTexts.add(newText); // Add text to checkboxTexts
                  checkboxValues.add(false); // Add corresponding boolean value
                  _listKey.currentState?.insertItem(checkboxValues.length - 1);
                  sliderValue = _calculateSliderValue();
                  fullness = sliderValue;
                });

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

    if (text != null) {
      setState(() {
        sliderValue = _calculateSliderValue();
      });
    }
  }

  double _calculateSliderValue() {
    int checkedCount = checkboxValues.where((value) => value).length;
    double value = ((checkedCount / checkboxValues.length) * 100);

    return value;
  }

  void _returnUpdatedModel() {
    final updatedModel = BagContainerModel(
        sliderValue: sliderValue,
        checkboxValues: checkboxValues,
        checkboxTexts: checkboxTexts,
        fullness: fullness,
        bagName: bagName);
    Navigator.pop(context, updatedModel);
  }

  void _deleteCheckbox(int index) {
    setState(() {
      if (index >= 0 && index < checkboxValues.length) {
        checkboxValues.removeAt(index);
        checkboxTexts.removeAt(index); // Remove text from checkboxTexts
        sliderValue = checkboxValues.isNotEmpty ? _calculateSliderValue() : 0.0;
        fullness = sliderValue;
      }
    });
    _listKey.currentState?.removeItem(index, (context, animation) {
      return SizedBox();
    });
  }
}
