//
//  ContainerViewController.swift
//  SpotSwap
//
//  Created by Yaseen Al Dallash on 3/27/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, MenuContainerDelegate {
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    private var menuStatus = MenuStatus.hidden
    private let menuWidth: CGFloat = 160
    private let menuPopHideConstant: CGFloat = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Stylesheet.Colors.OrangeMain
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapViewControllerSegue"{
            if  let destination = segue.destination as? UINavigationController {
                if let root = destination.viewControllers.first as? MapViewController {
                    root.menuContainerDelegate = self

                }

            }
        }
    }
    

    static func storyBoardInstance()->ContainerViewController{
        let stroyBoard = UIStoryboard(name: "ContainerStoryBoard", bundle: nil)
        let containerViewController = stroyBoard.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
        return containerViewController
        
    }
    func trigerMenu() {
        switch menuStatus {
        case .hidden:
            UIView.animate(withDuration: 0.5, animations: {
                self.menuLeadingConstraint.constant += self.menuWidth
                self.view.layoutIfNeeded()
            }, completion: { (animated) in
                self.menuStatus = .visible
            })
        case .visible:
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.menuLeadingConstraint.constant += self.menuPopHideConstant
                self.view.layoutIfNeeded()
            }, completion: { (animated) in
                UIView.animate(withDuration: 0.5, animations: {
                    self.menuLeadingConstraint.constant -= self.menuWidth + self.menuPopHideConstant
                    self.view.layoutIfNeeded()
                }, completion: { (animated) in
                    self.menuStatus = .hidden
                })
            })
        }
    }
    

}
