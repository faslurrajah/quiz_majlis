import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleResultPage extends StatefulWidget {
  final Map<int,String> selectedTeams;
   SingleResultPage({Key key,this.selectedTeams}) : super(key: key);

  @override
  _SingleResultPageState createState() => _SingleResultPageState();
}

class _SingleResultPageState extends State<SingleResultPage> {
  int currentIndex = 1;
  bool loaded = false;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4)).then((value) {
      setState(() {
        loaded = true;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return loaded ? Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.network('https://www.pngitem.com/pimgs/m/152-1520406_png-cricket-team-cartoon-3d-transparent-png.png'
              ,fit: BoxFit.fill,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Team Number $currentIndex: '+widget.selectedTeams[currentIndex],
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            currentIndex < widget.selectedTeams.length ? Positioned(
              right: 20,
              bottom: 0,
              top: 0,
              child: Center(
                child: CircleAvatar(
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: (){
                      setState(() {
                        currentIndex++;
                      });
                    },
                  ),
                ),
              ),
            ):SizedBox(),
            currentIndex>1 ? Positioned(
              left: 20,
              bottom: 0,
              top: 0,
              child: Center(
                child: CircleAvatar(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: (){
                      setState(() {
                        currentIndex--;
                      });
                    },
                  ),
                ),
              ),
            ):SizedBox(),
          ],
        )
    ):Center(child: CupertinoActivityIndicator(radius: 50,));
  }
}
