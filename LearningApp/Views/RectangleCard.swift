//
//  RectangleCard.swift
//  LearningApp
//
//  Created by Sam Burch on 06/04/2021.
//

import SwiftUI

struct RectangleCard: View {
    
    var color = Color.white
    
    var body: some View {

        Rectangle()
            .foregroundColor(color)
            .shadow(radius: 5)
            .cornerRadius(10)
        
    }
}

struct RectangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard()
    }
}
