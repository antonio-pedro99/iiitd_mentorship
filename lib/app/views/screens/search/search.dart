import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/data/model/user.dart';
import 'package:iiitd_mentorship/app/views/screens/chat/chat_page.dart';
import 'package:iiitd_mentorship/app/views/screens/profile/user_profile.dart';
import 'package:iiitd_mentorship/app/views/screens/search/widgets/mentor_result_tile.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_textbox.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
    required this.forMessage,
  });
  final bool forMessage;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchEditingController = TextEditingController();

  final List<Chip> filters = [];
  final List<DBUser> mentorsFiltered = [];

  bool isSearching = false;
  bool isSorted = false;

  capitalize(String s) {
    if (s.isEmpty) {
      return s;
    }
    return s[0].toUpperCase() + s.substring(1);
  }

  firestoreSearchByName(String search) {
    mentorsFiltered.clear();

    capitalize(search);

    return FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: search)
        .where('adminApproval', isEqualTo: true)
        .get()
        .asStream();
  }

  // search by branch
  firestoreSearchByBranch(String search) {
    mentorsFiltered.clear();

    capitalize(search);

    return FirebaseFirestore.instance
        .collection('users')
        .where('branch', isEqualTo: search)
        .where('adminApproval', isEqualTo: true)
        .get()
        .asStream();
  }

  // search by company
  firestoreSearchByCompany(String search) {
    mentorsFiltered.clear();

    capitalize(search);

    return FirebaseFirestore.instance
        .collection('users')
        .where('company', isEqualTo: search)
        .where('adminApproval', isEqualTo: true)
        .get()
        .asStream();
  }

  // search by topic
  firestoreSearchByTopic(String search) {
    mentorsFiltered.clear();

    capitalize(search);

    return FirebaseFirestore.instance
        .collection('users')
        .where('topics', arrayContains: search)
        .where('adminApproval', isEqualTo: true)
        .get()
        .asStream();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isSearching = !isSearching;
    });
    firestoreSearchByName("").listen((event) {
     if (mounted){
       setState(() {
        mentorsFiltered.clear();
        event.docs.forEach((element) {
          final mentor = DBUser.fromJson(element.data());
          if (mentor.uid != currentUser!.uid) {
            mentorsFiltered.add(mentor);
          }
        });
      });
     }
    });
  }

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          floating: true,
          snap: true,
          title: CustomTextBox(
            controller: searchEditingController,
            hintText: "Search by name, branch, company, topic, etc.",
            prefixIcon: const Icon(Icons.search),
            onSubmitted: (p0) {
              setState(() {
                isSearching = true;
              });
              firestoreSearchByName(p0).listen((event) {
                setState(() {
                  mentorsFiltered.clear();
                  event.docs.forEach((element) {
                    final mentor = DBUser.fromJson(element.data());
                    if (mentor.uid != currentUser!.uid) {
                      mentorsFiltered.add(mentor);
                    }
                  });
                });
              });
            },
          ),
          toolbarHeight: kToolbarHeight + 10,
          actions: [
            IconButton(
                onPressed: () {
                  // open a modal sheet to select filters
                  const filterOptions = [
                    "Branch",
                    "Company",
                    "Topic",
                  ];

                  showBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: ListView.builder(
                            itemCount: filterOptions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(filterOptions[index]),
                                onTap: () {
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              "Search by ${filterOptions[index]}"),
                                          content: CustomTextBox(
                                            controller: searchEditingController,
                                            hintText:
                                                "Search by ${filterOptions[index]}",
                                            prefixIcon:
                                                const Icon(Icons.search),
                                            onSubmitted: (p0) {
                                              setState(() {
                                                isSearching = true;
                                              });
                                              if (filterOptions[index] ==
                                                  "Branch") {
                                                firestoreSearchByBranch(p0)
                                                    .listen((event) {
                                                  setState(() {
                                                    mentorsFiltered.clear();
                                                    event.docs
                                                        .forEach((element) {
                                                      final mentor =
                                                          DBUser.fromJson(
                                                              element.data());
                                                      if (mentor.uid !=
                                                          currentUser!.uid) {
                                                        mentorsFiltered
                                                            .add(mentor);
                                                      }
                                                    });
                                                  });
                                                });
                                              } else if (filterOptions[index] ==
                                                  "Company") {
                                                firestoreSearchByCompany(p0)
                                                    .listen((event) {
                                                  setState(() {
                                                    mentorsFiltered.clear();
                                                    event.docs
                                                        .forEach((element) {
                                                      final mentor =
                                                          DBUser.fromJson(
                                                              element.data());
                                                      if (mentor.uid !=
                                                          currentUser!.uid) {
                                                        mentorsFiltered
                                                            .add(mentor);
                                                      }
                                                    });
                                                  });
                                                });
                                              } else if (filterOptions[index] ==
                                                  "Topic") {
                                                firestoreSearchByTopic(p0)
                                                    .listen((event) {
                                                  setState(() {
                                                    mentorsFiltered.clear();
                                                    event.docs
                                                        .forEach((element) {
                                                      final mentor =
                                                          DBUser.fromJson(
                                                              element.data());
                                                      if (mentor.uid !=
                                                          currentUser!.uid) {
                                                        mentorsFiltered
                                                            .add(mentor);
                                                      }
                                                    });
                                                  });
                                                });
                                              }
                                            },
                                          ),
                                        );
                                      });
                                },
                              );
                            },
                          ),
                        );
                      });
                },
                icon: const Icon(
                  Icons.filter_list,
                  color: Colors.grey,
                )),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Search results",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          mentorsFiltered
                              .sort((a, b) => a.name!.compareTo(b.name!));
                          isSorted = !isSorted;
                        });
                      },
                      icon: isSorted
                          ? const Icon(
                              Icons.sort_by_alpha,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.sort_by_alpha,
                              color: Colors.black,
                            )),
                ],
              ),
              isSearching
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: mentorsFiltered.isNotEmpty
                          ? ListView.builder(
                              itemCount: mentorsFiltered.length,
                              itemBuilder: (context, index) {
                                return InkResponse(
                                  onTap: () {
                                    if (widget.forMessage) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => ChatPage(
                                              receiverId:
                                                  mentorsFiltered[index].uid,
                                              receiverUser:
                                                  mentorsFiltered[index]),
                                        ),
                                      );
                                    } else {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserProfileScreen(
                                                    user: mentorsFiltered[
                                                        index])),
                                      );
                                    }
                                  },
                                  child: MentorResultTile(
                                      mentor: mentorsFiltered[index]),
                                );
                              },
                            )
                          : const Center(child: CircularProgressIndicator()),
                    )
                  : const Center(child: Text("Search for a mentor")),
            ]),
          ),
        ),
      ],
    ));
  }
}
