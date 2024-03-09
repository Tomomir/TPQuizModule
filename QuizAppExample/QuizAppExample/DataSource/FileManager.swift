//
//  FileManager.swift
//  Quiz
//
//  Created by Tomas Pecuch on 26/02/2024.
//

import Foundation
import TPQuizModule

class FileManager: NSObject {
    
    static func loadQuizArrayFromFile(fileName: String) -> QuizArrayModel? {
        // Get the URL for the JSON file in the documents directory
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
                print("JSON file not found")
                return nil
        }
        // Read the JSON data from the file
        do {
            let jsonData = try Data(contentsOf: fileURL)
            
            // Parse the JSON data
            let quizModel = try JSONDecoder().decode(QuizArrayModel.self, from: jsonData)
            return quizModel
        } catch {
            print("Error reading JSON file:", error)
        }
        return nil
    }
    
    static func loadQuizPreviewsFromFile(fileName: String) -> QuizPreviewArrayModel? {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
                print("JSON file not found")
                return nil
        }
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let quizModel = try JSONDecoder().decode(QuizPreviewArrayModel.self, from: jsonData)
            return quizModel
        } catch {
            print("Error reading JSON file:", error)
        }
        return nil
    }
}
