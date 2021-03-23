//
//  ContentView.swift
//  LearningApp
//
//  Created by Sam Burch on 17/03/2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        ScrollView {
            
            LazyVStack {
                
                // Check that the current module is set
                if model.currentModule != nil {
                    
                    // Loop through the current module lessons
                    ForEach(0..<model.currentModule!.content.lessons.count) {
                        
                        index in
                        
                        NavigationLink(
                            // Pass the lesson index of the current module
                            destination: ContentDetailView()
                                .onAppear(perform: {
                                    model.beginLesson(index)
                                }),
                            label: {
                                // You have to pass index: index because that var was set at ContentViewRow
                                ContentViewRow(index: index)
                            })
                            .accentColor(.black)
                        
                    }
                    
                }
                
            }
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
            .padding()
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ContentModel())
    }
}
