import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:expansion_tile_card/expansion_tile_card.dart';

class DashboardPage extends StatelessWidget {
  //AuthService authService = AuthService();

  @override

  //final GlobalKey<ExpansiSonTileCardState> cardA = new GlobalKey();
  //final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  String username = 'a', med = 'a', agee = 'a', email = 'a';
  int age = 0;

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc((firebaseUser.uid))
          .get()
          .then((ds) {
        username = ds.data()!['username'] ?? [];
        // print(username);
        age = ds.data()!['age'] ?? [];
        med = ds.data()!['medical condition'] ?? [];
        email = ds.data()!['email'] ?? [];
        agee = age.toString();
        //print(username);
      }).catchError((e) {
        print(e);
      });
      return (username);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 5, color: Colors.white),
                      color: Colors.white,
                      boxShadow: [
                        const BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20,
                            offset: Offset(5, 5))
                      ]),
                  child: const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: FutureBuilder(
                  future: _fetch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Text("Loading data...Please wait");
                    return Text(username);
                  },
                )),

                /*Text(
                     "username",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),*/
                Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  ...ListTile.divideTiles(
                                    color: Colors.blue,
                                    tiles: [
                                      ListTile(
                                          leading: Icon(Icons.date_range),
                                          title: Text("Date of Birth"),
                                          subtitle: FutureBuilder(
                                            future: _fetch(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState !=
                                                  ConnectionState.done)
                                                return Text(
                                                    "Loading data...Please wait");
                                              return Text(agee);
                                            },
                                          )
                                          //subtitle: Text(age),
                                          ),
                                      ListTile(
                                        leading:
                                            Icon(Icons.medical_information),
                                        title: Text("Medical Condition"),
                                        subtitle: FutureBuilder(
                                          future: _fetch(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState !=
                                                ConnectionState.done)
                                              return Text(
                                                  "Loading data...Please wait");
                                            return Text(med);
                                          },
                                        ),
                                        //subtitle: Text(med),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.email),
                                        title: Text("Email"),
                                        subtitle: FutureBuilder(
                                          future: _fetch(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState !=
                                                ConnectionState.done)
                                              return Text(
                                                  "Loading data...Please wait");
                                            return Text(email);
                                          },
                                        ),
                                      ),
                                      const ListTile(
                                        leading: Icon(Icons.phone),
                                        title: Text("Phone"),
                                        subtitle: Text("99--99876-56"),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ]))
        ],
      ),
    ));
  }
}
