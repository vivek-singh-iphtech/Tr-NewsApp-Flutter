import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  final Function(String)? onItemSelected; // Callback function
  const CategoryList({ Key? key, this.onItemSelected }) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

   List<ListItem> items = [
    ListItem('Business',isSelected:true),
    ListItem('Entertainment'),
    ListItem('General'),
    ListItem('Health'),
    ListItem('Science'),
    ListItem('Sports'),
    ListItem('Technology'),
  ];

   @override
  void initState() {
    super.initState();
    items[0].isSelected = true;
  }

  @override
  Widget build(BuildContext context) {
     return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  for (var listItem in items) {
                    listItem.isSelected = false;
                  }
                  item.isSelected = true;
                });

                 if (widget.onItemSelected != null) {
                  widget.onItemSelected!(item.title);
                }
                
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: item.isSelected ? Colors.red : Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item.title,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ListItem {
  final String title;
  bool isSelected;

  ListItem(this.title, {this.isSelected = false});
}
