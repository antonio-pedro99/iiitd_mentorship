import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/data/model/mentor.dart';
import 'package:iiitd_mentorship/app/data/model/user.dart';
import 'package:iiitd_mentorship/app/views/screens/profile/user_profile.dart';
import 'package:iiitd_mentorship/app/views/widgets/mentor_tile.dart';
import 'package:iiitd_mentorship/app/views/widgets/session_action.dart';
import 'package:iiitd_mentorship/app/views/widgets/topic_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Mentor> mentors = Mentor.getMentors();

  final currentUser = FirebaseAuth.instance.currentUser;

  getFirebaseCurrentUser() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.uid)
        .snapshots();
  }

  // get firebae users who are mentors

  getFirebaseMentors() {
    return FirebaseFirestore.instance
        .collection("users")
        .where("isMentor", isEqualTo: true)

        //    .where("uid", isNotEqualTo: currentUser!.uid)
        .snapshots();
  }

  // get all upcoming sessions

  getFirebaseSessions() {
    return FirebaseFirestore.instance.collection("meetings").get().asStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: getFirebaseCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Handle the snapshot data here
            final userData =
                DBUser.fromJson(snapshot.data!.data() as Map<String, dynamic>);
            // Rest of your code
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  floating: true,
                  snap: true,
                  title: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Find IIITD Mentors around the world",
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                  toolbarHeight: kToolbarHeight + 10,
                  actions: [
                    IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, "/home/schedule"),
                        icon: const Icon(
                          Icons.event,
                          color: Colors.grey,
                        )),
                  ],
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      !userData.adminApproval!
                          ? Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.yellow[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.warning_amber_rounded,
                                    color: Colors.yellow,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Your account is not approved yet. Please wait for admin approval.",
                                      style: TextStyle(
                                          color: Colors.yellow[900],
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Quick shortcuts",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 10,
                      ),
                      SessionActionButton(
                        action: "My sessions",
                        onPressed: () =>
                            Navigator.pushNamed(context, "/home/schedule"),
                      ),
                      !userData.isMentor!
                          ? SessionActionButton(
                              action: "Find a mentor",
                              onPressed: () =>
                                  Navigator.pushNamed(context, "/search"),
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              userData.isMentor!
                                  ? "Others Mentors"
                                  : "Recommended Mentors",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                          TextButton(
                            onPressed: null,
                            child: Text("See All",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor)),
                          )
                        ],
                      ),
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: getFirebaseMentors(),
                          builder: (context, mentorsSnapshot) {
                            if (mentorsSnapshot.hasData) {
                              final mentorsData = mentorsSnapshot.data!;
                              final List<DBUser> mentorsList = mentorsData.docs
                                  .map<DBUser>((e) {
                                    return DBUser.fromJson(e.data());
                                  })
                                  .toList()
                                  .where((element) {
                                    return element.uid != currentUser!.uid && element.adminApproval!;
                                  })
                                  .toList();

                              return SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: mentorsList.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: InkResponse(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserProfileScreen(
                                                          user: mentorsList[
                                                              index])),
                                            );
                                          },
                                          child: MentorTile(
                                            mentor: mentorsList[index],
                                          ),
                                        ));
                                  },
                                ),
                              );
                            } else if (mentorsSnapshot.hasError) {
                              // Handle the error here
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else {
                              // Show a loading indicator while waiting for data
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              userData.isMentor!
                                  ? "Upcoming sessions"
                                  : "Topics of Interest",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                          TextButton(
                            onPressed: null,
                            child: Text("See All",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor)),
                          )
                        ],
                      ),
                      !userData.isMentor!
                          ? SizedBox(
                              height: 210,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: mentors.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    child: const TopicTile(),
                                  );
                                },
                              ),
                            )
                          : Container(),
                      // use all the available space to show upcoming sessions

                      userData.isMentor!
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: StreamBuilder<
                                      QuerySnapshot<Map<String, dynamic>>>(
                                  stream: getFirebaseSessions(),
                                  builder: (context, sessionsSnapshot) {
                                    if (sessionsSnapshot.hasData) {
                                      final sessionsData =
                                          sessionsSnapshot.data!;
                                      final sessionsList =
                                          sessionsData.docs.where((element) {
                                        return element["userId"] ==
                                                currentUser!.uid ||
                                            (element["emailIDs"] as String)
                                                .contains(currentUser!.email!);
                                      }).toList();

                                      sessionsList.sort((a, b) {
                                        return a["from"]
                                            .toDate()
                                            .compareTo(b["from"].toDate());
                                      });

                                      return ListView.builder(
                                        itemCount: sessionsList.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.55,
                                            height: 90,
                                            child: Card(
                                              elevation: 0.5,
                                              child: ListTile(
                                                title: Text(
                                                    sessionsList[index]
                                                        .data()["title"],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                subtitle: Text(
                                                    sessionsList[index]
                                                        .data()["description"],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        fontSize: 11.0,
                                                        color: Colors.grey)),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else if (sessionsSnapshot.hasError) {
                                      // Handle the error here
                                      return Center(
                                          child:
                                              Text('Error: ${snapshot.error}'));
                                    } else {
                                      // Show a loading indicator while waiting for data
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                            )
                          : Container(),
                    ]),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            // Handle the error here
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Show a loading indicator while waiting for data
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
