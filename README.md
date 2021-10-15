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

Here is the Full video of how much we have progressed so far in our RnD: https://vimeo.com/manage/videos/632831566

