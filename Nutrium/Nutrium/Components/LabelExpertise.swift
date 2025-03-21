//
//  LabelExpertise.swift
//  Nutrium
//
//  Created by Gloria Martins on 19/03/2025.
//

import SwiftUI

struct LabelExpertise: View {
    let text: String
    
    var body: some View {
        Text(text)
            .padding(15)
            .background(.lightGreen)
            .cornerRadius(20)
    }
}

#Preview {
    LabelExpertise(text: "Weight Loss")
}
