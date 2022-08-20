import 'dart:math';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data.dart';



class MainLess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainFull(),);
  }
}

class MainFull extends StatefulWidget {
  @override
  _MainFullState createState() => _MainFullState();
}

class _MainFullState extends State<MainFull> {
  @override
  void initState() {
    // TODO: implement initState
    competitorsList = Data.data;
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
  Future loadingWinner(var context1, int index) async {
    showDialog(
      //barrierDismissible: false,
        context: context1,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding:
            EdgeInsets.only(top: 10, bottom: 15, right: 10, left: 10),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // CircularProgressIndicator(),
//                //Icon(
//                  Icons.cloud_done,
//                  color: Colors.green,
//                  size: 30,
//                ),
                Image(
                  height: 100,
                  width: 100,
                  image: AssetImage('images/loading.gif'),),
                SizedBox(
                  height: 15,
                ),
                Container(
                  // margin: EdgeInsets.only(left: 5),
                    child: Text(
                      "Searching for a winner from ${competitorsList[index].length} Students",
                      style: TextStyle(fontSize: 20),
                    )),
              ],
            ),
          );
        });
    Future.delayed(new Duration(seconds: 3), () {
      Navigator.of(context,rootNavigator: true).pop();
      winnerAnnounce(context,index);
    });
  }
  Future showQ(var context1, int index) async {
    showDialog(
      //barrierDismissible: false,
        context: context1,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding:
            EdgeInsets.only(top: 10, bottom: 15, right: 10, left: 10),
            content: Stack(
              children: [
                ClipRRect(
                  child: Image(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height-100,
                      //fit: BoxFit.cover,
                      image: index<9 ? AssetImage('images/Quiz/0${index+1}.jpg')
                          :AssetImage('images/Quiz/${index+1}.jpg')),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25)),

                ),
                Positioned(
                    right: 10,
                    child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(CupertinoIcons.clear_circled),
                      color: Colors.red,
                    )
                )
              ],
            ),
          );
        });
  }
  Future showA(var context1, int index) async {
    showDialog(
      //barrierDismissible: false,
        context: context1,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding:
            EdgeInsets.only(top: 10, bottom: 15, right: 10, left: 10),
            content: Stack(
              children: [
                ClipRRect(
                  child: Image(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height-100,
                      //fit: BoxFit.cover,
                      image: index<9 ? AssetImage('images/Ans/0${index+1}.jpg')
                          :AssetImage('images/Ans/${index+1}.jpg')),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25)),

                ),
                Positioned(
                    right: 10,
                    child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(CupertinoIcons.clear_circled),
                      color: Colors.red,
                    )
                )
              ],
            ),
          );
        });
  }
  Future winnerAnnounce(var context1, int index) async {
    int numberOfCompetitors = competitorsList[index].length;
    int randomNum;
    try{
      randomNum = random.nextInt(numberOfCompetitors-1)+1;
    }
    catch(e){
      randomNum = 0;
    }
    winner.add([competitorsList[index][randomNum][0],competitorsList[index][randomNum][1],competitorsList[index][randomNum][2]]);

    showDialog(
      //barrierDismissible: false,
        context: context1,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding:
            EdgeInsets.only(top: 10, bottom: 15, right: 10, left: 10),
            content: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //CircularProgressIndicator(),
//                Icon(
//                  Icons.stars,
//                  color: Colors.green,
//                  size: 30,
//                ),
                      showAni(),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        // margin: EdgeInsets.only(left: 5),
                          child: Text(
                            "Congratulations",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          )),
                      Container(
                        // margin: EdgeInsets.only(left: 5),
                          child: Text(
                            "Winner is",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          )),
                      Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 5,),
                            Text('${competitorsList[index][randomNum][0]}',style: TextStyle(fontSize: 20),),
                            SizedBox(height: 5,),
                            Text('${competitorsList[index][randomNum][1]}',style: TextStyle(fontSize: 20),),
                            SizedBox(height: 5,),
                            Text('${competitorsList[index][randomNum][2]}',style: TextStyle(fontSize: 20),),
                          ],),
                        // margin: EdgeInsets.only(left: 5),
                        // child:   Text(
                        //   "Number $randomNum ${competitorsList[index][randomNum]}",
                        //   style: TextStyle(fontSize: 30),
                        // ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    //right: 1,
                    child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(CupertinoIcons.clear_circled),
                      color: Colors.red,
                    )
                )
              ],
            ),
          );
        });
  }
  Future askForCompetitors(var context1, int index) async {
    showDialog(
      //barrierDismissible: false,
        context: context1,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding:
            EdgeInsets.only(top: 10, bottom: 15, right: 0, left: 0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //CircularProgressIndicator(),
                SizedBox(
                  height: 15,
                ),
                Container(
                  // margin: EdgeInsets.only(left: 5),
                    child: Text(
                      "Number of Competitors",
                      style: TextStyle(fontSize: 20),
                    )),
                SizedBox(height: 10,),
                Container(
                  // margin: EdgeInsets.only(left: 5),
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (val){
                      setState(() {
                        competitors = int.parse(val);
                      });
                    },
                  ),
                ),
                SizedBox(height: 10,),
                RaisedButton(

                  onPressed: (){
                    Navigator.pop(context1);
                    loadingWinner(context1,index);
                  },
                  child: Text('Continue'),)
              ],
            ),
          );
        });
  }
  Future showCompetitors(var context1, int index) async {
    showDialog(
      //barrierDismissible: false,
        context: context1,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding:
            EdgeInsets.only(top: 10, bottom: 15, right: 0, left: 0),
            content: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      // margin: EdgeInsets.only(left: 5),
                        child: Text(
                          "Competitors List",
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        )),
                    SizedBox(height: 10),
                    Container(
                      height: 500,
                      width: 800,
                      child:  ListView.builder(
                        shrinkWrap: true,
                        //physics: NeverScrollableScrollPhysics(),
                        itemCount: competitorsList[index].length,
                        itemBuilder: (context, position) {

                          return Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        width: 250,
                                        child: Text('${position+1}) ${competitorsList[index][position][0]}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                                    Container(
                                        width: 250,
                                        child: Text('${competitorsList[index][position][1]}')),
                                    Container(
                                        width: 250,
                                        child: Text('${competitorsList[index][position][2]}')),

                                  ],
                                ),
                                SizedBox(height: 5,),
                              ],
                            ),
                          );
                        },
                      ),)
                  ],
                ),
                Positioned(
                  right: 1,
                    child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(CupertinoIcons.clear_circled),
                      color: Colors.red,
                    )
                )
              ],
            ),
          );
        });

  }



  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home:  Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Container(
                  margin: EdgeInsets.only(top: 20,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage:NetworkImage(
                            'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxESERUSExMVFRUTGBgaFhcYFhgdHhoYIBUXHRsfHhYeHyggHyAqHxcWITIhJSktLi4uFyAzODMuNygtLisBCgoKDg0OGxAQGy0lICYtLS8tNS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLf/AABEIAOEA4QMBIgACEQEDEQH/xAAcAAACAgMBAQAAAAAAAAAAAAAABgQFAQMHAgj/xABOEAACAQMCAwUFAwcKBAENAAABAgMABBESIQUTMQYiQVFhFCMycYEHQqEkM1JicpGSFTRDU3N0sbKztGOCwfCDFiU1ZJOipMLR0tPh4v/EABgBAAMBAQAAAAAAAAAAAAAAAAABAgME/8QAJBEAAgICAgICAwEBAAAAAAAAAAECESExA0ESUSKRBBNxYTL/2gAMAwEAAhEDEQA/AO40UUUAFFFFABRRRQAUUVgmgDNFLnEe1MQgnlgbm+zsEkKgtpOV1HSN20q2o464Iz1xH7M9r7S4laKO8Ezt3kUxsjAYGQMqAemdt9z5VPkifJXQ1ml60487389k0YQxRpIr6i2sNtnTgYwfU1NFzdG40CFBAOsrSd5jpyNMYB2ycEsR02FVfFeCzjiEV9BobEbQyozFcqTlSGCtuD4EUO+gbfRq4zLftbRtbSqJw7BgUXS5TmErg7rkx4Bz4/UY7OcfW9LMC8brEVlhLEGKQNg7bHfOx9PA5q4j4fJpXLKrCUyMACw3zlQcg+PxfhQeBxC4e5TuSSx8tyMd4ZBBI/SG4z5HfoKVO8Cad2hJ4fxK9k4B7Ws7m4XXIWwpyqykEacYxpB8PCnDht81wIXif3ZiV3yAc60BUZ8DuSfp51ngHZyO1tBZqzPGAw7+M4YkkHAAPxHwo4dwT2WyFtbkalQqrOTu2MamIB8fD0xQk0KKaKrgHaqa4SSTkqyLO8aaXIZ0V1XWEIxjvDI1eH0q9k47bLObdpFWUKG0nbuk4Bz06jH/AGKXOyXBXsI4YzbkyBCs06lSuNbOTjPMYknAGny8qU3uLhzPOUVP5Vna0VpVbMMYUrGTGf0u93TjfB3zS8mlkXk0lZ2EVmkmXiMlnNY2BlxG8RTnsuovKgUKhycDO58zsM1fJxtEEK3BWGSfIRS2xYeAJ8xuAfPHWqUkWpIuKKwDWaooKKKKACiiigAooooAKKKKACiiigAooooAKKK0XN1HHp1uq620rqIGWwTgZ6nAO3oaACe5VcAkamOFGRljgnAHicAn5AmqLs92kNxNcW0qcmaBvzZIOYiBpcN0IPp0yK1duuCRzwibmiCeAhoZy2kI2QACTtpYkD6jr0NTZ8Pm4h7Neb2t5bSNFMwGQyqSHXSfiB8M7DUetQ27M3J3gzewtbcUFxbI0kdy3Ju4k6rIFDLJj9lhk7DB/Wq/t+CMzxSTiItA7MhSPSxOl1Go5/RbJAGM+lWljYJEG0jvOdTsfidsAZY+eAB5AAAbVLpqI1ExiiqvjHaC2tdppUjJBYBjjIH4dcD1JAqstO2kBTM4NvJ3SIm7zuHXUhjVcl8jOyjIII8KfkirQzZqh4xxhY72zg1DMxlJGR0WPbb5n8KWOFwXF0zv7VPHLGzEqZFxETI5QckbEmMKCkp2643zWvhPAp7u3Mo5JWfvE3IaWaTGwzLGYxDjBwI86T41Lk3ohyb0dI1jzr1XKLe3tHgaeWTmSQa+ZE1w8skccbNGQGXEgj31lWVjnGc4q24V2xeOySPSZZkWOJZgweJpO6mqSQYMePiIkCnYjc0efsFP2dBxUXiHDYZ10SoHUEMM+DDoQRuCPAjcUucM7R3KyJBcQlmaZoeeAEVzhnUpGSWI0Lueg9abc1SaZSaYrcb7KmaIQ68xiYTZIJkDay7BHyAMkkZ8AxHliv7O2cl3fTX9wjIIS0NrE4wUA+JyD4t4HyJ6jFPNQuL8PE8LxF3TmKRqQ4YZGNj9aTj2Jw7FHgfHZWnuPZ1aaztzpLM7M8kxbL8pj4b/AA/D004Bp3gnVs4YHBIOD0I6g+tVNjb23DrRULLHFCm5O2cDLH5k5P1pZ+z9pTDcXSws0l5PJKpfKJoyBGCTvjA6hT1+lJOsCTawzoNFeUJxvsa9VZoFFFFABRRRQAUUUUAFFFFABRRWDQBF4rfLBC8zBiI1LEKCScDoAOppee7teL2LBcSDYvGdisikHSw6ruMZ9dq08d4nxNJysdtBLAwARHkKu5+93iNAJ6aT4Dx3xXcF4AbiVLnlz2FzE+mbce+ixkZYd1z0BbrsT1xUN5oycm3Rs4B2SOE0XbvZyBuZbPplTH3UDOCRg9ds5Xw8Hq3gVFCooVR0AGAPpWYYgoCqAANgBXsmqSotRSPMkgUEnYAZJ9KXv/LazKghpNTYMcZicPLnpy0YDWD5jYeOKgdvyWa3jVnJfmjlxytGT3NpGKkdxD1zkd/oTgVG4XaR6FLS4t1VE5rHS9xhVQaPFIjp6Lu5Y9B8Utu8EuTukR7q/d5Gup+WgCPCExrjUO65RiN7iYlQOXHhVOoaiesZ2W7MSWqzGZSntDMyoY4hKUaF8YaPKq5CR+QJyDk2vZ2PnX7yaA0MCvHCdOEhZZCgEQ6ElAdTAd0jSDuQHRIgMkAAnrt1+dJKxJWLKdhLTWTpzAWD+zYXlcwRhAxXGTsOhOMknGasb27FvLaQIFVZXZNIGMKsLsAoGw3UVZ3VykSM7nSqjJJ8BStxDh11dSLcKoj5IzbCRiGV+8GZkVSMMpVdJJIAOwJ2rWimq0XHF+zltc/nY99+8pKMQRhgWUgkEdQdjVRx3g00dyL6BI5DHGI2iKd9k1jXocMBq0bAMD8ONs1fcN4kJdSlWjkTGuNsZGehBGzKcHDDyPQggT6dJjcUzm91G/LHtVusEUjFo85MUfeOgSAHVbyYx7yM6QSSRnYzY+JX8HuV0ykjKiYnmIu2WUqMXKfLQw21dc00douFm5tpIAwTWBuRkbMDhlyMqcaSMjIJpP8A5WWOM2VzBrkiZgkUTkyEk6omgyFOnDEB8jRoIJ2zUNUQ1RZ9ne1up+RMxd+YESZIXSN9USyJnJYK2CRjJ+HwzThXM5pSXhuUYSaJMgkBBLIAy8udcDlXADsFYjSx2ODimePtpAxQLHOVLpHI+gBYZGYKqSamB1aiAQobGRnbenF+xxl0y9v7GOaNopVDo4wysMgio/Fb2OztpJmHcgjLYHkq9B4eGKsA1aL60SaN4nGVdSrD0IwaosUeD3vFDE15cvBDGFLi35ZyEAz3pdQ0tj0PqPCnC0uFkRXX4XUMPkQCP8aQ+2vD3K4vuIJHZru0aRlXlAI2J1HUfRR9BtiT2e7SXErNOYVgsFARA7Yk6gBynRV3AIPgQdwKhOnTM4yp0x5orCms1oahRRRQAUUUUAFFFFABVB2t4zNarG8Vu8+Xw4QjIXSTsD1JOMDx6eIq8kYAEk4xSLxReL65NU1qkTk6FkiYqF8AZlIw3qcb9DUyeCZPBdcG7T2V8hRHGro8Mg0uD5FD8uoz061d2Nty0C6mbH3mYkn5k1S9n+EklLi5jhN2itGZYtw6kruTgHPd6Hpv50w01fYRusga57xPjr3ksKJFdRoROyFJlTmMvdQlo3JQBg20gxuNj0ph4j2wtEDLHKk0wOhIY2BZ5M4CjHkep+6ASehpWKJGkkbtlA35a8Y/PTO7OLSFR4apSDjfD46liJkyZMjyHEcl1MzXKNhAxGDdFc6VAUd22XBZjgCQ62I04DMnD+yyyotw9w7XEgDG4hfA0kbJGpyvKA6DGfvZyc1AklubqaOERT2oUjPuh7mMROGKTlTGWZmVBpLEKpIwSadeH2UcESQxrpSNQqjfZQMDc0oqxRimY4bYJBEkUYwkahV3JOPUncnxJPXNSqKK0NRf7T3sSSWyynumUuRgtskblSQAdg5j389Nbx2mtP6w/wDs5P8A7aqftDgjkSBHUsebnCozsFEb5ICd7AJTJHiVzVRd8NtmWUy2zCUQx8kpbSEK/KDEjlpp1a+ufLB22qG3Zm20y+uOM273Vs0b94l0YlHHcZCQuSoG7rHgeYpnFc+tLSNeJxO0PL+JVPJKqM28RXDgBNRfm+uR6CuginEcXZmvHLGc4GfOvdFUWIPHsJxHdVSOZI0kVl7l3qfSwJOIw6LuAe+2rAyBitHFuFIY1DSv7PKE5NyGbKe8R40mOxK6lULIe8MlSQWyXbjHDFuIWiYsurBDLjKsrBlYZBGQQD08KUeNcGNnFzllknkdtDQuF5dwHY5jEKAIh3ZtYG25bIzWbRk41ZP7DjlvdQtlHEisISzNpQwxrqVmJ1KzrIcjxJzvmm0GudPbsBCFkdda5sLgMuoalybaRnVlORspYHoPvLk2PZrjYW6mt5LmWVcosTSoN5QGMqiVEWMgYUY65V6E6wOMqwNHEeGQz6ObGr8tw66gDhh47/WtMVlarI40x8yXEjg4LNggAkdSBhQPAYFWQpR7WcCLvz1uvZNYWOWQRqXKZ7qrL1TJI+Zx9aZTxmhjg4lC8zwK6mSMBmUEEgEkDI8On4iplJ3B4uEcPUFJI0ZiVMsjEvI/iC5+I5HwjxHSm9Tmmhxb7PVFFFMYUUUUAFFFYJoAh8Y4ctxC8LswWQaW0nBweoB8KTl4bxKzkWK3u0uY2K+5uR7xUJ0llcYLgZyfQVO45DeSXDy2V7CrQqEeCRcrn4suwOVJ1eA6YrbwCe8nmHtlskRthqR0fWsjOGXK/o4AYEE/eFQ8szdNjJZ26xoqIAFUAADoAPSofaS/a3tpJkUMUGcHOAMjJON8AZY48BUy9ukijeVzpSNSzHyUDJP7qV+M9ojLCYooriJpRgSSRFVSM/nJM+GlMkZxvgeNNvBTdIpbF7mNFt1ZWlkklW1ZQwVYmIaWUxnOVjyyoSe9qUeIJ2XdqBc2ttaBtVqxIJIxq1xG4eTPxEpLjIyxaQ/DpNRuHpqWMR+6fiAEcA6GDh8Y8Bt3mXfbfVKvgtOvBuzkFsxePWTp0jXI76UznSuonSCdzjyHlUJWZxVluK9UUVqbBRRRQBR9rLVWjR9wyywqGVmUhXnjVxqUg4I6j5eVVlxwxB7Zh5vdICn5RNseSW/T86ue035lf7e2/wBzFUObf+UP2cf/AAw/+tSyHs02fDoxdQ7yMOQZAGlkYawyDVpZiM4Y/vpnFUVmfymD1tG/zw1fU0UgrCsDWag3lkzd6N+XJ54yp9GTI1D6gjwIpjJ1QuK8OjuIzHIupSQfEEMDkEEbgg75FROGcaDyGCVeVcKMmMnIZemuNtta59ARncCrcUti2c6WKeGAwXsLG2Yoks3MBMbaVRZUC5IXUqyFjgqzsd+o8xXBiuYxcfFbyrzyNhJrTlW91jy6xt5NvnCinLtXMyWc7KgciNu6VLDBGCSo3YAEkgdQMUl3Nn+S81PygWI0ZO5urNoozMvkwwx0gZwYhk5zUNUZSVHRlmXOnUMjqMjP7qzKuR/318K5nbWSpdwi0tImSMm4SVBFE0kTRgKobA1AF21EeHLz1zXQOC8SW5iWVVZc6gVbGVZWKsDgkHBUjI2NUpWaRlYn8N4WTcScQ4i0cSxPILeIviOPDENJ3ttTEah889SMM3AO0lteGT2eQSCJgrEZwcjORnqOoz6Gq3j3Ym1uZnnkUNIyBU1klEOCC/LyATjT/COnWs215BBcQQ+0w6tJiESBQzsSGB0qcIBpO2DnWfrKtMhWmNVFFFaGoUUUUAFa55QqlmOAoJJ8gBk1squ49cvHA7xxGZxjEYx3+8ARvt0JoBiffcAnuyElmjexjYvogLF5yWLDmeHjvgnJ32J2auzFqscACI0cZYmONs5jXwXB6bgnHhqx4Uqz9qY3ysnDLyOcjCEQdW8NMy9N8b7AU92mrQur4sDV88DP41EabszjTdoo+01xKZYLZWSNLkShpGQPlgFxGFJAyymQ752jIpPXh8nLjtDIZDeOIVdhhxZQl2kzuevw9ejrnenDt2gaydfvs0axHxSVpFWNgRuCrMD9KWeMyNLeXJQn3awWMbZ3DzOrTsMfeCad/SlLYp7JfFIfaLpbeNQuZEYk/wBELZ0LMmCe+6yRKMYGnruNNPgqm4N2bgtnLpzCxUqDJI76VLaiBqJ6kAk9TgZO1XVVFFxVBRRWDVFGaKpuzPEeekxznl3NxH/BMwH4Yq5oBZKPtZdIkcYZsEzQEAAkkLPGzEAb4AGTVWeLw/lu7e8+D3cneHs6Lt3f0gR9Ks+1NtkRyKzI6yRRhlbB0STxK48iCMfUCoMVq5F3+UXHuXKp3x0EEb77b7sahkPZjh3E4jc2/eI/J2TvK69/VCQuWAGcK236pprFKlpaFp7YSSyyKYGm0s+3MVoQpwAOnMY4O2ceVNYqkOJmiiimUUvajgK3cQAYxzRnVDMuzRvjYg+R6EeIqs7F9qGnL2tyBHeW+0i+Dgba09DkH0yPAim3Fc2+1ThskLRcUt+7LAwWQjxQnAJHiMnSfRvSoljKM53H5I6PSJccPvLFpZoooZIU5r4LHUYml5sirGFwH+MfFg4TPSmfsxxuO9to7hPvjvL4qw2Zfof3jBr3x7iS28WsoZCzLGiLjLu7BVXJ2GSep2G9N01Y3TViRbT8i3u4oj3rIGW2bc6bWcasqv3ioEgA/UWn3g9nHDBHFF8CIoU5zkY6k+JPUnxzSHYWht5rBXKnmRT2UoVtQyvfiXVgZKhXXPnmrHsxxm5i9ms540JHuCVdi4aOANqZCgGkqF7yk7uvnUxdExdbGHtJwOO8iEchYKGDHSxUkbgjI8CDS5B2Tgs0laNLWM5BhZwdUeApyZ2JYjK6sADrj1p0uYQ6MjdHBU/IjBrnXHlW9uPYoY2S2jx7VMkTkyYP5pHCknf4mz5+W7klsc0t0dGt5g6q6nKsAQfMEZFbahcJ08oKsbRqndVGBBCrsNj4YAP1qbVo0CiiigAqm7T2928OLSQRyhgdRUN3RnI0nYk58auaoO1XCbi5VI4bhoFDEyFCVZ1wQFDAHTuc59KT0J6KTh78YMiq1zauqunOTlMkojLjUQucdM4O48s070pcB7JRWkqOlshck6p2neSQAqcnvIOuANiOtMvFLPnQyRFmTmoyalOGXUpGQfMZpRTRMU0hIM091ech7hhyZy7whY9AjjdXiOrSXYuN86gMo46jFQ+Fct7FLiWRofab2edZlZAUb32gkOCGXQhBHkc+G2/hdotrLIJIYopo7SXlmNNKOqY1vHjYZ1R6kYalIGCwO2jhsyrw6yttEkvMs2LQojNrDqunw0rhjnWzDGPHO0Gf9Hrszdyy2sMkwxI6At3SvyOg7rkYOnwzirSoPBY5Vt4VmIMqxoJCPFwo1H9+anVojZaConFLrlRPIBkqpwN92+6Nt8k4H1rXxjia28ZfSXbDFUXq2ASfkABufD54Bo7qMXAYNOkhXAZB+b1se4qk5XORjUyufIDpQ2DZt7OqIZeVlyHQd50C95MAgY2OQc797unJPgyilWSwzhQturKWxIiaSoVRqYaWDABtUZAOdwfPMy04yEl5EkivuFV9s6iisA4G24YYcYBJxgHGpISwSe0v5pP7xa/7mKo9oNr/APtW/wBrDW/tIfdR/wB4tv8Acx1qsOl56yv/AKEQ/wClAPZH4cff2n9yk/z2tMlLPCj76y/uMn+azplpoaMmofC79Z4hKuwYsBn0YqfxBrxxm+5MLuBlsEIo3LOQdKgAZJJqn7FHlI9swIKNqUMrqSrYLEBwCe+X9BkCi8heRnqJxWySeGSFxlZFZT8iMVLrBoGcW+yTir2t7JYyHaRmAHlMmQf3hT/CK6b22C+wXLMmvRE7qoJB1opZSGG4IYAgjcYrjHb0m04zLImxSSOZcePdRj+86hXfLe4WSNXGNLqGHyIz/gay43uJz8Lw4ejn3HCYrON8lxa3NrKJTvzNbDmuCBpwTI+w6YPpXvtPY6b9miaU3E8REIR9JV8oC2F25QC6nZ16hACdgKntVBbNDdy2cIWH2ZtciR6UeUTxMuk4AfbX3l22pxtbuNL+WSR0TVa22WYgb8yfxNHY1uhlgVgihjlgBqOMZONzjw3pT452lFgQJJ0k18wrHpJkLcwaUXR02bGSp+HrTdHIGAIIIPQg5B+tVlr2ctkuZLsRqZpSCXO5GEVcL5bKOnWtHfRq0+jdwK/eeFZHgkgLfck06vnsT+OD6VY1jFZpooKKKKYBWKzRQAVovLpIkaSRgqICzMegAG5Nb81TdrpIRZXHOJ5ZicNpPeI0n4f1umPXFJibpCn2m41DNMDGX3tL6PvxSpuyROuNajOeU3SvXATMkNhNByndrKOPlSFk1gBWOiQKV1bHunyzsMmrLhETyRSmWRDLJFomXTtzVjCty3JGUBfcAEBnbeoHYq5D8O4btlgzIpycoyxzpq0+OBkEH9LPWs1sx7sbuEcVW4SN1BAkQthuqkMFKn1ByD8qsTSX2IuQPZ4j8SwTo/rLFcqkp+r6j9aZOMX/ACkGGRSzKoLnYZO5O48M+NaJ4NU8EMyMebMo1OzcmLIJAAbSSR5a9THzCr5UX/C48RR6AzkqgkbcqqhmLZGMNscEdC+22aj2k6oukXsZ3Y9xAd2YsfvN4k1uM/8A63P9IE//AA0gPF9wW3iXWI9ge/h3GEZveHruCTqcH48EnJrfBYwiSSAxIFZcqQNyhCq656jBC9MAApjpWiSZCCrXj4IIIkjjAIPUEcsV7ikLOrJcW8rIGAHQ4OMjKuf0R93woAq73iMsmLYcnXbvE8jTTGPVonJGkBGzkRZJ2A1eO+Nlvc3KCUYsjzXZv54+2QBj8xv0rHEo8nRNEmv2m3cHIddLTIuASAf6M5BA6+NTeEcOgKTe6jPvpgO4vQMR5elInNlSl1Pb8qVxasttbtEwS6YswJhOVUxAE+62XO5brTTe8RCaUVS8j/Cg2OPEsTsqjxJ+QycAqlksUQsHESF2sm0AKAWkJs9O+PUknwGo1ZT8MmiDOLkK0jRl2YHLShgFRTvpjY4XSBkDPixNNDR40Sysr3EbOGfEUYJUBsHUxXbuhdXec5Pgi5AM5+FRiYCJWhcISki7puw1KUPd8Iz0BOdjsayDe6zJpQhgFEJf4cZw+sDfJY5A+6FxvkHCQX40gvEeX1Jz77boRj3eMncaskDwyKAJllftr5MwCyYJUjOmQDqVJ3yNsqdx6jerEUvTcNuZdpJlXviQaVy0RGdIRz1HgSy794dGwLPhV2ZEOsASISkgHQMPEfqkEMPRhTRSZxP7YwP5Tb+yiz8+9/8Aqui9lz7TwJEL6S1vJFr/AEcB0z9MZrl32pXPM4rceSctB9Ilz+JNdM+zK1EvBliYkCTnoSOoBkcbfvrnhmbOTjd8siq7RzrJwueU5VmsbfTFg+6DOw2+738DbGfd7+GGPivCY9UNxyodShA8kmnJULpEahgR3i2BuoBwcnoU/tdzgDZScpnYWUPMjDrqVp5CoZCxXIELnxxrO+9MEsV5cvcaQJIBNJGq80xkBQiOpJVgyFlPkykbHetEzXsuuwAAsYwNjql1p05chmdnjx4BGJUeiimOqns9w94Y25jBpZXaSQr8IZvBfQAKMnc4yetW1aLRtHQUUUUxhRRRQAUUV5c7UAL3a7jzwBILdRJdXBKwoeg/Sd/1FG/rUG07AwOOZes95Od2aRm0g+SRghVX6VV9j+NWk95cXktxEJZGMVvG0ihlgQ4GFJz32y37q6IDUL5ZM1Uss532l+z0JE78OeSGTG8QdikgyG094nScqDscHG9L3ZC+51tydUkSx8QUuFdo2EcyyKFJUgjEjDbzWuykVyvtvwo2t400YxHfIVPkt1GRLEf+Yx4+ZbzqJRp2iJw8X5IYOJwx2V3w0RjTEzTQHcneRdYJY7kl0GSdySal3l1hpZkjLLlQJQsRzgBSqhmBPe2GOpOBk1XfaRF7Xwjnx9UEVwhHltk59EZj9Kh9k+KwzGGUuwTrpaRyEI564wxIGMIB6Y86q6dD8qlQ02nEhhGe4UBlDaCgU4K5GcMcdanHjNv/AFqfvpD4Zc+7j3lIAUEC48tiMeB2IxtjpTracdt3X4wpGxViMjyzgn51SZaZqshLJAkvtLjWgfAWLG6527mcfWsQ8QgkhRpkJyisxMDkfCCT8GMVD4ktidGlYj7xS2EHTfOdulUUct5BEsPtEdyrtMZWKsCsRjAREGeobPgdqTdA3Rb8UghDwtEqAGWDdJf+KDgxDYjxB9fCrfgX5uX1nuP9Z6rOJ3NsEhKAZWWEnTGcgBxk7Ln51s4JxmFY3DFwTLOwHKl6NM5B+HxBB+tMXZG4DGrHhpIBK2LlT5HFoMj6Ej6mr3kl7nUwOiFRoyNjIwOph54XCg/rtSnw25XTYjmTRGK0ZHKxNkPi27p1Rkfdbwz3aidiuL3cyym9uLmIq4EfuFXUuOu8JzvSvNApdD1PK5nSNDhVGuQ46g5VV+pDE4/QHnWZLhluFQ7pIjY9HUg9fVWP8HrSI3F7v+UxD7Rc+x6MmXkr8WknGvk464HStXHOK3I4hbRwzzyQbc5+ShMeSQe9ye73cdRQ5h5j1xNdEsMw66uW/qj9P3PoPoC3nWq9nWCfmsQI5Y2Dn9eNS6n+AS/wDypR7b8ZuIYFNlc3Esxf4DCjHQFOo6RCDs2gZ/WHnVP9pHGQLOKP2maSWXBZGVFCjQQ52jVvEr18TSlOrJnyJWc34nemeaWY9ZXZ/lqYnH0Bx9K799mVvy+F2wPVlL/xOzD8CK+eoIGkdY1+J2Cr+0xAH4kV9IcauVsOHOy4At4dKerBdKD6tiseHbZz/j7cmc24/wATlk4jEYE50jXEkiJ4ERryYST4KGSZ/kabuG9gDo/Kbu5dmZ3ZYpWijDuxZtKrv1J3JrV9lvAtMQvZVxJKiJEDuUgUALv5sRqJ8cin6tYRvLOiELyxKueA3tkObZXEs6ru1tcNrDjxCSkalbHTJIzTH2e41HeQLNHkA5DKdmRxsysPAg1OuJ1RSzsqqOrMQAPmTSJwXitsnF3S3njkivULsI3VgtwnXp01Jv6larEWV/yzoFFFFWaBRRRQAV4lQMpUjIIwR5jxr3RQBSzdlbFk5ZtYNOMY5SjHywKX7YPwq5jgLs9jcsEiLkk28p6JqPWNvDPQ/i9VUdq+Di7tJYOhde436LjdD9GAqWu0RKPa2Wuapu0nDo763mttQ1YGCCMo43Q+Y3FVXCmbidjCzTTQsMrcLEwVjIoKupbGpRkZ2I61QdmynDbsRTGCLVGIm5bF2mk5o0TSgL7vYkEsdzJjoBSb+hOV/wAZcfZpOZuHG2mHft2kt5VPkCcD+FsfSlTsLxVuF38vDZziJ5MRsTsGONB+TrpHzA9aa+LH+T79bsbW16ViuPJJekUhHgD8BNVn2vdl+fELyJcyQjEgHVoupPqV3PyJ9Kzkmla2jKSaVraHbs7+ZP8Aaz/7iSjh5/KLn9qP/SWue/Zd25TQtncNpYE8qQnZ8knDMfvZJ38fn16Fw7+cXP7Uf+ktaRkpK0awmppNFnWaKi3VwUZOmlmIbJxgaGOR/Dv6b1ZoQuL8TlVxDBFzJWXV3mCoi5xqdtz1BwFBJx4daqeIcFkkVRc3TvJKdKIjNDGp0knCK2pyFVjhmOceFbuLwC4kjmtWxcQghJdBMZU7sjt95SQPgyQd/OosvExcNbrLGYpre5Tmxk50loZwrK42ZGPRh1wQQCCKjshv2NTe7j7oLaV2GdzgdMnx+dRL7iyRRxyEHTK8SDbccxgFJHzIz5VDN08lw8Wsorwkxppw4KvhpM+A76AAkHunbrVNc8VBgt4xzGLG1mDvjODfQqysB0ZRJjbam2DY61W2P85uP/C/yVZVRycRit5LqWZwiLyiWP7Hl1J9BvTZTNfH+JRW1wk8raUjt7gk/wDiWuAB4k9APWuB9pONyXty9xJtqPdX9BB8K/QdfMkmrPt52ubiEwIGiGLIjU9TkjLN6nSNvDFLltbvI6xopZ3IVVHUknAFcnLPydI4Obk83S0Ov2RcDM96JmHcthq+chyEH03b/lFdB7ZKL65g4Yu6ZE90R4RKe6vzZv8ADNSOEWkPBuGkyHJQa5COrynACjz30oPQCvfZSzNrby3t4Qs1xma4Y/0agd1M+SL+JNbQjUa+zo44eMfH7GeJlHdGO6BsPAeG3hXi/u0hjeWQ6UjUsx8gBk1zfjMvNuoZp4ZbHIb8shLHmA4EKswXKjvElZVGCMbgmrbtTHJL7JwtpTK07a7h9IXMEZ1NkLsNTaF/fV+Rp5hwfgp4kRe36kxt3ra1b4ET7rOvRnI332Gf3NMXArVWVlt4VaM5RhGoKnBGxA22JH1qfGgAAAwB0r3TUaKUUgoooqigooooAKKKKACsGs0UAJVqPY+KSQnaDiIMke+wuFGJAPLUpVvmKpP5LsrImK6kSIkzRncu95bvgqSgJcyK2ka8E5U4+KnLtlwVrq3KxnTNEwkgf9GVd1+h6H0NQIbkcT4azKiCZ0ZCr5HLnXqCR3hpcAjx2BrOujJrNfRt4bd2vEbea1xKyRhYpOcjKxOgEHcA6uh6Ag4OOlR+yPEZI3bht0czQD3Tn+ng+6w82A7rD0qBwaO8RZYLNoljtGIkkmRpHubjSHkJCsukEt13PlsKsr6yXiVtDKpNvdRqksZ+/C7LkKy9dJ3BUjcUWCb32c5+0vsKbVmuYFzbscuo/oiT/kP4dOmK19iftFktGKXAaaNtOWzl1wAo6/EMAdd/Wun9ne0HPLWt0giuoxiSI/C6/px5+JD+HQ0j9tvsvZS01iMruWg8R/Zny/VP0PhWUoNfKBhKDi/PjOl8D7Q2t2uqCVX8xnDL+0h3H1FaO0HFIIHRp3CKodlGTl3wFCqo3c4Y9zckkbV83K0kT7F45EONtSsp8vAg0zcO+0TiMWAZEmAwQJkDY/5gVb65prn9jj+T1JHU7jgkt3pmukmIdgEgjmMYt4yD320sNcnQnc4zhRsSZ9v2ZZAM3E0z8yM65SpKohYhRpUDxOT1OdzsKQLb7ZJgBzLSNvMrIy/gQf8AGpD/AGzHG1nv6zf/AMVX7IF/t4/Y1mG/ikE626Suy8opzgoRV0aG1EfCSJCRjPeXyNRbfs/dgrFKIjFCxZZg5DEPKkjIY8YAVhkHPREHnSXffa9ettHFBH6kM5+hyB+FKfF+097dbTXEjKfu5Cr/AArgH61L5YkS54LR2XtP9pFna5WNvaJR92M90H9aToPkMn0rjHaLtBPeymWZup2RdlXAwMDzxtk71VVL4Xwya5kEUEbSOfADoPMnoB6mspckp4MJ8suTBEAzsNydgB4n5V2r7MuxHsqi7uVxOwOhT/RKfP8AXI6+Q286kdhvs8is8T3BEk4G36Ef7Oep/WP0xWziF9JxWRrW1YraKcXNwv8ASY6xRHxz4t0x+OkOPxy9m3FxeGXs9Wv/AJ1vBN1sbN/deU846v6oh6eZqd2770aLJFLLaas3HJOWwp2BjA1MmdzoOe6NiCa3cS4vFZci0hWNSVyAzaEjgT845b0GcDqSd9smlGy4IxvgsE00EVyHuY5kaQMynGqMxvlMhm1amXOlgPUaP0bvGBq7MQlRrivFubIoSmvDOhGNud4qBnIfLDHWo/YhDczXHEmG055Vvnwt0OAR+2wLfQVo7TghIuF27e9u886QBQVhH52VgoADN06DJJpxsbRIo0iQaUjUKoHgAMD/AAqksjSySMUUUVZoFFFFABRRRQAUUUUAFFFFAGDSTxjPDbv21R+S3JC3Sj+jk6JNjyPwt88071purZZEZHUMrghlIyCCMEEUmrJkrF/jfCQuu9tY9d0FygErqkhK6QWUHS5Ck4yN8AZHUUHY7gjNJ7Ss2tmbU9wBpkZsgS288B22x3Tto222y0zhl0/CpVtJ2LWcjYtZyc8snpDIfAeCt9Pk33M8cSPIRhVBZsDJO3kNyalJPJKSbsr+0PZ2G7VdeUkjOYpkOHjbzVv+nQ1SRcfu7HucQTmRDYXkKkjH/FiGSh9RkVzO07WXpuo4y11JDHPzBDpPNMYfKqfvHYDYnFdvveLwx25uZNSxhdRyjBsHw0EZzk4xjOamMlLKJjJTtrBU8S4Hw7isYkOiTI7ssbDUPTWP8D+6kDjP2QzqSbadJB4LINDfxDIP7hT1d9j7GSQyQlrWfGS1u/LbfxaMbH6ivH8ncZh/NXcFyvgLiIo2P7SPr+6iUFLaFKCltfRxu+7GcRhzqtZSB4oNY/8AczVVJw6ddmhlHzjcf9K71/LPF0+PhscnrFdL/g6isjtPf+PCbj6SwH/5qy/VH2Yv8ePt/RwiHhNy/wANvM3yic/9Ku+HfZ/xOY7W5jH6UpCD93xfhXXD2m4gfh4TN/zTwj/qa8niHG5Pgs7aD1luC+PpGtC4ojXBH2xY4H9kCghrufV/w4hgfWQ7n6AU3XHEuG8KjES6IyfhhjGqRz+wO8SfM/vqMeznEJ/51xBkU9Y7VOX9Oacv/hXuG14bwxgscWZ5ASAqmWeTfc53bGfEkLWqSWkaxio6VEZuH3vEz+Ug2lp/UK3vZR/xHGyL+qN/Om+ytY4UWONVREGFVRgAfKtkMmpQ2CMgHBxkehwcZrif2kcXuheyGD2qCOULETh0WVhkZUfLAyNyF8jTk1BWVKSgvLZ1ntFwCC9h5co6HUjjGpGHRlPn6dD0NeLziIsbPm3UgcxJ3mVdPMbwCpk4JOBjNQuy/FOVw5GuYmtRbxhX5mBsqgah6HyIBztioHCLSTiU63s6FLaI5tIW6sf6518/0R4daf8ANjv1sndi+EyjmXtyMXN1gsv9VGPgjHy6nzPypprAFZqkqLSpBRRRTGFFFFABRRRQAUUUUAFFFFABRRRQBF4jw+KeJopUDo4wynof+/PwpPSe54T3ZOZc2I+GQd6W3Gejjq6D9IbgU9V5K1LRLjeUU1hbWk8y38JR2aPliRSCCmrVj5/jWntXwJ7zkxFykKya5dJIdtIOgKQNhqwSeuwxUS/7GhZDPYytaStuwUBopD+vCdvquDWgdpL622vbJmUf01qDIvzMXxr+NL/GS9U0Kk9jLHZQwwxmK7Zp5JnIIkdbcsQWk+Jg7cnx3DVe8N7WXNw45Ggi7kYW/MB0xxRRIJXIGGYmQsAM+VXvD+2XDZ9luYgx20SMEb1Gh8Gvdx2dtZI4lgYwcgsYXt2UFNWdQGQVIOTkEEVKXpkqPpkC07XOsvIuI1DrM0Mjox0D8n5ysAd91yCM7EeNeIPtBhaBZuTMC3PPL7uoLFHrZjkjYgpj1kWvfE+wsclr7OssgZphLLM3eeRiul8kaQCUyu2AB4ViTsX768lDgLcwtHEmk4jLRqsh+vLi6fo0/kP5lpx3tCLe2juAmsSNGoBZVxzOhZjsBkjJ9appu1Nw/IWL2UGedoS6ymdUPJMi50ae8dLDGfLettx2dvJrT2WaW3woi5bJC+zRuhywaQhgQpGBjrUqTsw8sXLmn6SRyIYYki0Mhz3fi69N/Cnlj+QvcS41JI6Q3jcqKG5aG6eJnjRiYVeAlwdSI2sZ36gAnFV0NlJdKRBGX9jlCqYruUiWGU+9iF2xUnSQpwDgYxT9a2VnaRurOoEjFpXmkBLsQBlmc77ADHQACq6ftzw6PuRSc5h0jtkMp+mgYH76lr2xNe2WnZu0mii0SpDGB+bji1EIvkXPxHOTnAqL2w4jZQohusMyurwxganaRT3dCDcnw8t96rje8WvNooVsYj/STYeXH6sI7qn9o1Z8B7JwWzGU65rhvinlOpz8j0Uei4qrvQ7bwiqs+CXF/ItxxBdEKnVDZ5yAfB5j95vHT0FOijFAFZqkqLUaCiiimMKKKKACiiigAooooAKKKKACiiigAooooAKKKKACvLV6qm7WXbx2shjOJH0xofJ5HVFP0LZ+lJiZT8VVb93igt7eRUYrJcTxh0DA4ZUQYMjDoTqCg7ZJBFVEn2d8Ot8vLzGLHwkWFM+SqunHyGTTV/KdjYpHbNNHHy0AVS24UDGSOvrk9c1Cm7T8PXvpd27SEHLFtbY9EXfH6owKhpPZDjHbKSy7M2Ukmg29wiaSeZz7oLt5lgF/E9KlnsBaPpeEsY2AOTcTnUD00kOABjfO9a4Z57+JtJka1kPedwENwP6uKMfm4T96RiSRnHnWH45Nbl4iSyqoMkoxi1Q5CyFCDnLFm0Z7scanbxVL0TUfR54n2VsIl1RxXFwwfQyJc3B0nTk6tBYjAx4feFaIOyfD5/dlJ43Pgt1ISP8AkkIb66asVsrpGa4hyzyA82PXjmr4aJOgljyQrHZ005O2R74d2stHXlz3Cd06WW4TlSKw8Gz3Cw81xRSCo+irXsHFZnX7NHexDch19+o3yRvok/Z0qfUnanjgvs7RK9uqCNxldCgDHyA6+GPDFV8Havh4wgvIm3wDrB+QL9P3mvPB15V7cQr+blRLhB4B2LJLjwAJSNvm7HxqkktFRSWhjoooqzQKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKXu2f5iP+82v+5joopPRMtFR2J/nPEv70/wDlFb+0P8zvP7CX/IaKKxZkMPCfzEX9mn+UUu8E+Hif94m/0UrFFW9I0l0WPYX/ANG2X92h/wBJKr7L+d3/AO3B/oCiilLSIlpE/i/8wn/s3/yGqXsH1s/7gP8AVFFFC2C2PtFFFamwUUUUAFFFFABRRRQAUUUUAFFFFAH/2Q=='),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          Text('Muslim Majlis',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                          Text('University of Jaffna',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          Text('Kilinochchi Premises',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                        ],
                      )
                    ],),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('images/8.png',height: 90,),
              ),
              Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image(
                  //   height: 40,
                  //   width: 40,
                  //   image: NetworkImage(
                  //       'data:image/jpeg;base64,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'),),
                  SizedBox(width: 10,),
                  Image.asset('images/9.png',height: 30,),
                  //Text('முஷாபகதுர் ரமழான்',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                ],
              )),
              SizedBox(height: 10,),
              Container(
                //height: 400,
                margin: EdgeInsets.only(top: 20),
                child: GridView.count(
                  shrinkWrap: true,
                  //scrollDirection: Axis.vertical,
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 3,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(29, (index) {
                    return Container(
                      color: Colors.white,
                      //height: 400,
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            color: Colors.white,
                            elevation: 20,
                            child: Container(
                                alignment: Alignment.center,
                                height: 200,
                                width: 200,
                                child: Column(
                                  children: [
                                    // ClipRRect(
                                    //   child: Image(
                                    //       width: 200,
                                    //       height:150,
                                    //       fit: BoxFit.cover,
                                    //       image: index<9 ? AssetImage('images/Quiz/0${index+1}.jpg')
                                    //           :AssetImage('images/Quiz/${index+1}.jpg')),
                                    //   borderRadius: BorderRadius.only(topLeft: Radius.circular(25)),
                                    //
                                    // ),
                                    //SizedBox(height: 10,),

                                    Container(
                                      height: 50,
                                      width: 200,
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(25)),
                                        color: Color.fromRGBO(0, 0, 50, 1),
                                      ),

                                      child: Center(
                                        child: Text(
                                          'வினா இலக்கம்: ${index+1}',
                                          style: TextStyle(
                                            backgroundColor: Color.fromRGBO(0, 0, 50, 1),
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    //SizedBox(height: 10,),
                                  ],
                                )
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CupertinoButton(
                                color: CupertinoColors.activeBlue,
                                child: Container(
                                    child: Text('Question',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                                onPressed: (){
                                  //showCompetitors(context, index);
                                  showQ(context,index);
                                  // askForCompetitors(context,index);


                                },
                              ),
                              SizedBox(width: 10,),
                              CupertinoButton(
                                color: CupertinoColors.activeBlue,
                                child: Container(
                                    child: Text('Answer',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                                onPressed: (){
                                  //showCompetitors(context, index);
                                  showA(context,index);
                                  // askForCompetitors(context,index);


                                },
                              ),
                            ],
                          ),
                          SizedBox(height:10,),
                          CupertinoButton(
                            child: Text('Show Competitor List - ${competitorsList[index].length}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                            onPressed: (){
                              showCompetitors(context, index);
                              // askForCompetitors(context,index);
                            },
                            color: CupertinoColors.activeBlue,
                          ),
                          SizedBox(height: 5,),
                          CupertinoButton(

                            child: Container(
                                child: Text('Find the winner',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                            onPressed: (){
                              //showCompetitors(context, index);
                              loadingWinner(context,index);
                              // askForCompetitors(context,index);


                            },
                            color: CupertinoColors.activeBlue,
                          ),

                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}