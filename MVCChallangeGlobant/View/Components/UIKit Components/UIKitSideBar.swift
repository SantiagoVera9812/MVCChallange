//
//  UIKitSideBar.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 22/12/24.
//

import Foundation
import UIKit


protocol SidebarViewControllerDelegate: AnyObject {
    func didChangeLanguage(to language: String)
    func didChangeView(to viewType: ViewType)
}


class SidebarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    
    
    var selectedLanguage: String = "pt"
    var howView: ViewType = .grid
    weak var delegate: SidebarViewControllerDelegate?
    var changeLanguageTitle = String.localizedString(forKey: "change_language")
    var log_off = String.localizedString(forKey: "log_off")
    var changeView = String.localizedString(forKey: "toggle_view")
    var options: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        self.options = [changeLanguageTitle, changeView, log_off]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            changeLanguage()
        case 1:
            toggleView()
        case 2:
            logOut()
        default:
            break
        }
        
    }
    
    // MARK: - Actions
    
    func changeLanguage() {
        let alert = UIAlertController(title: changeLanguageTitle, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "English", style: .default, handler: { _ in
            self.selectedLanguage = "en"
            self.delegate?.didChangeLanguage(to: self.selectedLanguage)
            print("Language changed to English")
        }))
        alert.addAction(UIAlertAction(title: "Spanish", style: .default, handler: { _ in
            self.selectedLanguage = "es"
            self.delegate?.didChangeLanguage(to: self.selectedLanguage)
            print("Language changed to Spanish")
        }))
        alert.addAction(UIAlertAction(title: "Portuguese", style: .default, handler: { _ in
            self.selectedLanguage = "pt"
            self.delegate?.didChangeLanguage(to: self.selectedLanguage)
            print("Language changed to Portuguese")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func toggleView() {
        
        let alert = UIAlertController(title: changeView, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Grid View", style: .default, handler: { _ in
            self.howView = .grid
            self.delegate?.didChangeView(to: .grid)
            print("Language changed to grid")
        }))
        alert.addAction(UIAlertAction(title: "Simple List View", style: .default, handler: { _ in
            self.howView = .simple
            self.delegate?.didChangeView(to: .simple)
            print("Language changed to simple list")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func logOut() {
        
        let loginController = LoginViewController()
        
        let navBarStyle = NavigationBarTitle(title: "Login")
        
        navBarStyle.configure(loginController)
        
        self.navigationController?.pushViewController(loginController, animated: true)
    
        print("User logged out")
    }
}
