import 'package:flutter/material.dart';
import 'package:medical_test_app/booking/booking.dart';
import 'package:medical_test_app/common/common.dart';

class CartPage extends StatelessWidget {
  final List<String> cartItems;

  const CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cartItems.map((cartItem) {
              final itemName = _getItemName(cartItem);
              final itemPrice = _getItemPrice(cartItem);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(10.0),
                        right: Radius.circular(10.0),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Pathology Tests',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              itemName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            RichText(
                              text: TextSpan(
                                text: '₹$itemPrice',
                                style: TextStyle(
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' 1400',
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        _buildDetailRow('M.R.P Total', '₹ 1400'),
                        _buildDetailRow('Discount', '₹ 400'),
                        _buildDetailRow('Amount to be paid', itemPrice),
                        _buildDetailRow('Total Saving', '₹ 400'),
                        SizedBox(height: 8.0),
                        ElevatedButton.icon(
                          onPressed: () {
                            _removeItem(context, itemName);
                          },
                          icon: Icon(Icons.delete),
                          label: Text('Remove'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            print("Upload file");
                          },
                          icon: Icon(Icons.upload),
                          label: Text('Upload prescription (Optional)'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Theme(
                            data: ThemeData(
                              unselectedWidgetColor: AppColors.mainColor, // Color when the radio button is not selected
                            ),
                            child: Radio(
                              value: false,
                              groupValue: null,
                              onChanged: (dynamic value) {},
                              activeColor: AppColors
                                  .mainColor, // Color when the radio button is selected
                            ),
                          ),
                          title: Text('Hard copy of reports'),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Reports will be delivered within 3-4 working days. Hard copy charges are non-refundable once the reports have been dispatched.',
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Price: ₹150 per person'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyAppointmentScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.mainColor,
                      ),
                      child: Center(
                        child: Text(
                          "Schedule",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }

  void _removeItem(BuildContext context, String itemName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove Item'),
          content: Text('Are you sure to remove $itemName from the cart?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Implement remove logic
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Implement cancel logic
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  String _getItemName(String cartItem) {
    return cartItem.split(' - ')[0]; // Extracts item name from the cart item
  }

  String _getItemPrice(String cartItem) {
    return cartItem.split(' - ')[1]; // Extracts item price from the cart item
  }
}
