//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mark Santoro on 11/19/24.
//

import SwiftUI

struct ContentView: View {
   @State var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland",
                    "Spain","UK","Ukraine","US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
     
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionCount = 0
    @State private var maxQuestionReached = false
    @State private var questionMax = "Max number of questions reached"
    
         
    var body: some View {
        ZStack{
            //  LinearGradient(colors: [.blue,.gray],startPoint: .top, endPoint: .bottom)
            RadialGradient(stops:[
                .init(color: Color(red:0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red:0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 300, endRadius: 700)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                        //    .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                        
                    }
                    
                    ForEach(0..<3) {number in
                        Button{
                            flagTapped(number)
                        }label:{
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical,20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
                
            }
            .padding()
        }
        .alert(questionMax, isPresented: $maxQuestionReached){
        Button("Reset Game", action: resetGame)
            }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
                
            } message: {
                Text("Your score is \(score)")
            }
        }
    
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong, the correct answer is: \(countries[correctAnswer])"
            if score > 0{
                score -= 1
            }
            
        }
        
        showingScore = true
        questionCount += 1
    }
 
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        if questionCount == 7 {
            maxQuestionReached = true
        } else {
            maxQuestionReached = false
        }
    }
    
    
    func resetGame() {
        score = 0
        countries.shuffle()
        questionCount = 0
        
    }
        
}

#Preview {
    ContentView()
}
