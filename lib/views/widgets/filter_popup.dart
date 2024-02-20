import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/EverythingNews_provider.dart';
import 'package:intl/intl.dart';

class FilterPopup extends StatefulWidget {

  FilterPopup(this.query, String toDate, String fromDate, String sortBy, {Key? key})
      : super(key: key);
    final String query;

  @override
  State<FilterPopup> createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
   
  String toDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  String fromDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  String sortBy = 'relevancy';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          width: 90,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close_rounded),
                      iconSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Text(
                'Select Filters',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                title: Text('To: $toDate',),
                trailing: Icon(
                  Icons.calendar_today,
                ),
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.parse(toDate),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        
                      toDate = value.toString();
                      });
                    }
                  });
                },
              ),
              ListTile(
                title: Text('From: $fromDate',),
                trailing: Icon(Icons.calendar_today),
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.parse(fromDate),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                      fromDate = value.toString();
                        
                      });
                    }
                  });
                },
              ),
              ListTile(
                title: Text('Sort Articles'),
                trailing: DropdownButton<String>(
                  value: sortBy,
                  items: <String>['relevancy', 'popularity', 'publishedAt']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                     setState(() {
                       
                      sortBy = value!;
                    
                     });
                  },
                ),
              ),
              SizedBox(height: 10),

              ApplyFilter(widget.query,toDate,fromDate,sortBy),
              
             
            ],
          ),
        ),
      ),
    );
  }
}

class ApplyFilter extends ConsumerWidget {
final String query;
final String toDate;
final String fromDate;
final String sortBy;
const ApplyFilter(this.query, this.toDate, this.fromDate, this.sortBy, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // Background color
                ),
                onPressed: () {
                  final everydayNews = ref.read(Everythingnewsprovider);
                 everydayNews.fetchEveryNews(query, toDate, fromDate, sortBy);
                  // Perform filtering or any other action
                  Navigator.of(context).pop();
                  print(toDate);
                  print(fromDate);
                  print(sortBy);
                  print(query);
                },
                child: Text(
                  'Apply Filters',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ) ;
  }
}
