import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_app/models/users_data.dart';
import 'package:suitmedia_app/providers/user_selector.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<UserSelector>(context, listen: false)
            .setFullName('${user.firstName} ${user.lastName}');
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.1),
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(user.avatar, scale: 1),
          ),
          title: Text(
            '${user.firstName} ${user.lastName}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            user.email,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 10,
                color: Color(0xFF686777)),
          ),
        ),
      ),
    );
  }
}
