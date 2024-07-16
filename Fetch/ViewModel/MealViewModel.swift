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
