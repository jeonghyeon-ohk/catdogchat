import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  final BoxDecoration sectionDecoration = BoxDecoration(
    border: Border(
      top: BorderSide(color: Colors.grey[300]!),
      bottom: BorderSide(color: Colors.grey[300]!),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '마이페이지',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSection(sectionDecoration: sectionDecoration),
            _buildDivider(),
            _buildSection(sectionDecoration: sectionDecoration),
            _buildDivider(),
            _buildSection(sectionDecoration: sectionDecoration),
            _buildDivider(),
            _buildSection(sectionDecoration: sectionDecoration),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1.0,
      color: Colors.grey[300],
    );
  }
}

class _buildSection extends StatelessWidget {
  final BoxDecoration sectionDecoration;
  const _buildSection({
    required this.sectionDecoration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: sectionDecoration,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 12.0,
        ),
        child: Center(
          child: Text(
            'example',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
