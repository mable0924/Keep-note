//
//  SelectView.swift
//  Draggable
//
//  Created by Po hin Ma on 29/5/2023.
//

import Foundation
import SwiftUI

struct SelectView: View {
    @State private var isPresented: Bool = false
    var viewModel: DraggablePageViewModel
    var columnsCount: Int
    var index: Int
    
    var body: some View {
        VStack() {
            Image(systemName: "scribble.variable")
                .resizable()
                .frame(width: UIScreen.main.bounds.width / CGFloat(columnsCount) * 0.35, height: UIScreen.main.bounds.width / CGFloat(columnsCount) * 0.35)
                .padding(EdgeInsets(top: 20, leading: 45, bottom: 20, trailing: 45))
            Text(viewModel.page.name+"\(index + 1)")
                .font(.footnote)
                .frame(width: UIScreen.main.bounds.width / CGFloat(columnsCount) * 0.35 + 90, height: 50)
                .background(Color.black.opacity(0.1))
        }
        .background(.white)
        .cornerRadius(10)
        .compositingGroup()
        .shadow(radius: 3, x: 0, y: 0)
        .onTapGesture {
            isPresented.toggle()
        }
        .fullScreenCover(isPresented: $isPresented) {
            DraggablePage(viewModel: viewModel, isPresented: $isPresented)
        }
    }
}
