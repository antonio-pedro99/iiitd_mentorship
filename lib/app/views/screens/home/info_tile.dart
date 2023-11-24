import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/data/model/alert.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({super.key, this.alert});

  final Alert? alert;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            color: Theme.of(context)
                .primaryColor, // Replace with your desired primary color
            child: Icon(
              alert!.icon,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Expanded(
                child: Text(
                  alert!.title!,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(alert!.message!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
