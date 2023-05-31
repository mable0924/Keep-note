//
//  DraggablePageViewController.swift
//  Draggable
//
//  Created by Po hin Ma on 29/5/2023.
//

import UIKit
import SwiftUI

class DraggablePageViewController: UIViewController {
    var page: Page // Your Page model

    init(page: Page) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

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
