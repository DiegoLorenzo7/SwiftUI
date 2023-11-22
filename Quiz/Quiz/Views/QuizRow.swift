//
//  QuizRow.swift
//  Quiz
//
//  Created by c078 DIT UPM on 22/11/23.
//

import SwiftUI

struct QuizRow: View {
    
    @State private var isFavorited: Bool = false // Nuevo estado para manejar si está marcado como favorito
    
    var quizItem: QuizItem
    
    var body: some View {
        HStack {
            MyAsyncImage(url: quizItem.attachment?.url)
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 3))
                .shadow(radius: 10)
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: isFavorited ? "star.fill" : "star") // Cambiar la imagen de estrella
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(isFavorited ? .yellow : .gray) // Cambiar el color de la estrella
                        .onTapGesture {
                            // Manejar la acción de marcar/desmarcar como favorito
                            isFavorited.toggle()
                        }
                    
                    Text(quizItem.author?.username ?? quizItem.author?.profileName ?? "Autor")
                        .font(.callout)
                        .foregroundColor(.gray)
                    
                    MyAsyncImage(url: quizItem.author?.photo?.url)
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                        .shadow(radius: 5)
                }
                Text(quizItem.question)
                    .fontWeight(.semibold)
            }
            .padding(.leading, 8)
        }
        .padding(8)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct QuizRow_Previews: PreviewProvider {
    
    static var qm: QuizzesModel = {
        var qm = QuizzesModel()
        qm.load()
        return qm
    }()
    
    static var previews: some View {
        QuizRow(quizItem: qm.quizzes[0])
    }
}
