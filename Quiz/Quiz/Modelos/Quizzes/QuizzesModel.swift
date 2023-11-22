//
//  QuizzesModel.swift
//  P4.1 Quiz
//
//  Created by Santiago Pavón Gómez on 11/9/23.
//

import Foundation

class QuizzesModel: ObservableObject {
    
    // Los datos
    @Published private(set) var quizzes = [QuizItem]()
    
    func load() {
        
        guard let  jsonURL = Bundle.main.url(forResource: "quizzes", withExtension: "json")
                else {
                print("Internal error: No encuentro quizzes.json")
                return
        }
        
        do {
            let data = try Data(contentsOf: jsonURL)
            let decoder = JSONDecoder()
            
            // print("Quizzes ==>", Stri-ng(data: data, encoding: String.Encoding.utf8) ?? "JSON incorrecto")
            
            let quizzes = try decoder.decode([QuizItem].self, from: data)
                
            self.quizzes = quizzes
            
            print("Quizzes cargados")
        } catch {
            print(error.localizedDescription)
        }
    }
}
