import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AutocompleteSpinPage extends StatefulWidget {
  @override
  _AutocompleteSpinPageState createState() => _AutocompleteSpinPageState();
}

class _AutocompleteSpinPageState extends State<AutocompleteSpinPage> {
  // Data dummy untuk Autocomplete
  final List<String> _daftarProvinsi = [
    'Aceh',
    'Bali',
    'Banten',
    'Bengkulu',
    'Gorontalo',
    'Jakarta',
    'Jambi',
    'Jawa Barat',
    'Jawa Tengah',
    'Jawa Timur',
    'Kalimantan Barat',
    'Lampung',
    'Maluku',
    'Papua',
    'Riau',
    'Sulawesi Selatan',
    'Sumatera Utara',
  ];

  // Data dummy untuk Spinner (Dropdown)
  final List<String> _daftarProdi = [
    'Teknik Informatika',
    'Sistem Informasi',
    'Sains Data',
    'Teknik Komputer',
  ];

  String? _selectedProvinsi;
  String? _selectedProdi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Autocomplete & Spinner',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Autocomplete
            _buildHeader(
              'Pilih Provinsi (Autocomplete)',
              Colors.blueAccent,
              Icons.map,
            ),
            SizedBox(height: 12),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    return _daftarProvinsi.where((String option) {
                      return option.toLowerCase().contains(
                        textEditingValue.text.toLowerCase(),
                      );
                    });
                  },
                  onSelected: (String selection) {
                    setState(() => _selectedProvinsi = selection);
                    Fluttertoast.showToast(msg: "Terpilih: $selection");
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onFieldSubmitted) {
                        return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            hintText: 'Ketik nama provinsi...',
                            border: InputBorder.none,
                            icon: Icon(Icons.search, color: Colors.blueAccent),
                          ),
                        );
                      },
                ),
              ),
            ),

            SizedBox(height: 32),

            // Section Spinner (Dropdown)
            _buildHeader(
              'Program Studi (Spinner)',
              Colors.indigo,
              Icons.school,
            ),
            SizedBox(height: 12),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text('Pilih Program Studi'),
                    value: _selectedProdi,
                    icon: Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.indigo,
                    ),
                    items: _daftarProdi.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() => _selectedProdi = val);
                    },
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),

            // Button Submit
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showSummary,
                icon: Icon(Icons.send),
                label: Text(
                  'SUBMIT DATA',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade700,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title, Color color, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }

  void _showSummary() {
    if (_selectedProvinsi == null || _selectedProdi == null) {
      Fluttertoast.showToast(
        msg: "Harap isi semua data!",
        backgroundColor: Colors.red,
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Ringkasan Pilihan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(height: 30),
              ListTile(
                leading: Icon(Icons.location_on, color: Colors.purple),
                title: Text('Provinsi'),
                trailing: Text(
                  _selectedProvinsi!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Icon(Icons.school, color: Colors.indigo),
                title: Text('Program Studi'),
                trailing: Text(
                  _selectedProdi!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Tutup'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 45),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
