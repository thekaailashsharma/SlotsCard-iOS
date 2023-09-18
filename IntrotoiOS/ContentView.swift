//
//  ContentView.swift
//  IntrotoiOS
//
//  Created by Admin on 16/09/23.
//

import SwiftUI
import Lottie

struct ContentView: View {
    
    @State private var label0 = ["apple", "cherry", "star"]
    
    @State private var label1 = ["cherry", "star","apple",]
    
    @State private var label2 = ["apple", "star", "cherry"]
    
    @State private var color = Color.white
    
    @State private var slots0 = [SlotsCards(color: Color.white, title: "apple"), SlotsCards(color: Color.white, title: "cherry"), SlotsCards(color: Color.white, title: "star"), SlotsCards(color: Color.white, title: "star"), SlotsCards(color: Color.white, title: "cherry"), SlotsCards(color: Color.white, title: "apple"), SlotsCards(color: Color.white, title: "cherry"), SlotsCards(color: Color.white, title: "apple"), SlotsCards(color: Color.white, title: "star")]
    
    @State private var isAnimationVisible = false
    
    
    var body: some View {
        
        VStack {
            
            
            ZStack {
                
                Rectangle()
                    .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
                    .edgesIgnoringSafeArea(.all)
                
                Rectangle()
                    .foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255))
                    .rotationEffect(Angle(degrees: 45))
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    TitleSlots()
                    
                    Spacer()
                    
                    VStack {
                        
                        HStack {
                            Cards(slots: $slots0[0])
                            Cards(slots: $slots0[1])
                            Cards(slots: $slots0[2])
                        }
                        HStack {
                            Cards(slots: $slots0[3])
                            Cards(slots: $slots0[4])
                            Cards(slots: $slots0[5])
                        }
                        HStack {
                            Cards(slots: $slots0[6])
                            Cards(slots: $slots0[7])
                            Cards(slots: $slots0[8])
                        }
                        
                    }
                    
                    Spacer()
                    
                    
                    
                    
                    
                }
                .padding([.top, .leading, .trailing])
                .blur(radius: isAnimationVisible ? 10: 0)
                
                
                VStack {
                    Spacer()
                    Button(action: {
                        withAnimation(Animation.spring()) {
                            self.slots0 =  self.slots0.shuffled()
                            (self.isAnimationVisible, self.slots0) = checkWinning(slots: slots0)
                        }
                    }) {
                        Text(isAnimationVisible ? "Play Again": "Shuffle")
                            .foregroundColor(.black)
                            .padding(.all, 10)
                            .background(.white.opacity(0.5))
                            .cornerRadius(20)
                    }
                    
                }
                .padding(.bottom, 20)
                
                if(isAnimationVisible){
                    ZStack {
                        VStack {
                            Spacer()
                            MyLottieAnimation(url: Bundle.main.url(forResource: "wins", withExtension: "lottie")!)
                                .scaledToFit()
                            Spacer()
                        }
                        MyLottieAnimation(url: Bundle.main.url(forResource: "confetti", withExtension: "lottie")!,
                                          loopMode: .playOnce)
                        .scaledToFit()
                        
                    }
                }
                
                
                
            }
        }
    }
    
    
    func checkWinning(slots: [SlotsCards]) -> (isWinner: Bool, slots: [SlotsCards]) {
        var newSlots = slots
        
        // Define winning combinations
        let winningCombinations: [[Int]] = [
            [0, 3, 6], [1, 4, 7], [2, 5, 8],  // Vertical
            [0, 1, 2], [3, 4, 5], [6, 7, 8],  // Horizontal
            [0, 4, 8], [2, 4, 6]              // Diagonal
        ]
        
        var isWinning = false
        
        for combination in winningCombinations {
            let firstSlot = newSlots[combination[0]]
            let secondSlot = newSlots[combination[1]]
            let thirdSlot = newSlots[combination[2]]
            
            // Check if all three slots have the same title and are not empty
            if firstSlot.title == secondSlot.title && secondSlot.title == thirdSlot.title && firstSlot.title != "" {
                isWinning = true
                
                // Set the color to green for the winning slots
                newSlots[combination[0]].color = .green
                newSlots[combination[1]].color = .green
                newSlots[combination[2]].color = .green
            }
        }
        
        // If no winning condition, reset colors to white
        if !isWinning {
            newSlots = newSlots.map { slot in
                var updatedSlot = slot
                updatedSlot.color = .white
                return updatedSlot
            }
        }
        
        return (isWinner: isWinning, slots: newSlots)
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MyLottieAnimation: UIViewRepresentable {
    
    let url: URL
    var loopMode: LottieLoopMode = .repeat(2)
    
    
    func makeUIView(context: Context) -> some UIView {
        UIView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let animationView = LottieAnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        uiView.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: uiView.widthAnchor),
            
            animationView.heightAnchor.constraint(equalTo: uiView.heightAnchor)
        ])
        
        DotLottieFile.loadedFrom(url: url) {
            result in switch result {
            case .success(let success):
                animationView.loadAnimation(from: success)
                animationView.loopMode = loopMode
                animationView.play()
            case .failure(let failure):
                print(failure)
            }
        }
        
    }
}

struct SlotsCards {
    var color: Color
    var title: String
}

