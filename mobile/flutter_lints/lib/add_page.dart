import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:const  Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: const Text('Add Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 300,
              height: 200,
              // padding: const EdgeInsets.all(14.0),
              // margin: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(9),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo_outlined,
                    size: 100,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'upload your image',
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            //the input field for the name
            const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
        
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(9),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
        
             //the input field for the catagory
              const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Category',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
        
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(9),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                 
                ),
              ),
            ),
        
              const  Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'price',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
        
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(9),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
    
                  suffix: Icon(Icons.attach_money, color: Colors.black,size: 19.0),
                  ),
              ),
             
            ),
        
              const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Description',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
        
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              height: 140,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(9),
              ),
              child:const  TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            //the button to add the item
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(9),
              ),
              child: TextButton(
                onPressed: () {
                  // Add item logic here
                },
                child: const Text(
                  'Add Item',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Container(
              width: 300,
              height: 40,
              margin: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: Colors.red, width: 1),           
                ),
                child: TextButton(onPressed: (){
                       //delete logic here
                },
                 child:  const Text('Delete', 
                 style: TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.w500)
                 ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
