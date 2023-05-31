//
//  DraggablePageRepresentable.swift
//  Draggable
//
//  Created by Po hin Ma on 29/5/2023.
//

import Foundation
import SwiftUI

struct DraggablePageRepresentable: UIViewControllerRepresentable {
    @Binding var page: Page

    func makeUIViewController(context: Context) -> DraggablePageViewController {
        let viewController = DraggablePageViewController(page: page)
        return viewController
    }

    func updateUIViewController(_ viewController: DraggablePageViewController, context: Context) {
        // Update your view controller here if needed
        viewController.page = page
    }
}
