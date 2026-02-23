MergeSemantics Demo

This project demonstrates the MergeSemantics widget, which groups multiple widgets into a single semantic node for improved accessibility.

How to Run
1. Make sure you have Flutter installed.
2. Clone this repository:
   `git clone https://github.com/SLICKMAN-TYRUS/merged_semantics_demo.git`
3. Open a terminal in the project folder.
4. Run `flutter pub get`.
5. Run `flutter run`.
6. Use a screen reader (TalkBack or VoiceOver) to test the difference between merged and unmerged rows.

## Attributes Demonstrated
1. enabled (implemented via logic): MergeSemantics itself doesn't have an "enabled" property, so I implemented a toggle that conditionally wraps the subtree. This lets you switch merging on and off to hear the difference.
2. child: The widget subtree that gets merged. I used a Row containing an icon, text, and a switch as the child of the MergeSemantics widget.
3. key: An identifier for widgets. I used a ValueKey to help Flutter identify the widget across rebuilds which is good practice for state stability.

## Screenshot
![App Screenshot](screenshot.png)
*(Note: I need to add the screenshot file to the repo before submission)*
