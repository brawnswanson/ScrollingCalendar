//
//  SwiftUIView.swift
//  
//
//  Created by Daniel Pressner on 25.11.22.
//

import SwiftUI

struct DayButtonLabel: View {
  
  let text: String
  let isFilled: Bool
  
  var body: some View {
    ZStack {
      Text(text)
      Circle()
        .stroke(lineWidth: 2.0)
        .foregroundColor(.blue)
        .opacity((isFilled ? 1.0 : 0.0))
    }
    .frame(width: 40.0)
  }
}
