import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quizmajlis/singleResultPage.dart';

class CricketHome extends StatelessWidget {
  CricketHome({Key key}) : super(key: key);

  List teams = [
   ' Arts predators',
    'Science Villa',
    'Managment',
    'Spartans',
    'Team FoS B',
    'Arts Avengers',
    'Arts Transformers',
    'Team FoS A',
    'No Ball',
    'Technology',
    'Sidhdha Falcons',
    'E Titans',
    'Medicine Super kings',
  ];

  int numOfTeams = 13;
  Map<int,String> selectedTeams = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.network(
                  "https://thelivenagpur.com/wp-content/uploads/2019/04/cricket.jpg",
                  fit: BoxFit.fitWidth,
                )),
            Positioned(
              bottom: 100,
              right: 0,
              left: 0,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text(
                      'Start',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Random random = new Random();
                      List teamsCopy = List.from(teams);
                      selectedTeams = {};
                      for(int i=0;i<teams.length;i++){
                        int selectedTeamIndex = random.nextInt(teamsCopy.length);
                        selectedTeams[selectedTeams.length+1] = teamsCopy[selectedTeamIndex];
                        teamsCopy.removeAt(selectedTeamIndex);
                      }
                      print(selectedTeams);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  SingleResultPage(selectedTeams: selectedTeams,)),
                      );

                    },
                  ),
                ),
              ),
            ),
            Positioned(
                top: 20,
                left: 0,
                right: 0,
                child: Center(child: Text('MMPL Inter Faculty Cricket Fiesta 🏏',textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)))
          ],
        ),
      ),
    );
  }
}
