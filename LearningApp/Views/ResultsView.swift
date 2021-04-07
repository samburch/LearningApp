//
//  ResultsView.swift
//  LearningApp
//
//  Created by Sam Burch on 07/04/2021.
//

import SwiftUI

struct ResultsView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var testScore: Int
    
    var resultsHeading: String {
        
        // Convert test result into a percentage and evaluate score
        // Guard against the currentModule not having been set earlier in the programs running to avoid error
        guard model.currentModule != nil else {
            return ""
        }
        
        // Force unwrap as we put a guard in
        let pct = Double(testScore)/Double(model.currentModule!.test.questions.count)
        
        if pct > 0.5 {
            
            return "Awesome job!"
            
        }
        
        else if pct > 0.2 {
            
            return "Doing good.."
            
        }
        
        else {
            
            return "Keep learning, you can do this!"
            
        }
        
    }
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Text(resultsHeading)
                .font(.title)
            
            Text("You got \(testScore) out of \(model.currentModule?.test.questions.count ?? 0)")
            
            Spacer()
            
            Button {
                
                // Send the user back to the HomeView by setting the currentTestSelected to nil
                model.currentTestSelected = nil
                
            } label: {
                
                ZStack {
                    
                    RectangleCard(color: .green)
                        .frame(height: 48)
                    Text("Complete")
                        .accentColor(.white)
                }
                .padding(.horizontal, 20)
                
                
            }
            
        }
        
    }
}
