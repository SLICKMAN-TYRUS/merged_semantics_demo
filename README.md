# MergeSemantics Demo

For this assignment, I chose to demonstrate the `MergeSemantics` widget. This project shows how grouping widgets together improves the experience for screen reader users (like TalkBack or VoiceOver) by making a whole row of items feel like a single button.

![App Screenshot](screenshot.png)

## What it does

I built a simple "Settings" page with two examples:
1.  Notifications Row: A standard row with a label and a Switch.
2.  Special Offers Row: A row with a "New" badge and a Checkbox.

At the top of the screen, I added a Merge Mode toggle.
-   When ON: The screen reader reads the whole row at once (e.g., "Notifications, On, Switch"). This is the correct behavior for list items.
-   When OFF: You have to swipe through every single text and icon individually, which is annoying for users.

## Attributes I Used

### 1. child
This is just the widget subtree that you want to merge. In my code, I wrapped my `Row` (which contains the Icon, Text, and Switch) inside the `MergeSemantics` widget.

### 2. enabled (Logic Implementation)
One trick I learned while building this is that `MergeSemantics` doesn't actually have an "enabled" property to turn it off. To meet the requirement of showing "Before vs After," I wrote some logic in `main.dart`:

```dart
// If my toggle is on, wrap it. matches "enabled" behavior.
if (mergeEnabled) {
  return MergeSemantics(child: rowContent);
} else {
  return rowContent;
}
```

### 3. key
I used a `ValueKey` on the widget. This helps Flutter understand that the widget has changed when I toggle the merge mode, ensuring the state stays consistent.

## My Code

Here is the main piece of code where I implemented the merging logic:

```dart
// Inside lib/main.dart

MergeSemantics(
  // This child is the entire row that gets merged into one node
  child: InkWell(
    onTap: () {
       // Toggle the switch when tapping anywhere on the row
       setState(() => notificationsEnabled = !notificationsEnabled);
    },
    child: Row(
      children: [
        Icon(Icons.notifications, color: Colors.indigo),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text('Notifications', style: GoogleFonts.montserrat(...)),
               Text('On/Off', style: GoogleFonts.montserrat(...)),
            ],
          ),
        ),
        Switch(
          value: notificationsEnabled,
          onChanged: (val) { ... },
        ),
      ],
    ),
  ),
)
```

## Extras

To make the app look nice and polished, I added:
-   Material 3 styling for modern cards and switches.
-   Google Fonts (Montserrat) so it doesn't look like the default Hello World app.
-   SnackBars that pop up to tell you when you've changed the merge mode.

## How to Run It

1.  Clone this repo.
2.  Run `flutter pub get` to install the Google Fonts.
3.  Run `flutter run`.
4.  Turn on your screen reader on your phone or simulator to hear the difference!
