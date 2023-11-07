import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/data/model/mentor.dart';
import 'package:iiitd_mentorship/app/views/screens/search/widgets/mentor_result_tile.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_textbox.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Mentor> mentors = Mentor.getMentors();

  final searchEditingController = TextEditingController();

  final List<Chip> filters = [];
  final List<Mentor> mentorsFiltered = Mentor.getMentors();

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
                  filters.add(Chip(
                    label: Text(p0, key: ValueKey(p0)),
                    color: MaterialStateColor.resolveWith((states) => Colors
                        .primaries[filters.length % Colors.primaries.length]),
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () {
                      setState(() {
                        filters.removeWhere(
                            (element) => element.label.key == ValueKey(p0));
                        searchEditingController.clear();
                      });
                    },
                  ));
                });
              }),
          toolbarHeight: kToolbarHeight + 10,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.filter_list,
                  color: Colors.grey,
                )),
          ],
          bottom: filters.isNotEmpty
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      children: filters,
                    ),
                  ))
              : const PreferredSize(
                  preferredSize: Size.fromHeight(20),
                  child: Text("No filters applied yet")),
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
                      onPressed: () {}, icon: const Icon(Icons.sort_by_alpha))
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  itemCount: mentorsFiltered.length,
                  itemBuilder: (context, index) {
                    return MentorResultTile(mentor: mentorsFiltered[index]);
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