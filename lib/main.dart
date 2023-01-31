import 'dart:math';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmajlis/data.dart';
import 'package:quizmajlis/page.dart';
import 'dart:collection';

void main() {

  runApp(Main());}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainFull1(),);
  }
}

class MainFull1 extends StatefulWidget {
  @override
  _MainFull1State createState() => _MainFull1State();
}

class _MainFull1State extends State<MainFull1> {
  @override
  void initState() {
    // TODO: implement initState
    readFile();
    WinnerImage = Image(
        height: 100,
        width: 100,
        image: AssetImage('images/winner.gif'),
    );
        super.initState();
  }
  var random = new Random();
  int competitors=3;
  Image WinnerImage ;
  List<bool> changeState=[];
  List<dynamic> winnerNumber = [];
  List<List<dynamic>> data = [];
  int startIndex = 4;
  List<List<List<dynamic>>> competitorsList = [];
  List<List<dynamic>> winner = [];
  int dayNumber=0;
  List<List<dynamic>> tempList=[];
  Widget showAni(){
    return WinnerImage;
  }

  readFile() async{


      var temp=0;
      await rootBundle.loadString('images/data.csv').then((value) {
        List listData = CsvToListConverter().convert(value,eol: '\n');
        data = listData;
        for(int i=0;i<30;i++) {
          competitorsList.add([]);
          winner.add([]);
        }
        print(competitorsList.length);
        listData.forEach((element) {
          for(int i=4;i<34;i++) {
            //print(element[i]);
            if(element[i]==1) {
              competitorsList[i-4].add([element[0],element[1],element[2]]);
            }
          }
        });
        competitorsList.forEach((element) {print(element.length);});

        Data.data = competitorsList;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainLess()),
        );
      });
      //print(myData);

      //print(competitorsList[1].length);
      //print(listData[0][startIndex+0]);
      // for(int i=0;i<listData.length;i++){
      //   //print(listData[i].length);
      //   try{if(listData[i][0]!='null') tempList.add(listData[i]);
      //   else {
      //     temp++;
      //     if(temp==2){
      //       competitorsList.add(tempList);
      //       tempList = [];
      //       temp=0;
      //     }
      //   }}
      //   catch(e){
      //     print('loop error');
      //   }
      //   //print(tempList);
      // }
      //competitorsList.add(tempList);
      //print('List is $competitorsList');


  }


 
 
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home:  Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CupertinoActivityIndicator(radius: 50,)),
      ),
    );
  }
}