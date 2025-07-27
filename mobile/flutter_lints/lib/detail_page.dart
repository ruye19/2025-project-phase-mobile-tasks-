import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String _selectedSize = '39'; // Default selected size

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align content to the left
          children: [
            Stack(
              children: [
                // The Product Image
                Image.asset(
                  'images/image.png', // Make sure this path is correct in your pubspec.yaml
                  height: 250, // Adjust height as needed to match your design
                  width:
                      double
                          .infinity, // Makes the image take the full width available
                  fit:
                      BoxFit
                          .cover, // Ensures the image covers the area, cropping if necessary
                ),
                // The Back Button, positioned on top of the image
                Positioned(
                  top: 30, // Distance from the top of the Stack
                  left: 20, // Distance from the left of the Stack
                
                  child: Container(
                    width: 28.0, // Width of the button
                    height: 26.0, // Height of the button
                    decoration:const BoxDecoration(
                      color: Colors.black54, // Semi-transparent black
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                        size: 12.0, // Ensure icon is visible on dark background
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jordan Sneakers',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   Text(
                    '\$150',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 8.0)),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
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
                        '(4.7)',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
                
            const SizedBox(height: 20), // Spacing after price/name
            // Size Label
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Size:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Ensure text color is visible
                ),
              ),
            ),
                
            // Scrollable Size Options
            SingleChildScrollView(
              scrollDirection:
                  Axis.horizontal, // This makes it scroll horizontally
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ...[
                      '39',
                      '40',
                      '41',
                      '42',
                      '43',
                      '44',
                      '45',
                      '46',
                      '47',
                    ].map((size) {
                      bool isSelected = _selectedSize == size;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSize = size;
                          });
                        },
                        child: Container(
                          margin:const  EdgeInsets.only(
                            right: 10,
                          ), // Spacing between size boxes
                          width: 50, // Fixed width for each size box
                          height: 50, // Fixed height for each size box
                          alignment:
                              Alignment
                                  .center, // Center the text inside the box
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? Colors.blue
                                    : Colors
                                        .grey[200], // Blue when selected, light grey otherwise
                            borderRadius: BorderRadius.circular(
                              10,
                            ), // Rounded corners for the boxes
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              color:
                                  isSelected
                                      ? Colors.white
                                      : Colors
                                          .black, // White text when selected, black otherwise
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }), // Convert the iterable from map to a List of Widgets
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration:const  BoxDecoration(color: Colors.white),
              child: const Text('description'),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.',
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
              
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        
                      ),
                      child: const Text('DELETE'),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: const Text('UPDATE'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
