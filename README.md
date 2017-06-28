# BaseballGame_iOS
## Intro
#### Current
This app pulls and parses data from [baseballrefence.com](baseballrefence.com) and uses in-depth alrorithims to develop comprehensive player and team ratings. The app allows users to load any year between the current year and 1901 as well as the ability to make their own custom leagues where they can design teams with custom players and rankings.

All the downloaded and processed data is neatly stored in a series of cascading CoreData objects that allows for quick querying. This data structure allows for users to search for players by first and last name as well as sort by team and rating.

#### Goal
Eventually, I would like to turn this app into a full-fledged baseball game and simulator based on real MLB players and driven by real data converted into game stats. It would feature a play now mode in addition a variety of others such as season simulations based on the current MLB atmosphere.

## Installation
Make sure you have [CocoaPods](https://cocoapods.org) installed on your computer and that the pod is initialized in the Homework folder. When opening the project, make sure you open the .xcworkspace file and NOT the .xcodeproj file. By default, the app loads the current year's roster as an example. This app uses the following pods:
* [DownloadButton](https://github.com/PavelKatunin/DownloadButton) - download button
* [Hpple](https://github.com/topfunky/hpple) - website parsing
* [MGSwipeTableCell](https://github.com/MortimerGoro/MGSwipeTableCell) - cells with swipe menus
* [UCZPogressView](https://github.com/kishikawakatsumi/UCZProgressView) - download progress
* [ZFDragableModalTransition](https://github.com/zoonooz/ZFDragableModalTransition) - popup views
* [Core Data](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreData/index.html) - on-device data storage

## Images
#### Main view
<img src="./Screenshots/Main.png" alt="Drawing" width="300 px"/>
<img src="./Screenshots/MainSearch.png" alt="Drawing" width="300 px"/>

#### League menu
<img src="./Screenshots/Menu.png" alt="Drawing" width="300 px"/>

#### Custom league
<img src="./Screenshots/Custom1.png" alt="Drawing" width="300 px"/>
<img src="./Screenshots/Custom2.png" alt="Drawing" width="300 px"/>
