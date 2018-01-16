

A simple Giphy search app.

# Architecture

The application is built following the Model View ViewModel principles.
Project files are organised based on their role.
- *Models*: includes API data models and client. JSON data parsing is mapped to Swift structs using the [Argo](https://github.com/thoughtbot/Argo) third party object mapper library
- *ViewModels*: connecting the data layer and the view objects (ViewControllers and Views)
- *ViewControllers* and *Views*: together they represent the view layer. These define a ViewModel protocol for maximum separation from business logic. In the form of assignable closures (ex. updateHandler) are used for a very basic data binding to get notifications from the underlying ViewModel object about updates

# Installation

- checkout the project from git
- run `pod install`
- open the workspace and run the project: `CMD + R`

# Further development
- Make search realtime with slight delay
- use reactive bindings for ViewModel and ViewController interaction
- GIFs are loaded on demand on cell display, since GIFs are large in size a better caching and background prefetching could be done for better user experience
