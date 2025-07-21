import 'package:flutter/material.dart';
import 'detail_page.dart'; // Make sure detail_page.dart exists in your project

// SearchBarWithFilter widget for the top section of the SearchProduct page
class SearchBarWithFilter extends StatelessWidget {
  final VoidCallback? onFilterPressed; // Callback for when the filter icon is pressed

  const SearchBarWithFilter({super.key, this.onFilterPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Note: Removed horizontal padding here as the parent Padding in SearchProduct handles it
      // And removed vertical padding as the parent Column handles vertical spacing
      child: Row(
        children: [
          Expanded( // Makes the search input field take up most of the space
            child: Container(
              height: 50, // Fixed height for the input field
              decoration: BoxDecoration(
                color: Colors.white, // White background for the input field
                borderRadius: BorderRadius.circular(15.0), // Rounded corners
                border: Border.all(color: Colors.grey[300]!), // Subtle border
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Leather", // Placeholder text
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none, // Remove default TextField border
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Padding inside the TextField
                  suffixIcon: Icon(Icons.arrow_forward, color: Colors.blue), // Arrow icon
                ),
                style: TextStyle(color: Colors.black), // Text color for input
              ),
            ),
          ),
          const SizedBox(width: 10), // Space between search field and filter button
          Container(
            height: 50, // Fixed height for the filter button
            width: 50,  // Fixed width for the filter button (making it square)
            decoration: BoxDecoration(
              color: Colors.blue, // Blue background for the filter button
              borderRadius: BorderRadius.circular(15.0), // Rounded corners
            ),
            child: IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.white), // Filter icon
              onPressed: onFilterPressed, // Triggers the callback passed from parent
            ),
          ),
        ],
      ),
    );
  }
}

// FilterPanel widget for the sticky bottom sheet with Category, Price, and Apply button
class FilterPanel extends StatefulWidget {
  final VoidCallback onApply; // Callback for when apply is pressed

  const FilterPanel({super.key, required this.onApply});

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  TextEditingController _categoryController = TextEditingController();
  double _priceRangeValue = 0.5; // Example initial value for slider

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Panel covers full width
      decoration: BoxDecoration(
        color: Colors.white, // White background
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0), // Rounded top corners
          topRight: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, -3), // Shadow above the panel
          ),
        ],
      ),
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Column takes minimum vertical space
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Section
          const Text(
            "Category", // Category label
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _categoryController,
            decoration: InputDecoration(
              hintText: "Enter category",
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none, // No border visible
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
          ),
          const SizedBox(height: 20),

          // Price Section
          const Text(
            "Price", // Price label
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          SliderTheme( // Customize slider appearance
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4.0,
              activeTrackColor: Colors.blue,
              inactiveTrackColor: Colors.grey[300],
              thumbColor: Colors.blue,
              overlayColor: Colors.blue.withOpacity(0.2),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
            ),
            child: Slider(
              min: 0.0,
              max: 1.0,
              value: _priceRangeValue,
              onChanged: (value) {
                setState(() {
                  _priceRangeValue = value;
                });
              },
            ),
          ),
          const SizedBox(height: 20),

          // Apply Button
          SizedBox(
            width: double.infinity, // Button takes full width
            child: ElevatedButton(
              onPressed: widget.onApply, // Calls the onApply callback from parent
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Blue background
                foregroundColor: Colors.white, // White text
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
              ),
              child: const Text(
                "APPLY", // Button text
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// Main SearchProduct Page widget
class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  bool _showFilterPanel = false; // State to control filter panel visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new), // Back arrow icon
        ),
        centerTitle: true,
        title: const Text("Search Product"), // App Bar title
      ),
      body: Stack( // Use Stack to layer the scrollable content and the fixed filter panel
        children: [
          // Main Scrollable Content (Search Bar + Product Cards)
          SingleChildScrollView(
            // Add extra bottom padding to ensure content isn't hidden by the filter panel
            // Adjust 250.0 based on the actual height of your FilterPanel if it looks off
            padding: EdgeInsets.only(bottom: _showFilterPanel ? 250.0 : 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children horizontally
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  // Pass the callback to toggle filter panel visibility
                  child: SearchBarWithFilter(
                    onFilterPressed: () {
                      setState(() {
                        _showFilterPanel = !_showFilterPanel;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10), // Spacing below the search bar

                // Example Product Cards (repeated using a helper method)
                _buildProductCard(context),
                const SizedBox(height: 10), // Spacing between cards
                _buildProductCard(context),
                const SizedBox(height: 10),
                _buildProductCard(context),
                const SizedBox(height: 10),
                _buildProductCard(context),
                const SizedBox(height: 10),
                _buildProductCard(context),
                const SizedBox(height: 10),
                _buildProductCard(context),
              ],
            ),
          ),

          // Sticky Filter Panel (conditionally visible at the bottom)
          if (_showFilterPanel) // Only render if _showFilterPanel is true
            Align(
              alignment: Alignment.bottomCenter, // Aligns to the bottom of the Stack
              child: FilterPanel(
                onApply: () {
                  // Logic to apply filters (e.g., refetch data)
                  print("Apply button pressed in filter panel!");
                  setState(() {
                    _showFilterPanel = false; // Hide panel after applying filters
                  });
                },
              ),
            ),
        ],
      ),
    );
  }

  // Helper method to build a single product card to reduce code repetition
  Widget _buildProductCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the detail page when a card is tapped
        Navigator.push(context, MaterialPageRoute(builder: (context) => const detailPage()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 6.0),
        padding: const EdgeInsets.only(right: 12.0, left: 12.0, bottom: 12.0, top: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Subtle shadow
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch internal children
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('images/image.png'), // Product image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Derby Leather Shoes", // Product name
                  style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$120", // Product price
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 8.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Men's shoe", // Category/type
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow[700]), // Star icon
                    const SizedBox(width: 4),
                    const Text(
                      "(4.0)", // Rating
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}