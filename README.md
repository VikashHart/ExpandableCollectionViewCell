# Expandable Collection View Cell

Complete overhaul of the previous collapsible cell example

Refined Collapsible Collection View Cell Example

How to Programmatically create a collapsible collectionView cell.

### Usage Instructions

##### UI

###### Collapsed
To get started, simply add your UI objects for the top of the cell above the scroll view.

###### Expanded

For the expandable section add your UI objects in the container view of the scroll view.

##### Protocol
Make sure to add the "ViewModelExpandable" protocol to your view model or view contoller. (Depending on your implementation and architecture)

##### Animation

To animate the cell call the animation.animateCell method in the "didSelectItemAt" CollectionView Delegate method.

*** Important, make sure to use the completion handler to update the expanded, collapsed and toggleBool properties.
