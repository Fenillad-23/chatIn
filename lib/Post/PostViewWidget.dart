import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostViewList extends StatefulWidget {
  const PostViewList({Key? key}) : super(key: key);

  @override
  _PostViewListState createState() => _PostViewListState();
}

class _PostViewListState extends State<PostViewList> {
  bool _isLiked = false;
  List Posts = [
    "https://images.unsplash.com/photo-1578166375397-5711fb282325?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
    "https://images.unsplash.com/photo-1643712662909-29fe8f02b613?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDE4fGJvOGpRS1RhRTBZfHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1643585186802-ad887747a6d8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDIyfGJvOGpRS1RhRTBZfHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1643861707098-a0740dc40560?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDJ8aG1lbnZRaFVteE18fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1643345206285-92dfcb3a2bb8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDE2fGhtZW52UWhVbXhNfHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1643682782480-35b7ff764bff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    "https://images.unsplash.com/photo-1643579234690-bc90d1615e6d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDMxfHRvd0paRnNrcEdnfHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1643329123031-03ea3762b25a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDUxfHRvd0paRnNrcEdnfHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1643156702769-14840703ddb7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDY4fHRvd0paRnNrcEdnfHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1643028588901-87770ed4469c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDkzfHRvd0paRnNrcEdnfHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
  ];
  List caption = [
    "My last day for this year holiday! So excited to share my memories with you guys! 😁😍",
    "My last day for this year holiday! So excited to share my memories with you guys! 😁😍",
    "My last day for this year holiday! So excited to share my memories with you guys! 😁😍",
    "My last day for this year holiday! So excited to share my memories with you guys! 😁😍",
    "My last day for this year holiday! So excited to share my memories with you guys! 😁😍",
    "My last day for this year holiday! So excited to share my memories with you guys! 😁😍",
    "My last day for this year holiday! So excited to share my memories with you guys! 😁😍",
    "My last day for this year holiday! So excited to share my memories with you guys! 😁😍",
    "My last day for this year holiday! So excited to share my memories with you guys! 😁😍",
    "My last day for this year holiday! So excited to share my memories with you guys! 😁😍",
    "My last day for this year holiday! So excited to share my memories with you guys! 😁😍",
    "My last day for this year holiday! So excited to share my memories with you guys! 😁😍",
  ];
  List name = [
    "fenil",
    "dhruvi",
    "vaidehi",
    "kenil",
    "ds",
    "kenil",
    "jogendra",
    "pratik",
    "dev",
    "tanisha",
    "jigar",
    "darshan"
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: Posts.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Container(
            //color: Colors.blue,
            padding: EdgeInsets.only(bottom: 20),
            child: Card(
              elevation: 8,
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white),
              ),
              // shadowColor: Colors.grey[800],
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 20.0,
                                child: ClipOval(
                                  child: Image.network(
                                    Posts[index],
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                name[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            height: 40,
                            child: Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Icon(
                                Icons.more_vert,
                                size: 30,
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width - 74,
                            child: Text(caption[index],
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 12)))
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 74,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              Posts[index],
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                                child: _isLiked
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : Icon(
                                        FontAwesomeIcons.heart,
                                        color: null,
                                      ),
                                onTap: () {
                                  if (!_isLiked) {
                                    setState(() {
                                      _isLiked = true;
                                    });
                                  } else {
                                    setState(() {
                                      _isLiked = false;
                                    });
                                  }
                                }),
                            // const Text("45",style: TextStyle(fontSize: 15),),
                            SizedBox(
                              width: 25,
                            ),
                            Icon(FontAwesomeIcons.comment),
                            SizedBox(
                              width: 25,
                            ),
                            new Icon(FontAwesomeIcons.paperPlane),
                            // const Text("45",style: TextStyle(fontSize: 15),),
                          ],
                        ),
                        Icon(FontAwesomeIcons.bookmark)
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("1048 Likes",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14))
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Text("1 hour ago",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 12))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
