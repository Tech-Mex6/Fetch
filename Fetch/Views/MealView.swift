//
//  MealView.swift
//  Fetch
//
//  Created by meekam okeke on 7/15/24.
//

import SwiftUI

struct MealView: View {
    @StateObject private var vm = MealViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchText: $vm.searchText)
                
               listView
                .listStyle(PlainListStyle())
                .navigationTitle("Desserts")
            }
        }
    }
}

#Preview {
    MealView()
}

extension MealView {
    private var listView: some View {
        List(vm.filteredMeals) { meal in
            NavigationLink(destination: MealContentView(mealID: meal.id)) {
                HStack(spacing: 20) {
                    AsyncImage(url: URL(string: meal.image)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .cornerRadius(8)
                        case .failure:
                            Image(systemName: "photo")
                        default:
                            Image(systemName: "photo")
                        }
                    }
                    
                    Text(meal.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
            }
        }
    }
}
