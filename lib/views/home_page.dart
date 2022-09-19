import 'package:flutter/material.dart';
import 'package:flutter_api/services/remote.dart';
import 'package:http/http.dart';

import '../models/post.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late List<Post> posts;
  var isLoaaded =false;


  void initState(){
    super.initState();
    getData();
  }

  getData() async {

    posts = (await RemoteService().getData())!;
    if(posts != null){
      setState(() {
        isLoaaded = true;
      }
      );
    }


  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(

          centerTitle: true ,
          title:const Text("Dummy Data Fetcher"),
        ),
        body: Container(

          child: Visibility(
            visible: isLoaaded,
            //if not unablbe to get data replacement will work
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView.builder(
              itemCount: posts.length,
                itemBuilder: (context, index) {
                //item buider will build me a contain or whatever i want to buid for 1
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(child: const Icon(Icons.person)),
                      title: Text(posts[index].title),
                     //subtitle: Text(posts[index].body),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Detailpage()),
                        );
                      },


                      ),
                  );
                },

            ),
          ),
        ),

      ),
    );
  }
}

class Detailpage extends StatelessWidget {
  const Detailpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true ,
        title:const Text("User Profile"),
      ),
      body: const Material(
        child: Center(
          child:Text("User Info info will Updated soon") ,
        ),
      )
    );
  }
}

