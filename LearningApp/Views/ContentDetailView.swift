//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Sam Burch on 22/03/2021.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))

        VStack {
        
            // Only show video playeer if there is one present on the lesson
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            // Description
            CodeTextView()
            
            // Show next lesson button if there is one in the module using hasNextLesson function
            if model.hasNextLesson() {
                Button(action: {
                    
                    // Advance to the next lesson
                    model.nextLesson()
                    
                }, label: {
                    
                    ZStack {
                        
                        RectangleCard(color: Color.green)
                            .frame(height: 48)
                        
                        // Set the next of the button to the next lesson
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(Color.white)
                            .bold()
                        
                    }
                })
                                    
            }
            
            // Set the course to complete and return user to the HomeView
            else {
                
                Button(action: {
                    
                    // Return the user to HomeView by setting the currentContentSelected to nil
                    model.currentContentSelected = nil
                    
                }, label: {
                    
                    ZStack {
                        
                        RectangleCard(color: Color.green)
                            .frame(height: 48)
                        
                        // Course complete
                        Text("Complete course")
                            .foregroundColor(Color.white)
                            .bold()
                        
                    }
                })
                
            }
            
        }
        .padding()
        // Set lesson title on Code text view if there is one
        .navigationTitle(lesson?.title ?? "")
        
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
