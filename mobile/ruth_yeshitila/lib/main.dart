import 'package:flutter/material.dart';
import 'Add_page.dart';
import 'detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 255, 255, 255)),
      debugShowCheckedModeBanner: false,
      home: const homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.person_outline, color: Colors.black54),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'July 20, 2025',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                RichText(
                  text: const TextSpan(
                    text: "Hello, ",
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                    children: [
                      TextSpan(
                        text: 'Ruth Yeshiitila',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    // Handle notification button press
                  },
                ),
                Positioned(
                  right: 10,
                  top: 12,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 21.0, top: 15.0,right: 12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Available products",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Icon(Icons.search),
                    ),
                  ),
                ],
              ),

              // the product card is coded here
              GestureDetector(
                onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const detailPage()));
                },
                child: Container(
                  margin: const EdgeInsets.only(right:14.0,top: 12.0),
                  padding: const EdgeInsets.only(right:12.0,left:12.0,bottom: 12.0),
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow:[
                      BoxShadow(
                        color: Colors.grey.withValues(
                          red: 0.0,
                          green: 0.0,
                          blue: 0.0,
                          alpha: 0.2,
                        ),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                            image: AssetImage('images/image.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Jordan Sneakers",
                            style: TextStyle(fontSize: 18, color: Colors.black87,fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "\$150",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: const EdgeInsets.only(top: 8.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "men's shoe",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow[700]),
                              const SizedBox(width: 4),
                              const Text(
                                "(4.7)",
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                
                    ],
                  ),
                ),
              ),

              // the product card is coded here
              GestureDetector(
                onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context) => const detailPage()));

                },
                child: Container(
                  margin: const EdgeInsets.only(right:14.0,top: 12.0),
                  padding: const EdgeInsets.only(right:12.0,left:12.0,bottom: 12.0),
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow:[
                      BoxShadow(
                        color: Colors.grey.withValues(
                          red: 0.0,
                          green: 0.0,
                          blue: 0.0,
                          alpha: 0.2,
                        ),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                            image: AssetImage('images/image.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Jordan Sneakers",
                            style: TextStyle(fontSize: 18, color: Colors.black87,fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "\$150",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: const EdgeInsets.only(top: 8.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "men's shoe",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow[700]),
                              const SizedBox(width: 4),
                              const Text(
                                "(4.7)",
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                
                    ],
                  ),
                ),
              ),
              
               // the product card is coded here
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const detailPage()));
 
                },
                child: Container(
                  margin: const EdgeInsets.only(right:14.0,top: 12.0),
                  padding: const EdgeInsets.only(right:12.0,left:12.0,bottom: 12.0),
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow:[
                      BoxShadow(
                        color: Colors.grey.withValues(
                          red: 0.0,
                          green: 0.0,
                          blue: 0.0,
                          alpha: 0.2,
                        ),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                            image: AssetImage('images/image.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Jordan Sneakers",
                            style: TextStyle(fontSize: 18, color: Colors.black87,fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "\$150",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: const EdgeInsets.only(top: 8.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "men's shoe",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow[700]),
                              const SizedBox(width: 4),
                              const Text(
                                "(4.7)",
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                
                    ],
                  ),
                ),
              ),

               // the product card is coded here
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (context) => const addPage()));

        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
