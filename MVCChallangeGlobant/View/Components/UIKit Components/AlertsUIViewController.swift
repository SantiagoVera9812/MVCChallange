//
//  AlertsUIViewController.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 13/12/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showErrorAlertWithMessage(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default) { _ in
            alertController.dismiss(animated: true)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
}
