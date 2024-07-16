//
//  MealViewModel.swift
//  Fetch
//
//  Created by meekam okeke on 7/15/24.
//

import Foundation


class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var mealContent: MealContent?
    @Published var searchText: String = ""
    private let fileName = "meals.json"
    var filteredMeals: [Meal] {
        if searchText.isEmpty {
            return meals
        } else {
            return meals.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    init() {
        Task {
            await fetchMeals()
        }
    }
    
    //MARK: - Fetch Meals
    /// - Parameters: None
    /// - Description:
    /// Checks if cached meals exist. if they do, it loads them and updates `meals` on the main thread.
    /// if no cached meals are found, it fetches meals by making an api call and then it updates `meals` on the
    /// main thread and saves the fetched meals to the cache.
    /// - Error Handling:
    /// Prints an error message if fetching from the network fails.

    func fetchMeals() async {
        if LocalFileManager.instance.fileExists(fileName: fileName) {
            if let cachedMeals = LocalFileManager.instance.getData(from: fileName, as: [Meal].self) {
                DispatchQueue.main.async {
                    self.meals = cachedMeals
                    print("Retrieved meals from File Manager!")
                }
                return
            }
        }
        do {
            let fetchedMeals = try await NetworkingManager.shared.fetchMeals(category: "Dessert")
            DispatchQueue.main.async {
                self.meals = fetchedMeals
                print("Downloading meals")
                LocalFileManager.instance.saveData(fetchedMeals, fileName: self.fileName)
            }
        } catch {
                print("Error fetching meals:\(error.localizedDescription)")
        }
    }
    
    //MARK: - Load Meal content for additional details
    /// - Parameters:
    ///  - id: The ID of the meal to fetch details for.
    /// - Description: Fetches meal content for a specific meal ID from the network and updates `mealContent` on the main thread
    /// - Error Handling: Prints an error message if fetching the meal content fails.

    func loadMealContent(id: String) async {
        do {
           let mealContent = try await NetworkingManager.shared.fetchMealContents(id: id)
            DispatchQueue.main.async {
                self.mealContent = mealContent
            }
        } catch {
            print("Error fetching meal content: \(error.localizedDescription)")
        }
    }
}
