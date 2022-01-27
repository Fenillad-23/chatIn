import 'package:flutter/material.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search User"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: getUserList());
              },
              icon: Icon(Icons.search))
        ],
      ),
    );
  }
}

class getUserList extends SearchDelegate<userList> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    late final list = loadUserList();
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final userList lst = list[index];
          return ListTile(
            title: Text(lst.userName),
          );
        });
  }
}

class userList {
  late final String userName;
  late final String imgUrl;
  userList(this.userName, this.imgUrl);
}

List<userList> loadUserList() {
  return <userList>[
    userList("fenil", "assets/images/logo_blue.png"),
    userList("vaidehi.047", "assets/images/logo_blue.png"),
    userList("ds", "assets/images/logo_blue.png"),
    userList("jogendra", "assets/images/logo_blue.png"),
    userList("jigar", "assets/images/logo_blue.png"),
    userList("pratik", "assets/images/logo_blue.png"),
    userList("kenil", "assets/images/logo_blue.png"),
    userList("darshan", "assets/images/logo_blue.png"),
  ];
}
