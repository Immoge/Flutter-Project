import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mytutor/views/profilescreen.dart';
import 'package:mytutor/views/subscribescreen.dart';
import '../constants.dart';
import '../models/user.dart';
import '../models/tutor.dart';
import 'coursescreen.dart';
import 'favouritescreen.dart';
import 'package:intl/intl.dart';

class TutorScreen extends StatefulWidget {
  final User user;
  const TutorScreen({Key? key, required this.user}) : super(key: key);
  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen> {
  List<Tutor> tutorList = <Tutor>[];
  String titlecenter = "Loading...";
  late double screenHeight, screenWidth, resWidth;
  final df = DateFormat('dd/MM/yyyy hh:mm a');
  var _tapPosition;
  var numofpage, curpage = 1;
  var color;

  @override
  void initState() {
    super.initState();
    _loadTutors(1);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutors'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                radius: 50.0,
                backgroundColor: const Color(0xFF778899),
                backgroundImage: NetworkImage(
                    "https://cdn.mos.cms.futurecdn.net/JMKgHniH4JYPch6ig2o2MM-970-80.jpg.webp"),
              ),
              accountName: Text(widget.user.name.toString()),
              accountEmail: Text(widget.user.email.toString()),
            ),
            _createDrawerItem(
              icon: Icons.library_books,
              text: 'Courses',
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) =>  CourseScreen(user: widget.user)))
              },
            ),
            _createDrawerItem(
              icon: Icons.school,
              text: 'Tutors',
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => TutorScreen(user: widget.user)))
              },
            ),
            _createDrawerItem(
              icon: Icons.control_point,
              text: 'Subscibe',
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => const SubscribeScreen()))
              },
            ),
            _createDrawerItem(
              icon: Icons.bookmark,
              text: 'Favourite',
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => const FavouriteScreen()))
              },
            ),
            _createDrawerItem(
              icon: Icons.person,
              text: 'Profile',
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => const ProfileScreen()))
              },
            ),
          ],
        ),
      ),
      body: tutorList.isEmpty
          ? Center(
              child: Text(titlecenter,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)))
          : Column(children: [
              Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 1.5),
                      children: List.generate(tutorList.length, (index) {
                        return InkWell(
                          splashColor: Colors.cyan,
                          onTap: () => {_loadTutorDetails(index)},
                          onTapDown: _storePosition,
                          child: Card(
                             elevation: 5,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(10),),
                              child: Column(
                            children: [
                              Flexible(
                                flex: 8,
                                child: CachedNetworkImage(
                                  imageUrl: CONSTANTS.server +
                                      "/mytutor/mobile/assets/tutors/" +
                                      tutorList[index].tutorId.toString() +
                                      '.jpg',
                                  fit: BoxFit.cover,
                                  width: resWidth,
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Flexible(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Text(
                                        tutorList[index].tutorName.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Email: " +
                                            tutorList[index]
                                                .tutorEmail
                                                .toString(),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ))
                            ],
                          )),
                        );
                      }))),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: numofpage,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if ((curpage - 1) == index) {
                      color = Colors.cyan;
                    } else {
                      color = Colors.black;
                    }
                    return SizedBox(
                      width: 40,
                      child: TextButton(
                          onPressed: () => {_loadTutors(index + 1)},
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(color: color),
                          )),
                    );
                  },
                ),
              ),
            ]),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  void _loadTutors(int pageno) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/load_tutor.php"),
        body: {'pageno': pageno.toString()}).then((response) {
      var jsondata = jsonDecode(response.body);

      print(jsondata);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numofpage = int.parse(jsondata['numofpage']);

        if (extractdata['tutors'] != null) {
          tutorList = <Tutor>[];
          extractdata['tutors'].forEach((v) {
            tutorList.add(Tutor.fromJson(v));
          });
        } else {
          titlecenter = "No Tutor Available";
        }
        setState(() {});
      }
    });
  }

  _loadTutorDetails(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Tutor Details",
              style: TextStyle(),
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: CONSTANTS.server +
                      "/mytutor/mobile/assets/tutors/" +
                      tutorList[index].tutorId.toString() +
                      '.jpg',
                  fit: BoxFit.cover,
                  width: resWidth,
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(
                  tutorList[index].tutorName.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text("Description:",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(tutorList[index].tutorDesc.toString()),
                  const Text("Email: ",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(tutorList[index].tutorEmail.toString()),
                  const Text("Resgistration Date: ",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(df.format(DateTime.parse(
                      tutorList[index].tutorDatereg.toString()))),
                   const Text("Course Teaching: ",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(tutorList[index].tutorCourse.toString()),
                ])
              ],
            )),
            actions: [
              TextButton(
                child: const Text(
                  "Close",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }
}
