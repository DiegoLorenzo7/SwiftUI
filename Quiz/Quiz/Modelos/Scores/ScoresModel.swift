//
//  ScoresModel.swift
//  Quiz
//
//  Created by c078 DIT UPM on 22/11/23.
//

import Foundation

class ScoresModel: ObservableObject {
    
    @Published private(set) var acertadas : Set<Int> = []
    
    func add(answer: String, quizItem: QuizItem) {
        if answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == quizItem.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
            acertadas.insert(quizItem.id)
        }
    }
}
