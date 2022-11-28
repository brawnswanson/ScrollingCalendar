//
//  SwiftUIView.swift
//  
//
//  Created by Daniel Pressner on 25.11.22.
//

import SwiftUI

struct CalendarCellTitle: View {
  
  let text: String
  
  var body: some View {
    HStack {
      Text(text)
        .padding(.horizontal)
      Spacer()
    }
  }
}
