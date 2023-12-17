import 'package:flutter/material.dart';
import 'package:medical_test_app/cart/cart_page.dart';
import 'package:medical_test_app/common/common.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(cartItems: cartItems),
                    ),
                  );
                },
              ),
              if (cartItems
                  .isNotEmpty) // Show count indicator if items are in the cart
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cartItems.length}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Popular Lab Tests',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: List.generate(4, (index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(
                          _getItemName(index),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.cyan,
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/main_icon.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        'Get reports in 24 hours',
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '₹${_getTestPrice(index)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _addToCart(context, index);
                                  },
                                  child: const Text('Add to Cart'),
                                ),
                                const SizedBox(width: 8),
                                OutlinedButton(
                                  onPressed: () {
                                    // Navigate to detailed page
                                    print('View Details');
                                  },
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  child: Text(
                                    'View Details',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Text(
                  'Popular Packages',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 0.5),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/tube_icon.png',
                            height: 100,
                            width: 100,
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.cyan,
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/main_icon.png',
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(width: 4),
                                const Text('Safe'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Full Body checkup',
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Includes 92 tests',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textColor2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildListItem('Blood Glucose Fasting'),
                          _buildListItem('Liver Function Test'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '₹2000',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: AppColors.mainColor,
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              _addToCartPackage(context);
                            },
                            child: const Text('Add to Cart'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addToCart(BuildContext context, int index) {
    final itemName = _getItemName(index);
    final itemPrice = _getTestPrice(index);

    setState(() {
      cartItems.add('$itemName - ₹$itemPrice');
    });

    _showNotification(itemName, itemPrice);
  }

  void _addToCartPackage(BuildContext context) {
    final packageName = 'Full Body checkup';
    final packagePrice = '2000';

    setState(() {
      cartItems.add('$packageName - ₹$packagePrice');
    });

    _showNotification(packageName, packagePrice);
  }

  void _showNotification(String itemName, String itemPrice) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Added to Cart'),
          content: Text('$itemName added to the cart.\nPrice: ₹$itemPrice'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildListItem(String text) {
    return Row(
      children: [
        const SizedBox(width: 8),
        const Icon(
          Icons.fiber_manual_record,
          size: 8,
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    );
  }

  String _getItemName(int index) {
    switch (index) {
      case 0:
        return 'Thyroid Profile';
      case 1:
        return 'Iron Study Test';
      case 2:
        return 'Diabetes Profile';
      case 3:
        return 'CBC';
      default:
        return '';
    }
  }

  String _getTestPrice(int index) {
    switch (index) {
      case 0:
        return '1000';
      case 1:
        return '600';
      case 2:
        return '1200';
      case 3:
        return '1000';
      default:
        return '';
    }
  }
}
