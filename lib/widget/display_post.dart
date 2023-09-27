
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



class DisplayPost extends StatefulWidget {
  final snap;
  const DisplayPost({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<DisplayPost> createState() => _DisplayPostState();
}

class _DisplayPostState extends State<DisplayPost> {
  bool isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade300,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(widget.snap['profImage']),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(widget.snap['username']),

                  if(FirebaseAuth.instance.currentUser?.uid==widget.snap['uid'])
                  Padding(
                    padding: const EdgeInsets.only(left:140),
                    child: IconButton(onPressed: () {
                      showDialog(context: context, builder: (context) => Dialog(
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                            vertical: 16
                          ),
                          shrinkWrap: true,
                          children: [
                            InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Delete'),
                                  Icon(Icons.delete)
                                ],
                              ),
                              onTap: () async{
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),);
                    }, icon: Icon(Icons.more_vert)),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onDoubleTap: () async {
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(alignment: Alignment.center, children: [
              Container(
                height: 200,
                width: 300,
                child: Stack(children: [
                  Positioned(
                      right: 5,
                      child: Column(
                        children: [
                          // LikeAnimation(
                          //   isAnimating:
                          //       widget.snap['likes'].contains(user?.uid),
                          //   smallLike: true,
                          //   child: IconButton(
                          //       onPressed: () async {
                          //         await FireStoreMethods().likePost(
                          //             widget.snap['postId'],
                          //             user?.uid,
                          //             widget.snap['likes']);
                          //         setState(() {
                          //           isLikeAnimating = true;
                          //         });
                          //       },
                          //       icon: widget.snap['likes'].contains(user?.uid)
                          //           ? Icon(
                          //               size: 30,
                          //               Icons.favorite,
                          //               color: Colors.red,
                          //             )
                          //           : Icon(
                          //               size: 30,
                          //               Icons.favorite_border_outlined,
                          //               color: Colors.white,
                          //             )),
                          // ),
                          Text(
                            '${widget.snap['likes'].length}',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                  Positioned(
                    left: 10,
                    top: 120,
                    child: Text(
                      widget.snap['tripTitle'],
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 160,
                    child: Stack(alignment: Alignment.center, children: [
                      Container(
                        height: 20,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            widget.snap['duration'],
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ]),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      opacity: 0.5,
                      fit: BoxFit.cover,
                      image: widget.snap['postUrl'][0] != null
                          ? NetworkImage(widget.snap['postUrl'][0])
                          : NetworkImage(
                              'https://t3.ftcdn.net/jpg/03/45/05/92/240_F_345059232_CPieT8RIWOUk4JqBkkWkIETYAkmz2b75.jpg'),
                    )),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: isLikeAnimating ? 0.8 : 0,
                // child: LikeAnimation(
                //   child: const Icon(Icons.favorite,
                //       color: Colors.white, size: 100),
                //   isAnimating: isLikeAnimating,
                //   duration: const Duration(
                //     milliseconds: 400,
                //   ),
                //   onEnd: () {
                //     setState(() {
                //       isLikeAnimating = false;
                //     });
                //   },
                // ),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 200),
            child: Container(
              child: Text(
                DateFormat.yMMMd()
                    .format(widget.snap['datePublished'].toDate()),
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }
}
