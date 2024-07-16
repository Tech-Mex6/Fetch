#  Fetch App

This is a native iOS application that allows users to browse dessert recipes using TheMealDB API.
Users can view a list of dessert meals, search for specific meals and see detailed information about each meal,
including ingredients and instructions for preparing each meal.

## Features

### - Browse a list of dessert recipes.
### - Search for recipes dynamically.
### - View detailed information about each recipe.
### - Caching of meals to minimize API calls.
### - Asynchronous data fetching using Swift Concurrency (async/await)


## Requirements

### - Xcode 14.0 or later
### - iOS 15.0 or later
### - Swift 5.5 or later


## Installation

### 1. Clone the repository:

```sh
git clone https://github.com/Tech-Mex6/Fetch.git
cd Fetch
```

### 2. Open the project in Xcode:

```sh
open Fetch.xcodeproj
```

### 3. Build and run the app on your preferred device or simulator.


## Project Structure

The project follows the MVVM (Model-View_ViewModel) architectural pattern and includes the following components:

### - Models: Define the data structures for Meal and MealContent.

### - Views: SwiftUI views for displaying the list of meals and meal details.

### - ViewModels: Manage the state and logic for fetching and presenting data to the views.

### - Networking: Handles API calls to TheMealDB


## API Usage

This app utilizes two endpoints from TheMealDB API:

### 1. Fetching a list of dessert meals:

```bash
https://themealdb.com/api/json/v1/1/filter.php?c=Dessert
```

### 2. Fetching detailed information for a specific meal by ID:

```bash
https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID
```

## Local Caching

The app uses `FileManager` to cache the list of meals locally to reduce the number of API calls.
Cached data is stored in the app's cache directory and fetched on subsequent app launches.


## Search Functionality

The search bar allows users to filter the list of meals dynamically based on their search input.
The list updates in real-time as the user types.


