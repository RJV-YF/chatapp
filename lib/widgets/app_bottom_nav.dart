import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AppBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChange;

  const AppBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      elevation: 8,
      color: theme.scaffoldBackgroundColor,
      child: SafeArea(
        top: false,
        child: GNav(
          selectedIndex: selectedIndex,
          onTabChange: onTabChange,
          gap: 6,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          tabBorderRadius: 14,
          backgroundColor: Colors.transparent,
          color: Colors.grey[600],
          activeColor: theme.primaryColor,
          tabBackgroundColor: theme.primaryColor.withValues(alpha: 0.12),
          tabs: const [
            GButton(icon: Icons.chat_bubble_outline, text: 'Chats'),
            GButton(icon: Icons.search, text: 'Search'),
            GButton(icon: Icons.person_outline, text: 'Profile'),
          ],
        ),
      ),
    );
  }
}
