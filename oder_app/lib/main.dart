import 'package:flutter/material.dart';

void main() {
  runApp(MyOrderApp());
}

class MyOrderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Order',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyOrderPage(),
    );
  }
}

class MyOrderPage extends StatefulWidget {
  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  // Khai báo các TextEditingController cho form
  final itemController = TextEditingController();
  final itemNameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final currencyController = TextEditingController(text: 'USD');

  // Danh sách các đơn hàng với dữ liệu khởi tạo sẵn
  List<Order> orders = [
    Order(item: 'A1000', itemName: 'Iphone 15', price: 1200, quantity: 1, currency: 'USD'),
    Order(item: 'A1001', itemName: 'Iphone 15', price: 1200, quantity: 1, currency: 'USD'),
    Order(item: 'A1002', itemName: 'Iphone 15', price: 1200, quantity: 1, currency: 'USD'),
    Order(item: 'A1003', itemName: 'Iphone 15', price: 1200, quantity: 1, currency: 'USD'),
  ];

  // Hàm thêm đơn hàng vào danh sách
  void _addOrder() {
    setState(() {
      orders.add(Order(
        item: itemController.text,
        itemName: itemNameController.text,
        price: double.tryParse(priceController.text) ?? 0,
        quantity: int.tryParse(quantityController.text) ?? 1,
        currency: currencyController.text,
      ));
    });
    _clearForm();
  }

  // Hàm xóa dữ liệu form sau khi thêm đơn hàng
  void _clearForm() {
    itemController.clear();
    itemNameController.clear();
    priceController.clear();
    quantityController.clear();
  }

  // Hàm xóa một đơn hàng
  void _removeOrder(int index) {
    setState(() {
      orders.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Form nhập liệu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextField(
                    controller: itemController,
                    decoration: InputDecoration(labelText: 'Item'),
                  ),
                ),
                SizedBox(width: 16),
                Flexible(
                  child: TextField(
                    controller: itemNameController,
                    decoration: InputDecoration(labelText: 'Item Name'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Price'),
                  ),
                ),
                SizedBox(width: 16),
                Flexible(
                  child: TextField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Quantity'),
                  ),
                ),
                SizedBox(width: 16),
                Flexible(
                  child: TextField(
                    controller: currencyController,
                    decoration: InputDecoration(labelText: 'Currency'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addOrder,
              child: Text('Add Item to Cart'),
            ),
            SizedBox(height: 16),
            // Bảng hiển thị danh sách đơn hàng
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Id')),
                    DataColumn(label: Text('Item')),
                    DataColumn(label: Text('Item Name')),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Price')),
                    DataColumn(label: Text('Currency')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: List.generate(
                    orders.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(Text((index + 1).toString())),
                        DataCell(Text(orders[index].item)),
                        DataCell(Text(orders[index].itemName)),
                        DataCell(Text(orders[index].quantity.toString())),
                        DataCell(Text(orders[index].price.toStringAsFixed(2))),
                        DataCell(Text(orders[index].currency)),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _removeOrder(index),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Class để quản lý thông tin đơn hàng
class Order {
  final String item;
  final String itemName;
  final double price;
  final int quantity;
  final String currency;

  Order({
    required this.item,
    required this.itemName,
    required this.price,
    required this.quantity,
    required this.currency,
  });
}
