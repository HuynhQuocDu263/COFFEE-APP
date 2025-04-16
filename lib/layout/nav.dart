import 'dart:convert';
import 'package:doanthuchanh/Page/SanPham/TrangSanPham.dart';
import 'package:doanthuchanh/Page/Trangchu/TrangChu2.dart';
import 'package:doanthuchanh/Page/auth/login.dart';
import 'package:doanthuchanh/admin/category/category_list.dart';
import 'package:doanthuchanh/admin/product/product_list.dart';
import 'package:doanthuchanh/layout/detail.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart'; // Import model user

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Future<User> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? strUser = pref.getString('user');

    if (strUser != null) {
      return User.fromJson(jsonDecode(strUser));
    } else {
      return User.userEmpty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder<User>(
            future: getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text('Error loading user data'),
                  ),
                );
              } else {
                User user = snapshot.data ?? User.userEmpty();
                return UserAccountsDrawerHeader(
                  accountName: Text(
                    user.fullName ?? 'N/A',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  accountEmail: Text(
                    user.phoneNumber ?? 'N/A',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: user.imageURL != null && user.imageURL!.isNotEmpty
                          ? Image.network(
                              user.imageURL!,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/user.png',
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://cdn.vjshop.vn/tin-tuc/cach-chup-anh-phong-canh/cach-chup-anh-phong-canh-dep-15.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
            },
          ),
          // Trang chủ
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Sản phẩm'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Scaffold(body: TrangSanPham())),
              );
            },
          ),
          // Tài khoản
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Tài khoản'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Detail()),
              );
            },
          ),
          // Quản lý loại sản phẩm
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Quản lý loại sản phẩm'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoryList()),
              );
            },
          ),
          // Quản lý sản phẩm
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Quản lý sản phẩm'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductList()),
              );
            },
          ),
          const Divider(color: Colors.black),
          FutureBuilder<User>(
            future: getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                User user = snapshot.data ?? User.userEmpty();
                if (user.accountId != '') {
                  return ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Logout'),
                    onTap: () {
                      logOut(context);
                    },
                  );
                } else {
                  return const SizedBox();
                }
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  void logOut(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('user');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
