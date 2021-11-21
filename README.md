#Mobile Application Assessment

As part of your application we invite you to complete the following coding assessment.

##Overview

The task we would like you to complete is to create an app that makes a call for international currency data (JSON) and use it to create a currency converter app that converts international currencies into Australian Dollars.  Refer to Apple's Human Interface Guidelines or Android's material design as a resource to provide a good customer experience.

##Requirements:

* The app must be written in Swift or Kotlin
> [@Animesh] I have used Swift 4.2.

* The app must be written using Xcode 9+ for iOS or Android Studio for Android.
> [@Animesh] I have used Xcode 10.1

* Use of suitable design patterns, and a strict separation of concerns when developing a mobile application
> [@Animesh] Used Model-View-View Model Pattern with creation of UI Component.

* Create a library containing all functionality that could be reused by 3rd party developers in any application that requires exchange rate calculations. 3rd parties using this library should not be tightly coupled to any specific technology and should be able to consume the library in any way they choose
> [@Animesh] Created the seprate library for FXServices- which contain all functionality that could be reused by 3rd party developers in any application that requires exchange rate calculations.

* Code should be commented sufficiently to allow auto generation of library API documentation
> [@Animesh] Code Commented.

* Use all the data the API provided
  * Asynchronous development principals when retrieving and displaying data originating from network calls
   > [@Animesh] Done
   
* UI interaction and data binding principals
  * Sound management of User Interface
  > [@Animesh] Done
  
  * The application should be able to be re-branded (colours, fonts, assets) - 2 distinct branded targets/variants should be included in the project
  > [@Animesh] Theme has been created with two seprate target.
  
  * The app should be built with a universal UI.
  > [@Animesh] Application designed for iPhone & iPad.
  
* Correct use of the application life cycle, management of the UI thread
 > [@Animesh] Done
 
* Incremental Commits of code and proper use/understanding of gitflow
  * Quick Overview - <http://nvie.com/posts/a-successful-git-branching-model/>
  * In-depth Tutorial - <https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow>
  > [@Animesh] Done
  
* Unit tests/mocks to demonstrate the code is testable
> [@Animesh] Unit Test Case added.

##Getting Started
* The URL to get the fx data is ``https://www.westpac.com.au/bin/getJsonRates.wbc.fx.json``.
* For other platforms the use of frameworks, libraries, and open-source code is allowed – but please reference their use in comments in the code. Please use package management for open source dependencies where suitable.



/*
 Welcome to the Xero technical excercise!
 ---------------------------------------------------------------------------------
 The test consists of a small invoice application that has a number of issues.
 
 Your job is to fix them and make sure you can perform the functions in each method below and display the list of invoices from getInvoices() inside a UITableView.
 
 Note your first job is to get the solution compiling!
 
 Rules
 ---------------------------------------------------------------------------------
 * The entire solution must be written in Swift (UIKit or SwiftUI)
 * You can modify any of the code in this solution, split out classes, add projects etc
 * You can modify Invoice and InvoiceLine, rename and add methods, change property types (hint)
 * Feel free to use any libraries or frameworks you like
 * Feel free to write tests (hint)
 * Show off your skills!
 
 Good luck :)
 
 When you have finished the solution please zip it up and email it back to the recruiter or developer who sent it to you
 */
