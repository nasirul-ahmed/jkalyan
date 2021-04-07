import 'package:devbynasirulahmed/models/customer.dart';
import 'package:devbynasirulahmed/services/customer_service.dart';
import 'package:devbynasirulahmed/widgets/max_width_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllCustomers extends StatefulWidget {
  @override
  _AllCustomersState createState() => _AllCustomersState();
}

class _AllCustomersState extends State<AllCustomers> {
  Future<List<Customer>> getCustomer() async {
    final url =
        Uri.parse('https://sanchay-new.herokuapp.com/api/agents/customers');

    try {
      var res = await http.get(url, headers: {"Accept": "application/json"});
      if (200 == res.statusCode) {
        return compute(parseCustomer, res.body);
      }
      return List<Customer>.empty();
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget listTileBulder(doc) {
      return Container(
        child: new ListTile(
          hoverColor: Colors.grey[300],
          leading: CircleAvatar(
            child: Icon(Icons.person_rounded),
          ),
          onTap: () {
            //print(doc.id);
            //Navigator.pushNamed(context, CSTransaction.id);
          },
          title: Text(
            "${doc.name}",
            style: TextStyle(fontSize: 20.0),
          ),
          subtitle: Text(
            'A/c: ${doc.accountNumber.toString()}',
            style: TextStyle(fontSize: 16),
          ),
          trailing: Container(
            child: Text('₹ ${doc.totalPrincipalAmount.toString()}'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('All Customers'),
        backgroundColor: Colors.orange[800],
      ),
      body: MaxWidthContainer(
        child: FutureBuilder<List<Customer>>(
          future: getCustomer(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text(snapshot.error.toString());

            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, idx) {
                      // return Text('${snapshot.data?[idx].name}');
                      return listTileBulder(snapshot.data?[idx]);
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
