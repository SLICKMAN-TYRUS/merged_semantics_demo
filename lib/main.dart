import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

/// Root of the app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MergeSemantics Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: const MergeSemanticsDemoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Main screen that demonstrates MergeSemantics with a notifications row.
class MergeSemanticsDemoScreen extends StatefulWidget {
  const MergeSemanticsDemoScreen({super.key});

  @override
  State<MergeSemanticsDemoScreen> createState() =>
      MergeSemanticsDemoScreenState();
}

class MergeSemanticsDemoScreenState extends State<MergeSemanticsDemoScreen> {
  bool notificationsEnabled = true; // state of the notifications switch
  bool marketingEnabled = false; // state of the marketing/news switch
  bool mergeEnabled = true; // state of MergeSemantics.enabled

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MergeSemantics Demo'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Intro + toggle for MergeSemantics.enabled
            buildHeaderSection(),

            const Spacer(),

            // Demo card area
            buildSettingsCard(),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  /// Top section: Clean and focused control panel.
  Widget buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Text(
            'MergeSemantics Demo',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 16),
          // Clean Toggle Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Theme.of(context).dividerColor.withOpacity(0.2),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Merge Mode: ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Switch(
                  value: mergeEnabled,
                  onChanged: (value) {
                    setState(() {
                      mergeEnabled = value;
                    });
                    showSnackBar(
                      mergeEnabled ? 'Merging ENABLED' : 'Merging DISABLED',
                    );
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  mergeEnabled ? 'ON' : 'OFF',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: mergeEnabled ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Card that visually groups one or more settings.
  Widget buildSettingsCard() {
    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Settings',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tap rows to test accessibility',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            buildNotificationsRow(),
            const Divider(height: 1, indent: 16, endIndent: 16),
            buildMarketingRow(),
          ],
        ),
      ),
    );
  }

  /// This is where we create the row content.
  /// When merged is FALSE, this returns a typical Row where each part is separate.
  /// When merged is TRUE, this entire tree is wrapped in MergeSemantics.
  Widget buildNotificationsRow() {
    // 1. The Switch Widget
    final Widget switchWidget = Switch(
      value: notificationsEnabled,
      onChanged: (value) {
        setState(() {
          notificationsEnabled = value;
        });
        showSnackBar(
          notificationsEnabled
              ? 'Switch toggled: Notifications ON'
              : 'Switch toggled: Notifications OFF',
        );
      },
    );

    // 2. The Text Column (Static)
    final Widget textInfo = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Notifications',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              // Extra Component 1: A visual "Badge"
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'PRIORITY',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Extra Component 2: Subtitle
          Text(
            notificationsEnabled
                ? 'Email and push alerts are ON'
                : 'Email and push alerts are OFF',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 2),
             // Extra Component 3: Status text
           Text(
            notificationsEnabled ? 'Synced with server' : 'Paused',
            style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.outline),
          ),
        ],
      ),
    );

    // 3. The Icon (Static)
    final Widget icon = Icon(
      notificationsEnabled ? Icons.notifications_active : Icons.notifications_off_outlined,
      size: 24,
      color: Theme.of(context).colorScheme.primary,
    );

    // --- CONSTRUCTION ---

    // attribute 1: enabled (conceptual)
    // MergeSemantics does not have an 'enabled' property.
    // Instead, we simulate this by conditionally wrapping or not wrapping the widget.
    if (!mergeEnabled) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        // Without MergeSemantics, this ink splash only appears on the switch
        child: Row(
          children: [
            icon,
            const SizedBox(width: 16),
            textInfo,
            const SizedBox(width: 8),
            switchWidget,
          ],
        ),
      );
    }

    // If merging is ENABLED, we return the widget tree wrapped in MergeSemantics.
    // This demonstrates the three key attributes:
    return MergeSemantics(
      // attribute 3: key
      // Maintains widget identity across rebuilds, essential for accessibility focus stability.
      key: const ValueKey('notifications-merge'),

      // attribute 2: child
      // The widget subtree to be merged. Here, it's the entire interactive row (Icon + Text + Switch).
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              notificationsEnabled = !notificationsEnabled;
            });
            showSnackBar(
              notificationsEnabled
                  ? 'Row tapped: Notifications ON'
                  : 'Row tapped: Notifications OFF',
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                icon,
                const SizedBox(width: 16),
                textInfo,
                // We wrap the switch in IgnorePointer so screen readers don't see it as a separate interactivity.
                // The whole row becomes the button.
                const SizedBox(width: 8),
                IgnorePointer(child: switchWidget),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Second example row: Data Usage / Marketing
  Widget buildMarketingRow() {
    // 1. Checkbox Widget
    final Widget checkboxWidget = Checkbox(
      value: marketingEnabled,
      onChanged: (value) {
        setState(() {
          marketingEnabled = value ?? false;
        });
        showSnackBar(
          marketingEnabled
              ? 'Checkbox toggled: Marketing ON'
              : 'Checkbox toggled: Marketing OFF',
        );
      },
    );

    // 2. Text Column
    final Widget textInfo = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Special Offers',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'NEW',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            marketingEnabled
                ? 'You will receive weekly promo emails.'
                : 'You are opted out of promo emails.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );

    // 3. Icon
    final Widget icon = Icon(
      Icons.local_offer_outlined,
      size: 24,
      color: Theme.of(context).colorScheme.tertiary,
    );

    // --- CONSTRUCTION ---

    if (!mergeEnabled) {
      // Unmerged: Click icon, text, checkbox separately.
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 16),
            textInfo,
            const SizedBox(width: 8),
            checkboxWidget,
          ],
        ),
      );
    }

    // Merged: Whole row is clickable.
    return MergeSemantics(
      key: const ValueKey('marketing-merge'),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              marketingEnabled = !marketingEnabled;
            });
            showSnackBar(
              marketingEnabled
                  ? 'Row tapped: Marketing ON'
                  : 'Row tapped: Marketing OFF',
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                icon,
                const SizedBox(width: 16),
                textInfo,
                const SizedBox(width: 8),
                // Wrap checkbox in IgnorePointer so it's not a separate target
                IgnorePointer(child: checkboxWidget),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
