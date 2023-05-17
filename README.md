# Allergen Detector
# Introduction
The Allergen Detector is a project developed by Khushboo Gupta, Will Olson, Nanki Sekhon, and Megan Wiser for COEN174. The project is an iOS app that scans menu text using the user's camera, analyzes for potential allergens selected by the user, and displays menu recommendations.

# This README provides instructions on how to run the current version of the Allergen Detector project.

Prerequisites
Ensure that you have the following prerequisites installed on your machine:

Xcode (Version 14.3)
iOS (16.2)
Swift (5)

# Repository Branches
The Allergen Detector project consists of several branches in the repository. Each branch serves a different purpose. Here is a description of the available branches:

main: Contains the SwiftUI code for the iOS app that scans text using the user's camera and exports it to a text file. It also includes the Python script that interacts with ChatGPT and generates a data frame.
Vision: Contains the SwiftUI code for an alternative version of the iOS app that takes a photo upload input and scans text from the uploaded image.
xcode-megan: Contains the SwiftUI code for an iOS app that uses the device's camera to scan text in real-time and display it on the screen. The scanned text is then sent to a text file.
backend: Contains the Python script responsible for feeding queries to ChatGPT and generating a data frame as output.
Building and Running the iOS App
To build and run the iOS app, follow these steps:

Clone the repository to your local machine:
git clone <https://github.com/1nsekhon/coen174>

Switch to the main branch:
git checkout main

Open the Xcode project:
cd main
open AllergenDetector.xcodeproj

Within Xcode, select the target device or simulator you want to run the app on.
Build and run the project using the "Run" button or by pressing Cmd + R.
The iOS app will be installed and launched on the selected device/simulator. Follow the on-screen instructions to use the app's features.
