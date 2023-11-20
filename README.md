# DownAppDemo

Regular                    |  Date                     |  Down 
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/iraklivasha/DownAppDemo/blob/main/demo-images/regular.png?raw=true)  |  ![](https://github.com/iraklivasha/DownAppDemo/blob/main/demo-images/date.png?raw=true)  |  ![](https://github.com/iraklivasha/DownAppDemo/blob/main/demo-images/down.png?raw=true) 

## Build & Run

Run: `pod install` in the root & open `DownAppDemo.xcworkspace` & Run

## Architecture

On a high level, the project is split into 3-4 layers: 

Netjob - Standalone networking library (built by me), which defines the network access API and gives the ability to customize requests in any way.

Service layer - This layer uses Netjob library and defines information about how each endpoint should be called, what are the parameters ... etc. The data can be mocked easily on this layer by returning local JSON file path to the `mockPath` getter property to each endpoint declaration (`Router+Profile.swift` for example), which is out of the scope of this demo - I just explain this to demonstrate I how usually do mocking when I need. 

Presenter - This is kind of a mediator layer between service and UI layers - It accesses service layer and updates the UI via the interface, which is implemented by the view controller.
The presenter layer holds the reference to the service layer interface and doesn't know anything about the implementation, which gives us the ability to inject different service objects into the the same presenter implementation. 

UI - Holds the instance of the presenter and updates the data or receives the update events. 

## Summary

This is the very general overview, but can talk about detailed implementation 

