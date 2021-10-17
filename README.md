# HealthKit-RnD

In your day-to-day life, a workout is a simple thing. It’s some period of time in which you increase physical exertion doing some sort of activity.

Most workouts have one more of the following attributes:

1. Activity type (running, cycling, Prancercising, etc.)
2. Distance
3. Start and end time
4. Duration
5. Energy burned
HealthKit thinks of workouts in much the same way. A workout is a container for these types of information, taken as a collection of samples. A given workout might contain heart rate samples, distance samples and an activity type to categorize them.

We will do an experiment on Prancercise Workouts. If you do not know what it is, Please hold on tight with our journey. 

Each PrancerciseWorkout keeps track of its:
1. Start and end time
2. Duration
3. Total calories burned
our app feeds these values into HealthKit when we save your workout.

The first thing we do is create a health store and workout configuration to store data into HealthKit

HKQuantity is being used  used it to read and write user’s height, weight, and body mass index. 

Querying Workouts
Now, we can save a workout, but we also need a way to load workouts from HealthKit. we’ll add a new method to WorkoutDataStore to do that.

# Health App 

We have added another sample app for handling health related data. This app do not use Healthkit rather than it uses coremotion to track user's movement and coredata to store important health related information. We understand that healthkit has some limitation. Healthkit is basically a sandbox of health data. HealthKit’s clinical record support lets you read Fast Healthcare Interoperability Resources (FHIR) from the HealthKit store. You can download their FHIR records from supported healthcare institutions. The system then updates the records in the background on a regular basis.
To use your clinical records, you must request permission to read each record type. Then, use HealthKit’s queries to access the individual records. Finally, you need to parse and handle each record’s FHIR JSON data.


Just like Google Fit, the Apple Health app was announced in 2014 and included in Apple devices with iOS 8+. Quite a fruitful year for fitness apps, isn’t it?

Along with the app, the company also released the Apple HealthKit API which is a part of the iOS SDK for app development on Mac.

The tool quickly became popular. The list of apps compatible with HealthKit includes such popular names as:

fitness apps — Strava, Runtastic Steps, Garmin Connect
nutrition apps — Lifesum, Foodzy
healthcare apps — HealthyNow, Hello Doctor

When it comes to HealthKit compatible devices, Apple obviously prioritizes its own products — iPhone, iPod Touch, and Apple Watch. Except for that, Apple Health works with Jawbone, Nike Fuelband, devices by Withings, and a bunch of others. Yet, since both Apple and Google may face changes in the number and brands of supported devices, we recommend checking this info before development on your own so as to notice the latest changes.

The iOS HealthKit framework is widely used in different types of apps because it collects and stores much data of different types. Here they are!

Ecosystem
Apple offers 3 Kits to be used by developers:

HealthKit — a health & fitness data container. It enables seamless communication with other apps and makes it easy for them to store, exchange, and collect health data.
ResearchKit — this framework will be useful if you need to gather medical data from large groups of people for research purposes.
CareKit — a framework for monitoring and managing long-term and chronic illnesses, recovery after surgery, etc.

Datas are here. Full list is available here: https://developer.apple.com/documentation/healthkit/data_types
![Screenshot 2021-10-17 at 1 26 41 PM](https://user-images.githubusercontent.com/2936695/137616439-88a52bc1-7a3b-464c-b714-6d11d8122f7f.png)

How does the Health app collect such data? It’s provided either by:

devices (for example, iPhone or Apple Watch may count a number of taken steps and burned calories);
apps (user has its own favorite hydration app that shares this data with Apple Health);
the user itself (when he manually enters his weight).
Note that developers can’t create custom data types. So make sure the Apple HealthKit framework provides all types of data you need. Otherwise, we’d recommend you to consider using another fitness data service that either provides all needed data types or allows you to create custom ones — like Google Fit API.

# Strava
Strava is another popular fitness platform that can be a source of valuable data for you. Yet, the company is also quite strict on how you use that data so they expect your application to augment the Strava experience of users in the first place.

Nevertheless, the Strava API is used by many big names such as Fitbit, Peloton, or Aaptiv. The company is actually proud of the number of apps integrated with Strava, so you can find many cases on this list. https://www.strava.com/apps

By the way, one of the projects we've worked on is featured on that list under the wellness category — look for WePulse. Closer to the end of this article we'll share our expertise in that case!

**Ecosystem**
Unlike other services from this article, Strava doesn’t have a branched ecosystem. It relies on the Strava API. This is the only tool developers need; the company doesn’t offer any Strava SDK or other tools.

The Strava API is a free-to-use public interface that allows to access Strava data on users, routes, clubs, gear, and segments. Notice that the API usage is limited on a 15-minute and daily request basis per app. The default rate limits your app to 100 requests every 15 minutes, with up to 1,000 requests a day.

![Screenshot 2021-10-17 at 1 29 54 PM](https://user-images.githubusercontent.com/2936695/137616540-91e37727-200c-4349-bed5-e85a96d3ca6c.png)


**Requirements**
Strava’s guidelines are somewhat similar to the ones Fitbit has. Except for basic security requirements, you are not allowed to create an app that replicates or competes with Strava.

Yet, the company also has a few quite special requirements. For example:

we must use the provided Strava logos and links in places where we use data provided by Strava.
our app must include the “Connect with Strava” button.
we must also include the “Compatible with Strava” or “Powered by Strava” logos in all websites, applications, and media (prints, videos, images).
To make sure our app matches all the requirements for Strava integration, check the following links: 

1. Strava API Agreement https://www.strava.com/legal/api
2. Strava API Brand Guidelines https://developers.strava.com/guidelines/

# Milestones 
1. Here is the full video of how much we have progressed so far in our RnD: https://vimeo.com/manage/videos/632831566
2. Here is the full video of how much we have progrssed so far without healthkit. 
# Screenshots


![IMG_0052](https://user-images.githubusercontent.com/2936695/137481487-e95c1a7b-327a-4740-a464-d561f5c6aab8.PNG)
![IMG_0053](https://user-images.githubusercontent.com/2936695/137481495-128bef46-e041-43c2-b072-622aaa457c6e.PNG)
![IMG_0054](https://user-images.githubusercontent.com/2936695/137481499-44ef4b3c-86cb-452c-bb7c-a3e36a819b4a.PNG)
![IMG_0055](https://user-images.githubusercontent.com/2936695/137481511-b1d7a10f-2956-46a5-b9fa-776523b1980b.PNG)
![IMG_0056](https://user-images.githubusercontent.com/2936695/137481517-04d7ff32-5287-49c2-859d-f86ba86c6254.PNG)


