import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:forge_app/models/supply.dart';
import 'package:forge_app/providers/supplies_provider.dart';
import 'package:forge_app/widgets/topBarAdmin.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';

class SuppliesAdminScreen extends StatefulWidget {
  const SuppliesAdminScreen({super.key});

  @override
  State<SuppliesAdminScreen> createState() => _SuppliesAdminScreenState();
}

class _SuppliesAdminScreenState extends State<SuppliesAdminScreen> {
  void initState() {
    Provider.of<SuppliesProvider>(context, listen: false).getSupplies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final supplyProvider = Provider.of<SuppliesProvider>(context);
    List supplies = supplyProvider.supplies;

    return Scaffold(
      appBar: TopBarAdmin(),
      endDrawer: SideMenu(),
      body: SupplyList(
        supplies: supplies,
      ),
    );
  }
}

class SupplyList extends StatefulWidget {
  final List supplies;

  SupplyList({required this.supplies});

  @override
  _SupplyListState createState() => _SupplyListState();
}

class _SupplyListState extends State<SupplyList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        showBottomBorder: true,
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Cost')),
          DataColumn(label: Text('BuyUnit')),
          DataColumn(label: Text('UseUnit')),
          DataColumn(label: Text('Mesures')),
          DataColumn(label: Text('Options')),
          DataColumn(label: Text('Image')),
        ],
        rows: widget.supplies.map((supply) {
          return DataRow(
            cells: [
              DataCell(Text(supply['id'].toString())),
              DataCell(Text(supply['name'])),
              DataCell(Text('\$${supply['cost'].toStringAsFixed(2)}')),
              DataCell(Text(supply['buyUnit'])),
              DataCell(Text(supply['useUnit'])),
              DataCell(Text('\$${supply['equivalence'].toStringAsFixed(2)}')),
              DataCell(Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _showEditSupplyModal(context, supply);
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _showDeleteConfirmationModal(
                          context, supply['id'].toString());
                    },
                  ),
                ],
              )),
              DataCell(Image.memory(base64.decode(supply['image']))),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _showEditSupplyModal(BuildContext context, supply) {
    supply = Supply.fromJson(supply);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return EditSupplyModal(
          supply: supply,
          context: context,
        );
      },
    );
  }

  void _showDeleteConfirmationModal(BuildContext context, String id) {
    final supplyProvider =
        Provider.of<SuppliesProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.only(right: 90, left: 90, top: 20, bottom: 30),
          title: const Text('Delete Supply'),
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
                supplyProvider.deleteSupply(id).then((value) => {
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

class EditSupplyModal extends StatefulWidget {
  final Supply supply;
  final BuildContext context;

  EditSupplyModal({required this.supply, required this.context});

  @override
  _EditSupplyModalState createState() => _EditSupplyModalState();
}

class _EditSupplyModalState extends State<EditSupplyModal> {
  String newName = '';
  String newBuyUnit = '';
  String newUseUnit = '';
  double newEquivalence = 0.0;
  double newCost = 0.0;

  @override
  Widget build(BuildContext context) {
    final supplyProvider =
        Provider.of<SuppliesProvider>(widget.context, listen: false);
    return SingleChildScrollView(
      child: Container(
        padding:
            const EdgeInsets.only(right: 90, left: 90, top: 20, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Edit Supply',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: widget.supply.name,
              onChanged: (newValue) {
                setState(() {
                  newName = newValue;
                });
              },
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: widget.supply.cost.toString(),
              onChanged: (newValue) {
                setState(() {
                  newCost = double.parse(newValue);
                });
              },
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Precio'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: widget.supply.buyUnit,
              onChanged: (newValue) {
                setState(() {
                  newBuyUnit = newValue;
                });
              },
              decoration: const InputDecoration(labelText: 'BuyUnit'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: widget.supply.useUnit,
              onChanged: (newValue) {
                setState(() {
                  newUseUnit = newValue;
                });
              },
              decoration: const InputDecoration(labelText: 'UseUnit'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: widget.supply.equivalence.toString(),
              onChanged: (newValue) {
                setState(() {
                  newEquivalence =  double.parse(newValue);
                });
              },
              decoration: const InputDecoration(labelText: 'Equivalence'),
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
                  Supply newSupply = Supply(
                    widget.supply.id,
                    newName.isNotEmpty ? newName : widget.supply.name,
                    newCost != 0.0 ? newCost : widget.supply.cost,
                    newBuyUnit.isNotEmpty
                        ? newBuyUnit
                        : widget.supply.buyUnit,
                    newUseUnit.isNotEmpty
                        ? newUseUnit
                        : widget.supply.useUnit,
                    newEquivalence != 0.0 ? newEquivalence : widget.supply.equivalence,
                    widget.supply.image,
                  );
                  supplyProvider
                      .updateSupply(newSupply.id.toString(), newSupply)
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
        newBuyUnit.isNotEmpty ||
        newUseUnit.isNotEmpty ||
        newEquivalence != 0.0 ||
        newCost != 0.0;
  }
}
