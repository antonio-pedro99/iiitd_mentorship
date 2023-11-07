import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/data/model/mentor.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          floating: true,
          snap: true,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
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
                onPressed: () => Navigator.pushNamed(context, "/home/schedule"),
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
              const Text("Quick shortcuts",
                  style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 10,
              ),
              SessionActionButton(
                action: "My sessions",
                onPressed: () => Navigator.pushNamed(context, "/home/schedule"),
              ),
              SessionActionButton(
                action: "Find a mentor",
                onPressed: () => Navigator.pushNamed(context, "/home/schedule"),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Recommended Mentors",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  TextButton(
                    onPressed: null,
                    child: Text("See All",
                        style:
                            TextStyle(color: Theme.of(context).primaryColor)),
                  )
                ],
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: mentors.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: MentorTile(
                        mentor: mentors[index],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Topics of Interest",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  TextButton(
                    onPressed: null,
                    child: Text("See All",
                        style:
                            TextStyle(color: Theme.of(context).primaryColor)),
                  )
                ],
              ),
              SizedBox(
                height: 210,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: mentors.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: const TopicTile(),
                    );
                  },
                ),
              ),
            ]),
          ),
        ),
      ],
    ));
  }
}
