//
//  TitleSlots.swift
//  IntrotoiOS
//
//  Created by Admin on 17/09/23.
//

import SwiftUI

struct TitleSlots: View {
    var body: some View {
        
        VStack{
            
            HStack {
                Image(systemName: "star.fill").foregroundColor(.yellow)
                Text("Swift UI Slots")
                    .bold()
                Image(systemName: "star.fill").foregroundColor(.yellow)
            }.scaleEffect(2).padding(.bottom, 20)
            
            Text("Credits: 1000")
                .foregroundColor(.black)
                .padding(.all, 10)
                .background(.white.opacity(0.5))
                .cornerRadius(20)
            
        }
    }
}

struct TitleSlots_Previews: PreviewProvider {
    static var previews: some View {
        TitleSlots()
    }
}
