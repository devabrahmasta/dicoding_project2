import 'package:flutter/material.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Akun Saya', style: Theme.of(context).textTheme.titleLarge),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    subtitle: const Row(children: [Text('+62 812-3456-7890')]),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Lainnya',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w900),
                textAlign: TextAlign.left,
              ),
            ),
            _buildMenuItem(
              context,
              Icons.confirmation_number_outlined,
              'Voucher Saya',
            ),
            _buildMenuItem(context, Icons.movie_outlined, 'Film Saya'),
            _buildMenuItem(
              context,
              Icons.thumb_up_alt_outlined,
              'Konten Yang Disukai',
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Pengaturan Akun',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w900),
                textAlign: TextAlign.left,
              ),
            ),
            _buildMenuItem(
              context,
              Icons.lock_outline_rounded,
              'Ubah Password',
            ),
            _buildMenuItem(context, Icons.help_outline_rounded, 'Bantuan'),
            _buildMenuItem(context, Icons.logout_rounded, 'Keluar Akun'),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String text) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Menu $text sedang dalam pengembangan!'),
                duration: const Duration(seconds: 1),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            );
          },
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 4,
          ),
          leading: Icon(icon, color: Colors.grey.shade400, size: 24),
          title: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 12,
            color: Colors.grey,
          ),
        ),
        Divider(height: 1, color: Colors.grey.shade200),
      ],
    );
  }
}
