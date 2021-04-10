import 'package:devbynasirulahmed/models/api_response.dart';
import 'package:devbynasirulahmed/models/customer.dart';
import 'package:devbynasirulahmed/services/last_customer.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EditCustomer extends StatefulWidget {
  //Customer? customer;
  @override
  _EditCustomerState createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  LastCustomerAddedService get service => GetIt.I<LastCustomerAddedService>();
  ApiResponse<Customer>? _apiResponse;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    fetchCustomer();
  }

  fetchCustomer() async {
    setState(() {
      isLoading = true;
    });

    _apiResponse = await service.getLastCustomer();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Builder(builder: (_) {
        if (isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (_apiResponse!.err!) {
          return Center(
            child: Text("${_apiResponse?.errorMsg}"),
          );
        }
        return Center(
          child: Text('ac no: ${_apiResponse?.data?.accountNumber}'),
        );
      }),
    );
  }
}
