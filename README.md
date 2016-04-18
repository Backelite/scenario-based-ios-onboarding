# Scenario-based onboarding for iOS

This is a sample implementation of a smart onboarding on iOS. This is
the code used for this
[presentation](http://fr.slideshare.net/BackeliteAgency/cocoaheads-montpellier-meetup-comment-grer-son-onboarding)
at
[CocoaHeads Montpellier](http://cocoaheads.org/fr/Montpellier/index.html)
(in french).

This sample presents steps to build a simple smart onboarding based on
scenarios using events and
[RxSwift](https://github.com/ReactiveX/RxSwift) as the event flow
handler.

Each steps for building the engine is tagged with the step number. To
follow this tutorial, I suggest to open the README on one side of your
screen and the Xcode project on the other side.

The goal of this onboarding is to ask the user to enable iCloud to
sync its data only after she created some data.

## Step 1: creating the project

	$ git checkout 00-initial_code

First, we create a new Xcode project with the master/details template
provided by Xcode. This project has two controllers and shows a list
of dates created by the user, and the details of this date when
selected.

We want to create an onboarding engine capable of doing actions at
appropriate time and context. A scenario can be represented as a flow
of events so let's start by implementing a global event mecanism for
our app.

## Step 2: event engine

	$ git checkout 01-events

Our first implementation of the event system is based on
`NSNotification`s. It is quite simple to implement.

I created an `AnalyticsHelper` class that contains the events to be
emitted (represented by `String` objects) and added calls to
`NSNotification.postNotification(_:object:userInfo:)` in
`MasterViewController` and `DetailsViewController`.

I may use my event system to integrate a statistics library (such as
Google Analytics). To check my event system works properly, I
implement a fake statistics system.

I created a `StatsHelper` class that register to the `AnalyticsHelper`
events and print the event and its associated data to the console. Run
the app, create some dates and navigate to them. You should see these
events.

## Step 3: some reactivity

	$ git checkout 02-reactive_events

So, scenarios are represented as a flow of events, meaning we'll need
some ways to retain states to be able to write scenarios like:

```cucumber
Given I am on the master view
When I create a new date
And see that date
And return to the master view
Then I am proposed to enable iCloud
```

I could stay with `NSNotification`s and retain states to know if the
viewMaster event has been emitted, then the createDetail event, then
the viewDetail one. However, this would make very complex code, hard
to maintain, especially if I want to add other scenarios.

[RxSwift](https://github.com/ReactiveX/RxSwift) and
[ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) are
two frameworks that can help handle this complexity in a simple way,
given you've spent some time learning them (believe me, it's worth
it).

In this commit, I updated the code to use RxSwift instead of
`NSNotification`s.

## Step 4

	$ git checkout 03-reactive_onboarding
	
From this point, it is really easy to implement our onboarding
engine. I just have to use the right Rx operators to combine my events
and ask the user to enable iCloud. See the `OnboardingHelper` class.
