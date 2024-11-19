//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mark Santoro on 11/19/24.
//

import SwiftUI

struct ContentView: View {
   @State var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland",
                    "Spain","UK","Russia","US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
     
    @State private var showingScore = false
    @State private var scoreTitle = ""
          
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue,.gray],startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
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
            
            
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQustion)
                
            } message: {
                Text("Your score is ??")
            }
        }
    
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer{
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
 
    func askQustion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
        
}

#Preview {
    ContentView()
}
