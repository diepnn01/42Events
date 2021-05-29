# 42Events iOS App
42Race Coding Test


## Prerequirements

* Xcode 12.2 or above

## How to run project
Step 1: 
> `git clone git@github.com:diepnn01/42Events.git` <br>
> `cd 42Events` <br>
> `pod install --repo-update` <br>

Step 2: 
> `open 42Events.xcworkspace`

## Architecture
Project uses MVP architectural pattern along with RxSwift. So that We grouped the project's source code in the project this folder structure:

**Main**<br>
This folder contains AppDelegate.swift it is root of application


**Services**<br>
This folder contains classes that responsibilitiy to connect API, other external platforms (Firebase, Realm ..)

**Routing**<br>
This folder contains classes that responsibilitiy to format params and setup prerequires condition to work with API

**Models**<br>
Defining classes to send to API as well as binding to UI

**App**<br>
Defining Controller, Presenter, View

**Utils**<br>
Defining classes utils that we used in project

**Common**<br>
Defining extensions, enums

**CustomViews**<br>
Defining custom uiview, uitableviewcell, uicollectionviewcell, ...

**Resources**<br>
Locating font, images ...


