import 'package:flutter/material.dart';
import 'package:forge_app/models/user.dart';
import 'package:forge_app/providers/users_provider.dart';
import 'package:forge_app/widgets/topBarAdmin.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';

class UsersAdminScreen extends StatefulWidget {
  const UsersAdminScreen({super.key});

  @override
  State<UsersAdminScreen> createState() => _UsersAdminScreenState();
}

class _UsersAdminScreenState extends State<UsersAdminScreen> {
  void initState() {
    Provider.of<UsersProvider>(context, listen: false).getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context);
    List users = userProvider.users;
    return Scaffold(
      appBar: TopBarAdmin(),
      endDrawer: SideMenu(),
      body: UserList(
        users: users,
      ),
    );
  }
}

class UserList extends StatefulWidget {
  final List users;

  UserList({required this.users});

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        showBottomBorder: true,
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Phone')),
          DataColumn(label: Text('Options')),
        ],
        rows: widget.users.map((user) {
          return DataRow(
            cells: [
              DataCell(Text(user['id'].toString())),
              DataCell(Text(user['email'])),
              DataCell(Text(user['role'])),
              DataCell(Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _showEditUserModal(context, user);
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _showDeleteConfirmationModal(
                          context, user['id'].toString());
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

  void _showEditUserModal(BuildContext context, user) {
    user = User.fromJson(user);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return EditUserModal(
          user: user,
          context: context,
        );
      },
    );
  }

  void _showDeleteConfirmationModal(BuildContext context, String id) {
    final userProvider = Provider.of<UsersProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.only(right: 90, left: 90, top: 20, bottom: 30),
          title: const Text('Delete User'),
          content: const Text('Are you sure you want to proceed?'),
          actions: [
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
              ),
              label: Text('Accept'),
              icon: Icon(
                Icons.done,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                userProvider.deleteUser(id).then((value) => {
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
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.white70),
              ),
              label: Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              icon: Icon(
                Icons.do_disturb,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}

class EditUserModal extends StatefulWidget {
  final User user;
  final BuildContext context;

  EditUserModal({required this.user, required this.context});

  @override
  _EditUserModalState createState() => _EditUserModalState();
}

class _EditUserModalState extends State<EditUserModal> {
  String newEmail = '';
  String newRole = '';

  @override
  Widget build(BuildContext context) {
    final userProvider =
        Provider.of<UsersProvider>(widget.context, listen: false);
    return SingleChildScrollView(
      child: Container(
        padding:
            const EdgeInsets.only(right: 90, left: 90, top: 20, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Edit User',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: widget.user.email,
              onChanged: (newValue) {
                setState(() {
                  newEmail = newValue;
                });
              },
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _dataHasChanged() ? newRole : widget.user.role,
              onChanged: (newValue) {
                setState(() {
                  newRole = newValue ?? 'admin';
                });
              },
              items: const [
                DropdownMenuItem<String>(
                  value: 'admin',
                  child: Text('Admin'),
                ),
                DropdownMenuItem<String>(
                  value: 'seller',
                  child: Text('Seller'),
                ),
                DropdownMenuItem<String>(
                  value: 'stocker',
                  child: Text('Stocker'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
              ),
              label: Text('Save'),
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              onPressed: () {
                if (_dataHasChanged()) {
                  User newUser = User(
                    widget.user.id,
                    newEmail.isNotEmpty ? newEmail : widget.user.email,
                    newRole.isNotEmpty ? newRole : widget.user.role,
                  );
                  userProvider
                      .updateUser(newUser.id.toString(), newUser)
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
    return newEmail.isNotEmpty || newRole.isNotEmpty;
  }
}
