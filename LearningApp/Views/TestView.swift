//
//  TestView.swift
//  LearningApp
//
//  Created by Sam Burch on 06/04/2021.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex: Int?
    // Track whether question has been answered
    @State var submitted = false
    @State var numCorrect = 0
    
    var body: some View {
        
        if model.currentQuestion != nil {
            
            VStack (alignment: .leading) {
                
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                
                // Question (currently needs to be fetched from Code Text view due to HTML)
                CodeTextView()
                    .padding(.horizontal, 20)
                
                // Answers
                ScrollView {
                    
                    VStack {
                        
                        // Get all the answers for the current question
                        ForEach(0..<model.currentQuestion!.answers.count) { index in
                            
                            
                            Button(action: {
                                // TODO
                                selectedAnswerIndex = index
                                
                                
                            }, label: {
                                
                                ZStack {
                                    
                                    // If the Submission button hasnt been selected yet
                                    if submitted == false {
                                    
                                        // Check if the user has selected the answer and set to grey
                                        RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                            .frame(height: 48)
                                            .shadow(radius: 5)
                                        
                                    }
                                    else {
                                        
                                        // If the answer is correct turn to green
                                        if index == selectedAnswerIndex &&
                                            index == model.currentQuestion!.correctIndex {
                                            
                                            RectangleCard(color: .green)
                                                .frame(height: 48)
                                                .shadow(radius: 5)
                                            
                                        }
                                        
                                        // If the answer is wrong change box to red and set answer to green
                                        else if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex {
                                            
                                            RectangleCard(color: .red)
                                                .frame(height: 48)
                                                .shadow(radius: 5)
                                            
                                        }
                                        
                                        else if index == model.currentQuestion!.correctIndex {
  
                                            RectangleCard(color: .green)
                                                .frame(height: 48)
                                                .shadow(radius: 5)
                                            
                                        }
                                        
                                        else {
                                            
                                            // Keep styling if answer was wrong
                                            RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                                .frame(height: 48)
                                                .shadow(radius: 5)
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    
                                    Text(model.currentQuestion!.answers[index])
                                    
                                }
                                
                            })
                            .disabled(submitted)
                            
                        }
                        
                    }
                    .accentColor(.black)
                    .padding()
                    
                }
                
                // Button to submit answer
                Button(action: {
                    
                    // Once user confirms answer, don't allow them to change it
                    submitted = true
                    
                    // Check if the given answer was correct and increment score by one
                    if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                        
                        numCorrect += 1
                        
                    }
                    
                }
                , label: {
                    
                    ZStack {
                        
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        
                        Text("Submit")
                            .bold()
                            .foregroundColor(Color.white)
                        
                    }
                    .padding()

                })
                .disabled(selectedAnswerIndex == nil)
                
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
