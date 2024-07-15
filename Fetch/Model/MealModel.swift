//
//  MealModel.swift
//  Fetch
//
//  Created by meekam okeke on 7/15/24.
//

import Foundation

struct MealResponse: Codable {
    let meals: [Meal]
}

struct MealContentResponse: Decodable {
    let meals: [MealContent]
}

struct Meal: Codable {
    let id: String
    let name: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case image = "strMealThumb"
    }
}

struct MealContent: Identifiable, Decodable {
    let id: String
    let name: String
    let instructions: String
    let ingredients: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5
        case strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15
        case strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5
        case strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
        case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15
        case strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            name = try container.decode(String.self, forKey: .name)
            instructions = try container.decode(String.self, forKey: .instructions)
            
            var ingredients = [String: String]()
            for i in 1...20 {
                let ingredientKey = CodingKeys(stringValue: "strIngredient\(i)")!
                let measureKey = CodingKeys(stringValue: "strMeasure\(i)")!
                if let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey),
                   let measure = try container.decodeIfPresent(String.self, forKey: measureKey),
                   !ingredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                   measure.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
                    ingredients[ingredient] = measure
                }
            }
            self.ingredients = ingredients
    }
}
