//
//  TestView.swift
//  LearningApp
//
//  Created by Sam Burch on 06/04/2021.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {

        if model.currentQuestion != nil {
            
            VStack {
                
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                
                // Question (currently needs to be fetched from Code Text view due to HTML)
                CodeTextView()
                
                // Answers
                
                // Button to submit answer
                
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
                        
        }
        
        else {
         
            Text("No question currently selected")
            
        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
