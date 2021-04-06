//
//  ContentModel.swift
//  LearningApp
//
//  Created by Sam Burch on 10/03/2021.
//

import Foundation

class ContentModel: ObservableObject {
    
    // List of modules
    @Published var modules = [Module]()
    
    // Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    // Current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // Current lesson explanation from html data
    @Published var codeText = NSAttributedString()
    
    // Current question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    // Current selected content
    @Published var currentContentSelected: Int?
    @Published var currentTestSelected: Int?
    
    // HTML and CSS data for lessons
    var styleData: Data?
    
    init() {
        
        getLocalData()
        
    }
    
    // MARK: - Get local data
    
    func getLocalData() {
        
        // get a URL to the JSON file and create the modules
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
        
            // Read file into a data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            // Try to decode JSON into an array of modules
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            // Assign passed modules to modules property that's publushed
            self.modules = modules
            
        }
        
        catch {
            
            // Log error if JSON parsing fails
            print("Couldn't parse local data")
            
        }
        
        // Pass the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            
            // Read style file into a data object
            let styleData = try Data(contentsOf: styleUrl!)
            
            // Assign the data to the data variable for use later
            self.styleData = styleData
            
        }
        
        catch {
            
            // Log an error
            print("Couldn't parse Style data")
            
        }
        
    }
    
    // MARK: - Get current module
    
    func beginModule(_ moduleid: Int) {
        
        // Find the index for the current module
        for index in 0..<modules.count {
            if modules[index].id == moduleid {
                currentModuleIndex = index
                break
            }
            
        }
        
        // Set the current module
        currentModule = modules[currentModuleIndex]
        
    }
    
    // MARK: - Get current lesson in module
    
    func beginLesson(_ lessonIndex: Int) {
        
        // Check that the current lesson index is within the module range
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        }
        
        else {
            currentLessonIndex = 0
            
        }

        // Set the current lesson index
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        
        // Set the descrpition for the current lesson
        codeText = addStyling(currentLesson!.explanation)
        
    }
    
    func nextLesson() {
        
        // Advance to the next lesson index
        currentLessonIndex += 1
        
        // Check that it is within range
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            // Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            
            // Set the lesson description for next lesson
            codeText = addStyling(currentLesson!.explanation)
        }
        
        else {
            currentLessonIndex = 0
            currentLesson = nil
        }
        
    }
    
    func hasNextLesson() -> Bool {

        // Return the result of whether there is anoter less on the module in order to show/hide the next lesson button in teh ContentDetailView
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
        
    }
    
    // MARK: - Begin Test
    
    func beginTest(_ moduleId:Int) {
        
        // Set the current module
        beginModule(moduleId)
        
        // Set the current question
        currentQuestionIndex = 0
        
        // If there are questions, set the current question to the first one in the series
        if currentModule?.test.questions.count ?? 0 > 0 {
            
            // Set the current question
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            
            // Also set the current question text
            codeText = addStyling(currentQuestion!.content)
        }
        
        
    }
    
    // MARK: - HTML Code styling
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        
        var resultsString = NSAttributedString()
        var data = Data()
        
        // Add styling data
        if styleData != nil {
            data.append(styleData!)
        }
        
        // Append HTML to data object
        data.append(Data(htmlString.utf8))
        
        // Convert to attributed string using optional binding
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            
            resultsString = attributedString
        
        }
        
        return resultsString
        
    }
    
}
