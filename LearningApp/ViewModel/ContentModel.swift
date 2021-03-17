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
    
    var styleData: Data?
    
    init() {
        
        getLocalData()
        
    }
    
    // MARK: - Get local data
    
    func getLocalData() {
        
        // get a URL to the JSON file
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
            print("Coulnt' parse Style data")
            
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
    
}
