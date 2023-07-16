import 'package:flutter/material.dart';

enum AppMenu { setup, privacy, settings, log }

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        Builder(
          builder: (context) => IconButton(
            style:
                enabledFilledButtonStyle(true, Theme.of(context).colorScheme),
            icon: const Icon(Icons.menu_rounded),
            onPressed: () {
              showMenu(
                context: context,
                color: Theme.of(context).popupMenuTheme.color,
                shadowColor: Theme.of(context).popupMenuTheme.shadowColor,
                position:
                    const RelativeRect.fromLTRB(1000, kToolbarHeight, 0, 0),
                items: <PopupMenuEntry<AppMenu>>[
                  const PopupMenuItem<AppMenu>(
                    value: AppMenu.setup,
                    child: Text('Setup'),
                  ),
                  const PopupMenuItem<AppMenu>(
                    value: AppMenu.privacy,
                    child: Text('Privacy Policy'),
                  ),
                  const PopupMenuItem<AppMenu>(
                    value: AppMenu.settings,
                    child: Text('Settings'),
                  ),
                  const PopupMenuItem<AppMenu>(
                    value: AppMenu.log,
                    child: Text('Schedule'),
                  ),
                ],
              ).then((result) {
                if (result != null) {
                  switch (result) {
                    case AppMenu.setup:
                      Navigator.of(context).pushNamed('/setup');
                      break;
                    case AppMenu.privacy:
                      Navigator.of(context).pushNamed('/privacy');
                      break;
                    case AppMenu.settings:
                      Navigator.of(context).pushNamed('/settings');
                      break;
                    case AppMenu.log:
                      Navigator.of(context).pushNamed('/log');
                      break;
                  }
                }
              });
            },
          ),
        )
      ],
      scrolledUnderElevation: 4.0,
      shadowColor: Theme.of(context).shadowColor,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: const Center(
        child: CircleAvatar(
          radius: 16,
          child: Icon(Icons.medication_rounded),
        ),
      ),
    );
  }

  ButtonStyle enabledFilledButtonStyle(bool selected, ColorScheme colors) {
    return IconButton.styleFrom(
      foregroundColor: selected ? colors.onPrimary : colors.primary,
      backgroundColor: selected ? colors.primary : colors.surfaceVariant,
      disabledForegroundColor: colors.onSurface.withOpacity(0.38),
      disabledBackgroundColor: colors.onSurface.withOpacity(0.12),
      hoverColor: selected
          ? colors.onPrimary.withOpacity(0.08)
          : colors.primary.withOpacity(0.08),
      focusColor: selected
          ? colors.onPrimary.withOpacity(0.12)
          : colors.primary.withOpacity(0.12),
      highlightColor: selected
          ? colors.onPrimary.withOpacity(0.12)
          : colors.primary.withOpacity(0.12),
    );
  }
}
