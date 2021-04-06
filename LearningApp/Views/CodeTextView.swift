//
//  CodeTextView.swift
//  LearningApp
//
//  Created by Sam Burch on 23/03/2021.
//

import SwiftUI
import AVKit

struct CodeTextView: UIViewRepresentable {

    @EnvironmentObject var model: ContentModel
    
    func makeUIView(context: Context) -> UITextView {
        
        let textView = UITextView()
        textView.isEditable = false
        
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {

        // Set the attributed text view
        textView.attributedText = model.codeText
        
        // Scroll back to top
        textView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
    }
        
}

struct CodeTextView_Previews: PreviewProvider {
    static var previews: some View {
        CodeTextView()
    }
}
