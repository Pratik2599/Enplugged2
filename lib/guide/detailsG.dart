import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enplugged/menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class DetailsG extends StatefulWidget {
  DetailsG({Key key}) : super(key: key);

  @override
  _DetailsGState createState() => _DetailsGState();
}

class _DetailsGState extends State<DetailsG> {
  ProgressDialog progressDialog;
  static String name = "1",
      totalturnover = "1",
      companysuccess = "1",
      since = "1",
      successpercent = "1";
  static String emailfake = "asdsad@asd.asd";
  static String email = FirebaseAuth.instance.currentUser.email;
  static DocumentReference detailsI = FirebaseFirestore.instance
      .collection('guide')
      .doc(email)
      .collection('details')
      .doc(email);
  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: "Logging Out....");
    return Scaffold(
        body: StreamBuilder(
            stream: detailsI.snapshots(),
            builder: (context, profile) {
              if (!profile.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              name = profile.data["name"];
              totalturnover = profile.data["totalstartup"].toString();
              successpercent = profile.data["successpercentage"].toString();
              since = profile.data["experienceinyear"].toString();
              companysuccess = profile.data["successfulstartup"].toString();

              print(name);
              print(totalturnover);
              print(since);
              print(successpercent);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.blue[900], Colors.blue[200]])),
                        child: Container(
                          width: double.infinity,
                          height: 350.0,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    "https://media.beam.usnews.com/d1/d8/8501ba714a21aed9a7327e02ade1/180515-10thingselonmusk-editorial.jpg",
                                  ),
                                  radius: 50.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  name.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Card(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 5.0),
                                  clipBehavior: Clip.antiAlias,
                                  color: Colors.white,
                                  elevation: 5.0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 22.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Success",
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                companysuccess,
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.blue,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Profit Score",
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                successpercent,
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.blue,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Since",
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                since,
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.blue,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "About:",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 28.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "$name  is a Guide with Experience of Over :$since Years /- \n \n Success percentage of :$successpercent \n \n Total of $companysuccess Successfull Companies",
                              style: TextStyle(
                                fontSize: 22.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: 300.00,
                      child: RaisedButton(
                          onPressed: () async {
                            progressDialog.show();
                            try {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Menu()));
                            } catch (e) {
                              return e;
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          elevation: 0.0,
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [Colors.red[900], Colors.red]),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 300.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "LogOut",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              );
            }));
  }
}
