import 'package:flutter/material.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    required this.text,
    this.icon = Icons.search_outlined,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: showBackground ? Color(0xFFFFFFFF) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: showBorder ? Border.all(color: Color(0xFFE0E0E0)) : null
          ),
          child: Row(
            children: [
              Icon(icon, color: Color(0xFF4F4F4F)),
              const SizedBox(width: 16),
              Text(text, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
