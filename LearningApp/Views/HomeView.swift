//
//  ContentView.swift
//  LearningApp
//
//  Created by Sam Burch on 10/03/2021.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        NavigationView {
            
            VStack (alignment: .leading) {
                
                Text("What do you want to do today?")
                    .padding(.leading, 20)
                
                ScrollView {
                    
                    ForEach(model.modules) { module in
                        
                        LazyVStack (spacing: 20) {
                            
                            NavigationLink(
                                destination: ContentView()
                                    // Load the current module when the ContentView appears
                                    .onAppear(perform: {
                                        model.beginModule(module.id)
                                    }),
                                // Use the module ID from JSON to tag the selected module
                                tag: module.id,
                                selection: $model.currentContentSelected,
                                label: {

                                    // Learning card
                                    HomeViewRow(image: "\(module.content.image)", title: "Learn \(module.category)", description: "\(module.content.description)", count: "\(module.content.lessons.count) Lessons", time: "\(module.content.time)")
                                    
                                })
                            
                            // Test card
                            HomeViewRow(image: "\(module.test.image)", title: "\(module.category) Test", description: "\(module.test.description)", count: "\(module.test.questions.count) Questions", time: "\(module.test.time)")
                            
                        }
                        .accentColor(.black)
                        
                    }
                    .padding()
                    
                }
                
            }
            .navigationTitle("Get started")
            
        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
