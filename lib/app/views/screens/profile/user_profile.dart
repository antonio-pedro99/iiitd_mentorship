import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/data/model/user.dart';
import 'package:iiitd_mentorship/app/views/screens/chat/chat_page.dart';
import 'package:iiitd_mentorship/app/views/screens/schedule/create.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key, required this.user});

  final DBUser user;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
               title: Text(
              widget.user.name!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              
              ),
            ),
              background: Image.network(
                (widget.user.photoUrl == null || widget.user.photoUrl!.isEmpty)
                    ? 'https://images.unsplash.com/photo-1531384441138-2736e62e0919?auto=format&fit=crop&q=80&w=1587&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
                    : widget.user.photoUrl!,
                fit: BoxFit.cover,
              ),
            ),
            floating: true,
            pinned: true,
           
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Report"),
                        content: const Text(
                            "Are you sure you want to report this user?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Report"),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.flag, color: Colors.black),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user.name!,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        widget.user.email!,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Currently working at ${widget.user.company ?? widget.user.college ?? 'IIITD'}. This is some random text to fill the space.",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkResponse(
                            child: Chip(
                              label: const Text("Send message"),
                              avatar: const Icon(
                                Icons.chat_bubble_outline,
                                color: Colors.white,
                              ),
                              labelPadding: const EdgeInsets.all(8),
                              backgroundColor: Theme.of(context).primaryColor,
                              labelStyle: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChatPage(receiverUser: widget.user),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 16),
                          InkResponse(
                            child: const Chip(
                              label: Text("New meeting"),
                              avatar: Icon(Icons.today_outlined,
                                  color: Colors.black54),
                              labelPadding: EdgeInsets.all(8),
                              backgroundColor: Colors.white,
                              labelStyle: TextStyle(
                                color: Colors.black54,
                              ),
                              side: BorderSide(
                                color: Colors.black54,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScheduleMeetingScreen(
                                          email: widget.user.email!,
                                          title:
                                              "Meeting with ${widget.user.name}")));
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        leading: const Icon(Icons.school),
                        title: const Text(
                          'Current Company/College',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          widget.user.company ?? widget.user.college ?? 'IIITD',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.school),
                        title: const Text(
                          'Branch',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          widget.user.branch!,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.today),
                        title: const Text(
                          'Year',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          widget.user.yearOfGraduation!,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const Divider(),
                      Text(
                        'Topics ${widget.user.name!} can help with',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: 
                        (widget.user.topics != null || widget.user.topics!.isNotEmpty)? 
                        widget.user.topics!
                            .map(
                              (interest) => Chip(
                                label: Text(interest),
                              ),
                            )
                            .toList() : [const Text("No topics selected")],
                        
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
