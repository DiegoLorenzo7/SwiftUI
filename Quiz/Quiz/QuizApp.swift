//
//  QuizApp.swift
//  Quiz
//
//  Created by c078 DIT UPM on 22/11/23.
//

import SwiftUI

@main
struct QuizApp: App {
    
    @StateObject var quizzesModel: QuizzesModel = QuizzesModel()
    @StateObject var scoresModel: ScoresModel = ScoresModel()
    
    
    var body: some Scene {
        WindowGroup {
            QuizzesView()
                .environmentObject(quizzesModel)
                .environmentObject(scoresModel)
            
        }
    }
}
