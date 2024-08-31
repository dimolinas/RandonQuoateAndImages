//
//  ContentView.swift
//  RamdonQuoateAndImages
//
//  Created by Diegoe012 on 27/08/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var randomImageListViewModel = RandomImageListViewModel()
    var body: some View {
        NavigationStack {
            List(randomImageListViewModel.randomImages) { randomImage in
                HStack {
                    randomImage.image.map {
                        Image(uiImage: $0)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    Text(randomImage.quote)
                }
            }.task {
                await randomImageListViewModel.getRandomImages(ids: Array(100...120))
            }
            .navigationTitle("Random Images/Quotes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button("", systemImage: "arrow.clockwise.circle"){
                        Task {
                            await randomImageListViewModel.getRandomImages(ids: Array(100...120))
                        }
                    }
                }
            }
        }
        
        
        
        
    }
}

#Preview {
    ContentView()
}
