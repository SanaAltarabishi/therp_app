import 'package:flutter/material.dart';
import 'package:multi_task_app/pages/entertainment/color_Collaps_game/color_collaps.dart';
import 'package:multi_task_app/pages/entertainment/xo_game/xo_homepage.dart';
import 'package:multi_task_app/pages/health/massCalculate/massCalculate.dart';
import 'package:multi_task_app/pages/productivity/shopping_list/shopping_list.dart';
import 'package:multi_task_app/pages/productivity/todo/pages/show_add_task.dart';
import 'package:multi_task_app/pages/religion/duas/duas.dart';
import 'package:multi_task_app/pages/religion/rosary.dart';
import 'package:multi_task_app/pages/tools/document-reader/document-reader.dart';
import 'package:multi_task_app/pages/tools/calculator/calculator.dart';
import 'package:multi_task_app/pages/tools/timer/timer.dart';


class ContainerModel {
  final String text ;
  final String image;
  final Color color;
  final Widget navigate;
const  ContainerModel({
    required this.text,
    required this.image,
    required this.color,
    required this.navigate,
  });
}

List<ContainerModel> toolData =
const [
ContainerModel(text:'calculator', image:'images/toolsImages/calculator.png', color:Color(0xffcb8780), navigate:CalculatorPage()),
ContainerModel(text:'document reader', image:'images/toolsImages/document-reader.png', color:Color(0xffcb8780), navigate:DocumentReader()),
ContainerModel(text:'Timer', image:'images/toolsImages/stopwatch.png', color:Color(0xffcb8780), navigate:TimerPage()),
];

List <ContainerModel> healthData = const[
ContainerModel(text:'Mass calculation', image:'images/healthImages/weight.png', color:Color(0xffa36168) , navigate:MassCalculatePage()),
//ContainerModel(text:'Menstrual cycle', image:'images/healthImages/time-and-date.png', color:Color(0xffa36168) , navigate:TimerPage()),

];

List <ContainerModel> entertainmentData = const [
ContainerModel(text: 'Color collapse', image:'images/entertainmentImages/game-control.png', color: Color(0xff7a6c5b), navigate: ColorCollapsePage()),
ContainerModel(text: 'XO game', image:'images/entertainmentImages/game.png', color: Color(0xff7a6c5b), navigate: XOHomepage()),

];
List<ContainerModel> religionData = const [
ContainerModel(text:'Rosary', image:'images/religionImages/masbaha.png' , color:Color(0xffa96054), navigate:RosaryCounterPage() ),
ContainerModel(text:'Duas', image:'images/religionImages/prayer.png' , color:Color(0xffa96054), navigate:DuasPage() ),

];

List<ContainerModel> productivityData =  [
ContainerModel(text:'TODO', image:'images/productivityImages/checklist.png' , color:Color(0xff5c666c), navigate:ShowAddTaskPage() ),
ContainerModel(text:'Shopping list', image:'images/productivityImages/check-list.png' , color:Color(0xff5c666c), navigate:BagShapeScreen() ),
//ContainerModel(text:'thoughts', image:'images/productivityImages/thought-leadership.png' , color:Color(0xff5c666c), navigate:CalculatorPage() ),
//ContainerModel(text:'Gools tracker', image:'images/productivityImages/target.png' , color:Color(0xff5c666c), navigate:CalculatorPage() ),

];