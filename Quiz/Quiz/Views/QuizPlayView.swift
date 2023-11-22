//
//  QuizPlayView.swift
//  Quiz
//
//  Created by c078 DIT UPM on 22/11/23.
//

import SwiftUI

struct QuizPlayView: View {
    
    var quizItem: QuizItem
    
    @Environment(\.horizontalSizeClass) var horizsc
    @State private var answer: String = ""
    @EnvironmentObject var scoresModel: ScoresModel
    @State private var showAlert = false

    var body: some View {
        VStack {
            if horizsc == .compact {
                compactLayout
            } else {
                regularLayout
            }
        }
        .navigationTitle("Play Quiz")
        .background(Color(UIColor.systemBackground)) // Cambiar el fondo
    }
    
    private var compactLayout: some View {
        VStack {
            titulo
            respuesta
            attachment
            footer
        }
    }
    
    private var regularLayout: some View {
        VStack {
            titulo
            HStack {
                respuesta
                attachment
            }
            footer
        }
    }
    
    private var titulo: some View {
        Text(quizItem.question)
            .fontWeight(.heavy)
            .font(.largeTitle)
            .foregroundColor(.init(red: 0.059, green: 0.859, blue: 0.718)) // Cambiar color del texto
    }
    
    private var attachment: some View {
        GeometryReader { geom in
            MyAsyncImage(url: quizItem.attachment?.url)
                .scaledToFill()
                .frame(width: geom.size.width, height: geom.size.height)
                .clipShape(Capsule()) // Cambiar la forma de la imagen
                .overlay(Capsule().stroke(Color.black, lineWidth: 3))
                .shadow(radius: 15)
        }
        .padding()
    }
    
    private var footer: some View {
        HStack {
            Text("Score = \(scoresModel.acertadas.count)")
                .foregroundColor(.green)
            
            Text(quizItem.author?.username ?? quizItem.author?.profileName ?? "Autor")
                .font(.callout)
                .foregroundColor(.gray) // Cambiar color del texto
            
            MyAsyncImage(url: quizItem.author?.photo?.url)
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 10)) // Cambiar la forma de la imagen
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 3))
                .shadow(radius: 5)
            
            Image(systemName: quizItem.favourite ? "star.fill" : "star") // Cambiar la imagen de estrella
                .foregroundColor(.yellow)
        }
    }
    
    private var respuesta: some View {
        VStack {
            TextField("Escriba su respuesta", text: $answer)
                .onSubmit {
                    handleAnswerSubmission()
                }
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Cambiar el estilo del TextField
                .padding(.horizontal)
            
            Button(action: {
                handleAnswerSubmission()
            }) {
                Text("Comprobar")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.init(red: 0.059, green: 0.859, blue: 0.718)) // Cambiar color del fondo del botón
                    .cornerRadius(10)
            }
            .padding(.top)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Resultado"),
                message: Text(answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == quizItem.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) ? "Respuesta Correcta" : "Respuesta Erronea"),
                dismissButton: .default(Text("Aceptar"))
            )
        }
    }
    
    private func handleAnswerSubmission() {
        if answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == quizItem.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
            scoresModel.add(answer: answer, quizItem: quizItem)
        }
        showAlert = true
    }
}

struct QuizPlayView_Previews: PreviewProvider {
    
    static var qm: QuizzesModel = {
        var qm = QuizzesModel()
        qm.load()
        return qm
    }()
    
    static var previews: some View {
        QuizPlayView(quizItem: qm.quizzes[0])
    }
}
