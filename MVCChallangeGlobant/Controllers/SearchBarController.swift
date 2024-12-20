//
//  SearchBarController.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 19/12/24.
//

import Foundation
import UIKit
import SwiftUI

protocol CarSearchDelegate: AnyObject{
    
    typealias DidFilterHandler = (_ result: [Any]) -> Void
    var inputText: String {get set}
    var dataSource: [Any] {get set}
    var didFilterHandler: DidFilterHandler? {get set}
    func filterMovies(searchText: String)
    func updateMovieListPage()
    
}





struct MovieGridControllerWrapper<VC: UIViewController>: UIViewControllerRepresentable {
    var viewController: VC

    func makeUIViewController(context: Context) -> VC {
        return viewController
    }

    func updateUIViewController(_ uiViewController: VC, context: Context) {
        // Update the UI if needed
    }
}

