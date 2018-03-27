//
//  MenuViewController.swift
//  SpotSwap
//
//  Created by Yaseen Al Dallash on 3/27/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    private let menuView = MenuView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuView.delegate = self
        view.backgroundColor = Stylesheet.Colors.OrangeMain
        setupMenuView()
    }
    func setupMenuView() {
        view.addSubview(menuView)
        menuView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
}
extension MenuViewController: MenuDelegate{
    // This will handle the signout from the menu
    func signOutButtonClicked(_ sender: MenuView) {
        AuthenticationService.manager.signOut { (error) in
            print(error)
            self.dismiss(animated: true, completion: nil)
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.loadLaunchViewController()
    }
    
}
