//
//  SearchBar.swift
//  Fetch
//
//  Created by meekam okeke on 7/15/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("Search by meal name...", text: $searchText)
                .autocorrectionDisabled()
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.black)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .shadow(
                    color: Color.gray.opacity(0.8),
                    radius: 10, x: 0, y: 0
                )
        )
        .padding()
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
}
