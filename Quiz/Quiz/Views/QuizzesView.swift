//
//  QuizzesView.swift
//  Quiz
//
//  Created by c078 DIT UPM on 22/11/23.
//

import SwiftUI

struct QuizzesView: View{
    
    @EnvironmentObject var quizzesModel: QuizzesModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(quizzesModel.quizzes) { quizItem in 
                    NavigationLink {
                        QuizPlayView(quizItem: quizItem)
                    } label: {
                        QuizRow(quizItem: quizItem)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Quizzes")
            .onAppear {
                quizzesModel.load()
            }
        }
    }
}
