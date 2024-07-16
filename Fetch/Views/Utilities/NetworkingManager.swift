//
//  NetworkingManager.swift
//  Fetch
//
//  Created by meekam okeke on 7/15/24.
//

import Foundation

class NetworkingManager {
    static let shared = NetworkingManager()
    private let baseURL = "https://themealdb.com/api/json/v1/1/"
    
    //MARK: - Fetch List of Meals
    /// - Parameters:
    ///     - category: The meal category
    /// - Returns: An array of meals based on the selected category
    
    func fetchMeals(category: String) async throws -> [Meal] {
        let url = URL(string: "\(baseURL)filter.php?c=\(category)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
        return mealResponse.meals.sorted { $0.name < $1.name }
    }
    
    //MARK: - Fetch Ingredients for Each Meal
    /// - Parameters:
    ///     - id: This represents the unique identifier String for each meal
    /// - Returns: A MealContent object based on the unique id
    
    func fetchMealContents(id: String) async throws -> MealContent {
        let url = URL(string: "\(baseURL)lookup.php?i=\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let mealContentResponse = try JSONDecoder().decode(MealContentResponse.self, from: data)
        return mealContentResponse.meals.first!
    }
}
