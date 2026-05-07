import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListViewPage extends StatelessWidget {
  // Data dummy yang lebih lengkap agar list terlihat panjang
  final List<Map<String, dynamic>> items = [
    {"title": "Materi Dasar Flutter", "desc": "Instalasi dan struktur folder", "icon": Icons.star, "color": Colors.orange},
    {"title": "Stateless Widget", "desc": "Widget statis tanpa perubahan data", "icon": Icons.widgets_outlined, "color": Colors.blue},
    {"title": "Stateful Widget", "desc": "Widget dinamis yang bisa berubah", "icon": Icons.refresh, "color": Colors.green},
    {"title": "Navigation & Routing", "desc": "Berpindah antar halaman", "icon": Icons.alt_route, "color": Colors.purple},
    {"title": "ListView & GridView", "desc": "Menampilkan data secara list", "icon": Icons.view_list, "color": Colors.red},
    {"title": "Checkbox & Radio", "desc": "Input pilihan user", "icon": Icons.check_box, "color": Colors.teal},
    {"title": "Textfield Validation", "desc": "Validasi input data user", "icon": Icons.text_fields, "color": Colors.indigo},
    {"title": "Rest API / JSON", "desc": "Koneksi data ke database internet", "icon": Icons.cloud_download, "color": Colors.amber},
    {"title": "Flutter Toast", "desc": "Menampilkan notifikasi singkat", "icon": Icons.notification_important, "color": Colors.pink},
    {"title": "Final Project", "desc": "Project mandiri tugas akhir", "icon": Icons.verified_user, "color": Colors.cyan},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Daftar Materi Pertemuan',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        elevation: 5,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 10),
            child: Row(
              children: [
                Container(
                  width: 5,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ListView Materi',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Klik salah satu untuk detail materi',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // List Section
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Fluttertoast.showToast(
                        msg: "Membuka ${items[index]['title']}",
                        backgroundColor: items[index]['color'],
                        textColor: Colors.white,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          // Leading Icon dengan Container Bulat
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: items[index]['color'].withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              items[index]['icon'],
                              color: items[index]['color'],
                              size: 30,
                            ),
                          ),
                          SizedBox(width: 16),
                          
                          // Content Text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  items[index]['title'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  items[index]['desc'],
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Trailing Arrow
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Colors.grey.shade400,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}