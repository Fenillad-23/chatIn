import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  String? userName;

  UserProfile({Key? key, this.userName}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.userName.toString(),
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onPressed: () {
                // do something
              },
            ),
          )
        ],
        backgroundColor: Colors.white,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            color: new Color(0xFFECEFF1),
            child: Column(children: [
              Container(
                //color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 110,
                      width: MediaQuery.of(context).size.width / 3,
                      //color:Colors.green,
                      padding: EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Colors.blue,
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                  "https://images.unsplash.com/photo-1562174949-4591859cae0a?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max",
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 60,
                        //color: Colors.yellow,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.userName.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                            Container(
                                padding: EdgeInsets.fromLTRB(2, 5, 0, 0),
                                child: Text("Vaidehi Kheni",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6),
                                        fontSize: 12))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15, right: 0, left: 7),
                child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 57,
                        width: MediaQuery.of(context).size.width / 3.5,
                        //color: Colors.deepOrange,
                        child: OutlinedButton.icon(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.5),
                                ),
                                side: BorderSide(
                                  width: 2.0,
                                  color: Colors.blue,
                                  style: BorderStyle.solid,
                                )),
                            icon: Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Icon(Icons.chat_bubble_outline,
                                    size: 28, color: Colors.black87)),
                            label: Text("")),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 23),
                        child: Container(
                          height: 57,
                          width: MediaQuery.of(context).size.width / 2,
                          //color: Colors.deepPurple,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (index == 0) {
                                  index = 1;
                                } else if (index == 1) {
                                  index = 0;
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28.5),
                              ),
                              side: BorderSide(
                                width: 2.0,
                                color: Colors.blue,
                              ),
                              primary: index == 1
                                  ? new Color(0xFFECEFF1)
                                  : Colors.blue,
                            ),
                            child: Text(
                              index == 1 ? 'Following' : 'Follow',
                              style: TextStyle(
                                  fontSize: 18,
                                  color:
                                      index == 1 ? Colors.black : Colors.white),
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 8,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  shadowColor: Colors.grey[800],
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 0,
                        ),
                        TextButton(
                          onPressed: () {
                            // Respond to button press
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0,left: 10.0),
                            child: Column(
                              children: [
                                Text("1.5 k",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 6,
                                ),
                                Text("Post",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6),
                                        fontSize: 12))
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0,left: 10.0),
                            child: Column(
                              children: [
                                Text("1.5 k",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 6,
                                ),
                                Text("Followers",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6),
                                        fontSize: 12))
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0,left: 10.0),
                            child: Column(
                              children: [
                                Text("1.5 m",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 6,
                                ),
                                Text("Following",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6),
                                        fontSize: 12))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [__contentGridView()],
              )
            ])),
      ),
    );
  }
}

List imageList = [
  'https://cdn.pixabay.com/photo/2019/03/15/09/49/girl-4056684_960_720.jpg',
  'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
  'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
  'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
  'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
  'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
  'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
  'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
  'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
  'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
  'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
];
Widget __contentGridView() {
  return LayoutBuilder(
    builder: (context, constraints) {
      return GridView.builder(
        itemCount: imageList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: constraints.maxWidth > 700 ? 4 : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => GridTile(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(imageList[index],
                width: 300, height: 150, fit: BoxFit.cover),
          ),
          // child: Image.network(imageList[index]),
        ),
      );
    },
  );
}