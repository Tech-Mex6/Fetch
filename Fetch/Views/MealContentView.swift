//
//  MealContentView.swift
//  Fetch
//
//  Created by meekam okeke on 7/15/24.
//

import SwiftUI

struct MealContentView: View {
    let mealID: String
    @StateObject private var vm = MealViewModel()
    
    var body: some View {
        VStack {
            if let mealContent = vm.mealContent {
                Text(mealContent.name)
                    .font(.title)
                    .bold()
                    .padding(.bottom, 5)
               
                ScrollView {
                    instructionHeader
                    
                    Text(mealContent.instructions)
                        .padding()
                    
                    ingredientHeader
                    
                    ForEach(mealContent.ingredients.sorted(by: <), id: \.key) { key, value in
                        HStack {
                            Text(key)
                            Spacer()
                            Text(value)
                        }
                        .padding()
                    }
                }
            } else {
                ProgressView()
            }
        }
        .onAppear(perform: {
            Task {
                await vm.loadMealContent(id: mealID)
            }
        })
    }
}

#Preview {
    MealContentView(mealID: "52898")
}

extension MealContentView {
    private var instructionHeader: some View {
        Text("Instructions")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.title2)
            .fontWeight(.semibold)
            .padding(.leading)
    }
    
    private var ingredientHeader: some View {
        Text("Ingredients/Measurements")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.title2)
            .fontWeight(.semibold)
            .padding(.leading)
    }
}
