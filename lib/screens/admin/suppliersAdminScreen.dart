import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:forge_app/models/supplier.dart';
import 'package:forge_app/providers/suppliers_provider.dart';
import 'package:forge_app/widgets/topBarAdmin.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';

class SuppliersAdminScreen extends StatefulWidget {
  const SuppliersAdminScreen({super.key});

  @override
  State<SuppliersAdminScreen> createState() => _SuppliersAdminScreenState();
}

class _SuppliersAdminScreenState extends State<SuppliersAdminScreen> {
  void initState() {
    Provider.of<SuppliersProvider>(context, listen: false).getSuppliers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final supplierProvider = Provider.of<SuppliersProvider>(context);
    List suppliers = supplierProvider.suppliers;

    return Scaffold(
      appBar: TopBarAdmin(),
      endDrawer: SideMenu(),
      body: SupplierList(
        suppliers: suppliers,
      ),
    );
  }
}

class SupplierList extends StatefulWidget {
  final List suppliers;

  SupplierList({required this.suppliers});

  @override
  _SupplierListState createState() => _SupplierListState();
}

class _SupplierListState extends State<SupplierList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        showBottomBorder: true,
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Phone')),
          DataColumn(label: Text('Options')),
        ],
        rows: widget.suppliers.map((supplier) {
          return DataRow(
            cells: [
              DataCell(Text(supplier['id'].toString())),
              DataCell(Text(supplier['name'])),
              DataCell(Text(supplier['email'])),
              DataCell(Text(supplier['phone'])),
              DataCell(Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _showEditSupplierModal(context, supplier);
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _showDeleteConfirmationModal(
                          context, supplier['id'].toString());
                    },
                  ),
                ],
              )),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _showEditSupplierModal(BuildContext context, supplier) {
    supplier = Supplier.fromJson(supplier);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return EditSupplierModal(
          supplier: supplier,
          context: context,
        );
      },
    );
  }

  void _showDeleteConfirmationModal(BuildContext context, String id) {
    final supplierProvider =
        Provider.of<SuppliersProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.only(right: 90, left: 90, top: 20, bottom: 30),
          title: const Text('Delete Supplier'),
          content: const Text('Are you sure you want to proceed?'),
          actions: [
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
              ),
              label: Text('Accept'),
              icon: Icon(Icons.done, color: Colors.white,),
              onPressed: () {
                Navigator.of(context).pop();
                supplierProvider.deleteSupplier(id).then((value) => {
                      if (value)
                        {
                          Flushbar(
                            message: "Deleted Successfuly",
                            icon: Icon(
                              Icons.error,
                              size: 28.0,
                              color: Colors.green,
                            ),
                            duration: Duration(seconds: 3),
                            leftBarIndicatorColor: Colors.green,
                          )..show(context)
                        }
                      else
                        {
                          Flushbar(
                            message: "Error While Deleting",
                            icon: Icon(
                              Icons.error,
                              size: 28.0,
                              color: Colors.red,
                            ),
                            duration: Duration(seconds: 3),
                            leftBarIndicatorColor: Colors.red,
                          )..show(context)
                        }
                    });
              },
            ),

            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.white70),
              ),
              label: Text('Cancel', style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              icon: Icon(Icons.do_disturb, color: Colors.black,),
            ),
            
          ],
        );
      },
    );
  }
}

class EditSupplierModal extends StatefulWidget {
  final Supplier supplier;
  final BuildContext context;

  EditSupplierModal({required this.supplier, required this.context});

  @override
  _EditSupplierModalState createState() => _EditSupplierModalState();
}

class _EditSupplierModalState extends State<EditSupplierModal> {
  String newName = '';
  String newEmail = '';
  String newPhone= '';

  @override
  Widget build(BuildContext context) {
    final supplierProvider =
        Provider.of<SuppliersProvider>(widget.context, listen: false);
    return SingleChildScrollView(
      child: Container(
        padding:
            const EdgeInsets.only(right: 90, left: 90, top: 20, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Edit Supplier',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: widget.supplier.name,
              onChanged: (newValue) {
                setState(() {
                  newName = newValue;
                });
              },
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: widget.supplier.email,
              onChanged: (newValue) {
                setState(() {
                  newEmail = newValue;
                });
              },
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: widget.supplier.phone,
              onChanged: (newValue) {
                setState(() {
                  newPhone= newValue;
                });
              },
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
              ),
              label: Text('Save'),
              icon: Icon(Icons.save, color: Colors.white,),
              onPressed: () {
                if (_dataHasChanged()) {
                  Supplier newSupplier = Supplier(
                    widget.supplier.id,
                    newName.isNotEmpty ? newName : widget.supplier.name,
                    newEmail.isNotEmpty
                        ? newEmail
                        : widget.supplier.email,
                    newPhone.isNotEmpty
                        ? newPhone
                        : widget.supplier.phone,
                  );
                  supplierProvider
                      .updateSupplier(newSupplier.id.toString(), newSupplier)
                      .then((value) => {
                            if (value)
                              {
                                Flushbar(
                                  message: "Updated Successfuly",
                                  icon: Icon(
                                    Icons.error,
                                    size: 28.0,
                                    color: Colors.green,
                                  ),
                                  duration: Duration(seconds: 3),
                                  leftBarIndicatorColor: Colors.green,
                                )..show(context)
                              }
                            else
                              {
                                Flushbar(
                                  message: "Error While Updating",
                                  icon: Icon(
                                    Icons.error,
                                    size: 28.0,
                                    color: Colors.red,
                                  ),
                                  duration: Duration(seconds: 3),
                                  leftBarIndicatorColor: Colors.red,
                                )..show(context)
                              }
                          });
                } else {
                  print("No changes to save.");
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  bool _dataHasChanged() {
    return newName.isNotEmpty ||
        newEmail.isNotEmpty ||
        newPhone.isNotEmpty;
  }
}
