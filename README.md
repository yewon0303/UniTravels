# UniTravels
![UniTravels](/images/poster.png)
<br />
An iPhone application to view itineraries before the trip, manage and analyse budgets during the trip, and save the itinerary as a memory collector after the trip.

## Motivation: 
When you are going on a trip with a large group of friends with limited budgets, splitting and keeping track of budget can be time-consuming and tedious. 
Why waste precious time and get unnecessary stress analysing budgets during the trip when you can use budget tracker to manage your budgets?

## Aim:
We aim to provide a trip-aid application where users who have limited time and budgets can utilise to plan a trip of their liking by interacting with other users and viewing their itineraries and budgets before the trip. 

* During the trip, it acts as an expense tracker and budget splitter that handles the tedious task of tracking expenditure of each individual. 

* After the trip, the user’s data is kept in the system such that the application can serve as a memory collector for the user, and a source of inspiration for other users should they choose to share. 

Hence, our application would be useful for all three phases involved for a trip - planning before trip, managing expenditure during trip, keeping record and memory after the trip.

## Installation guide:
1. Click [here](https://github.com/yewon0303/UniTravels.git)
1. Clone or download as zip file
1. Open unitravelsprac.xcodeproj using Xcode
1. Run the project

## Core features of Project:
1. Authentication and Registration
2. Homepage menu
3. Create new trip
4. View current trip
5. Past trips
6. Settings
<br />
    
### Authentication and Registration
*  A new user uses email address to create a username and a password.
* If the password entered does not match with the confirm password, it produces an error.
* Registered users can sign in using their email address and password.
<br />

launch screen | sign up | successful sign up
------------ | ------------- | -------------
![](/images/1.png) | ![](/images/2.png) | ![](/images/3.png)

<br />

### Homepage menu
* Once successfully logged in, user can choose from the following choices:
        a) Create new trip
        b) View current trip
        c) View past trips
        d) Settings
        e) Manage friends

* User can also choose to logout from the application by clicking on the logout option at the top of the screen.
<br />

![home](/images/4.png)
<br />

### Create New Trip
User enters trip title, destination, date and names of the trippers.
* The number of trippers can vary from 1 - 6. The user has to tick the respective checkbox next to the name of the trippers entered.
<br />

![newtrip](/images/5.png)
<br />

Once created, the app will prompt with an alert message to confirm the details (the title of the trip and the number of trippers).
The trip can now be viewed under Current Trip.
<br />

![newtripCreated](/images/6.png)
<br />

### View Current Trip
The trip of the title can be seen at the top of the screen. The summary page displays the current overview of balance of each tripper and the total expense of the trip thus far.
<br />

![summary](/images/7.png)
<br />

1. On the tab bar, the next function, Add new item, allows the user to enter the details of their expenses to keep track of their expenditure.  
<br />

![additem](/images/8.png)
<br />
      
2. The name of the item and the price of the item have to be entered. Then, the name of the person who paid for the item has to be ticked, as well as the trippers who will be sharing the particular item.
	* This function is necessary as this is an aspect of trip budgeting which poses as a problem for many users who experience confusion when having to deal with splitting budgets in a group when not everyone in the group has to pay for a particular item.
	* By having checkboxes to tick off who should be paying for the item added, the financial tracking can be done more efficiently and accurately.  
<br />

![added item](/images/9.png)
<br />
  
3. Exchange rate function at the add item tab allows for conversion of a sum of money from the chosen base rate and the chosen foreign currency. 
This ensures easy conversion and tracking of expenses when using more than one currency.
    <br />

![exchange](/images/10.png)
<br />
4. View the list of items for the current trip
   <br />

![item list](/images/12.png)
<br />
5. Add and view memories from the current trip
   <br />

![memory](/images/13.png)
<br />

### Past trips
* All archived trips with total expenses will be shown as a record of all past trips
     <br />

![archived trips](/images/14.png)
<br />

###  Settings
* Under setting, the user can view the profile, including the username, email address and the current trip embarked on by the user
 <br />

![profile](/images/15.png)
<br />

### Manage friends

1.  View all users of Unitravels
2.  Request to be friends, Delete current friends
<br />

friend list | friend confirmation | friend deletion
------------ | ------------- | -------------  
![](/images/17.png) | ![](/images/18.png) | ![](/images/19.png)
<br />

3. Extension: Chat between friends
<br />

![chat](/images/16.png)
<br />
