//
//  Cards.swift
//  IntrotoiOS
//
//  Created by Admin on 17/09/23.
//

import SwiftUI

struct Cards: View {
    
    @Binding var slots: SlotsCards

    
    var transition: AnyTransition = .slide
    
    var body: some View {
        
        HStack {
            
            Image(slots.title)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .background(slots.color.opacity(0.5))
                .cornerRadius(20)
            
            
        }.transition(transition).zIndex(2)
        
    }
}

struct Cards_Previews: PreviewProvider {
    static var previews: some View {
        Cards(slots: Binding.constant(SlotsCards(color: Color.white, title: "apple")),  transition: .slide )
    }
}
