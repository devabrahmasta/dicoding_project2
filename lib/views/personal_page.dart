import 'package:flutter/material.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Akun Saya',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey.shade200,
                      child: Icon(
                        Icons.person_rounded,
                        size: 40,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    title: Text(
                      'Dicoding',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w900),
                    ),
                    subtitle: Row(
                      children: [
                        Text('+62 812-3456-7890'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Lainnya',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            _buildMenuItem(Icons.confirmation_number_outlined, 'Voucher Saya'),
            _buildMenuItem(Icons.movie_outlined, 'Film Saya'),
            _buildMenuItem(Icons.thumb_up_alt_outlined, 'Konten Yang Disukai'),

            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Pengaturan Akun',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            _buildMenuItem(Icons.lock_outline_rounded, 'Ubah Password'),
            _buildMenuItem(Icons.help_outline_rounded, 'Bantuan'),
            _buildMenuItem(Icons.logout_rounded, 'Keluar Akun'),

          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String text) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 4,
          ),
          leading: Icon(icon, color: Colors.grey.shade400, size: 24),
          title: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
        ),
        Divider(height: 1, color: Colors.grey.shade200),
      ],
    );
  }
}