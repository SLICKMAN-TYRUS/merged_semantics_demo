# MergeSemantics Demo

A Flutter application demonstrating the use of the `MergeSemantics` widget to improve accessibility for screen readers.

![App Screenshot](screenshot.png)

## Overview

This application serves as a practical demonstration of how `MergeSemantics` affects the accessibility tree in Flutter. It features a settings-style interface with interactive rows (Notifications Switch, Special Offers Checkbox). Users can toggle "Merge Mode" on and off to hear the difference in how screen readers (TalkBack/VoiceOver) announce the UI elements.

*   **Merge Mode ON**: The entire row (Label + State + Interactive Element) is announced as a single focusable node ("Notifications, On, Switch").
*   **Merge Mode OFF**: Each element in the row is focusable individually ("Notifications", then "On", then "Switch"), which can be tedious for users.

## The Widget: MergeSemantics

The `MergeSemantics` widget is an accessibility tool that groups the semantics of its descendants into a single semantic node. This is crucial for creating tap targets that feel like native list items.

### Key Properties & Concepts

1.  **`child`**:
    *   **Description**: The widget subtree that contains the elements to be merged.
    *   **Usage**: In this demo, we wrap a `Row` containing text and a switch/checkbox. This causes the screen reader to treat the entire row as one interactive button.

2.  **`enabled` (Logic Implementation)**:
    *   **Note**: The `MergeSemantics` class strictly merges its children. It does not have a boolean "enabled" property to turn it off dynamically.
    *   **implementation**: To demonstrate the "Before vs After" effect, we implemented a logic toggle in `lib/main.dart`.
    ```dart
    if (mergeEnabled) {
      return MergeSemantics(child: content);
    } else {
      return content;
    }
    ```

3.  **`key`**:
    *   **Description**: A standard widget property.
    *   **Usage**: Controls how one widget replaces another widget in the tree. We use a `ValueKey` to ensure the framework correctly updates the widget when toggling merge modes.

## Code Implementation

Below is the core logic used in `lib/main.dart` to create the accessible notification row.

```dart
// Example of wrapping a complex row in MergeSemantics
MergeSemantics(
  child: InkWell(
    onTap: () {
       // Tapping anywhere on the row toggles the switch
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

## Features & Creativity

1.  **Material 3 Design**: Uses the latest Material Design specifications for cards, switches, and colors.
2.  **Custom Typography**: Integrates `google_fonts` (Montserrat) for a modern, clean aesthetic.
3.  **Interactive State**: Shows real-time feedback using SnackBars and state updates.
4.  **Educational Control Panel**: A dedicated "Merge Mode" toggle allows for immediate A/B testing of accessibility features.

## Repository Structure

```
merged_semantics_demo/
├── lib/
│   └── main.dart        # Entry point and complete demo logic
├── pubspec.yaml         # Dependencies (flutter, google_fonts)
├── README.md            # Project documentation
└── screenshot.png       # visual demonstration
```

## How to Run

1.  **Prerequisites**: Ensure you have Flutter installed and set up on your machine.
2.  **Clone the Repository**:
    ```bash
    git clone https://github.com/SLICKMAN-TYRUS/merged_semantics_demo.git
    cd merged_semantics_demo
    ```
3.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```
4.  **Run the App**:
    ```bash
    flutter run
    ```
5.  **Test Accessibility**:
    *   Enable your device's screen reader (TalkBack on Android, VoiceOver on iOS).
    *   Toggle the "Merge Mode" switch to hear the difference in navigation.
