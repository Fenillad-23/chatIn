import 'package:flutter/material.dart';

class PostViewList extends StatefulWidget {
  const PostViewList({Key? key}) : super(key: key);

  @override
  _PostViewListState createState() => _PostViewListState();
}

class _PostViewListState extends State<PostViewList> {
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
            height: 350,
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.white,
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Container(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  radius: 15.0,
                                  child: ClipOval(
                                    child: Image.network(
                                      Posts[index],
                                      height: 40,
                                      width: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Container(
                              // color: Colors.black,
                              width: 290,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  name[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            Icon(Icons.more_vert)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Divider(),
                  ),
                  SizedBox(
                    height: 230,
                    width: 370,
                    child: Container(
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: Card(
                        // color: Colors.yellowAccent,
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            Posts[index],
                            width: 370,
                            height: 210,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 2.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_border_outlined,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        const Text("45"),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(Icons.comment),
                        SizedBox(
                          width: 6,
                        ),
                        const Text("45"),
                        Padding(
                          padding: const EdgeInsets.only(left: 180.0),
                          child: Expanded(child: const Text("2 hours ago")),
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
