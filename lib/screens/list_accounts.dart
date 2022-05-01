import 'package:flutter/material.dart';

import 'package:flutter_sqflite_basic/models/password_model.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list =
        ModalRoute.of(context)!.settings.arguments as List<PasswordModel>;
    return Scaffold(
        appBar: AppBar(),
        body: ListAccounts(
          list: list,
        ));
  }
}

class ListAccounts extends StatelessWidget {
  final List<PasswordModel> list;
  const ListAccounts({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        elevation: 20,
        child: ListView.separated(
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(list[index].cuenta),
                subtitle: Text(list[index].password),
                leading: Text(list[index].id.toString()),
              );
            },
            separatorBuilder: (_, index) => const Divider(),
            itemCount: list.length),
      ),
    );
  }
}
