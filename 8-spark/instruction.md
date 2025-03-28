# Instruction for VSCode

1. Install Metals extension for Scala
2. Open VSCode with *8-spark* as the root folder.
3. Download Java 11 and unpack the archive to some location (for example /opt/tools).
4. Tap Ctrl+Shift+P and open "Preferences: Open User Settings (JSON)".
5. Add this line to JSON file indicating the location of the new Java folder: `"metals.javaHome": "/opt/tools/jdk-11.0.0.2",`. This will make Metals use Java 11 (which it needs instead of Java 17).
6. Open Metals on the left side and click "Import build"
7. Once the build is done, open a scala file that you want to execute and tap F5.
8. You will see the app output on the debug console.