import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/views/widgets/mentor_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              Text("Welcome"),
              SizedBox(
                height: 5,
              ),
              Text(
                "Find IIITD Mentors around the world",
                style: TextStyle(fontSize: 12),
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
              // my sessions card
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("My Sessions",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text("Upcoming",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
                              Text("0",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Completed",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
                              Text("0",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Cancelled",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
                              Text("0",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Recommended Mentors",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  TextButton(
                    onPressed: null,
                    child: Text("See All"),
                  )
                ],
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: const MentorTile(
                          name: "Mentors name",
                          bio: "Short Bio",
                          stars: 2,
                          photoUrl:
                              "https://images.unsplash.com/photo-1531384441138-2736e62e0919?auto=format&fit=crop&q=80&w=1587&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Topics of Interest",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  TextButton(
                    onPressed: null,
                    child: Text("See All"),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text("Topic $index"),
                          subtitle: const Text("Description"),
                        ),
                      );
                    }),
              )
            ]),
          ),
        ),
      ],
    ));
  }
}
