//
//  RegisterCarView.swift
//  SpotSwap
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import UIKit
import SnapKit

class RegisterCarView: UIView {

    lazy var carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    lazy var makeLabel: UILabel = {
        let label = UILabel()
        label.text = "Make"
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    lazy var carMakeTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        textField.placeholder = "Enter car make"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var modelLabel: UILabel = {
        let label = UILabel()
        label.text = "Model"
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    lazy var carModelTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        textField.placeholder = "Enter car model"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = Stylesheet.Colors.PinkMain
        setupViews()
    }
    
    
    override func layoutSubviews() {
        // here you get the actual frame size of the elements before getting
        // laid out on screen
        super.layoutSubviews()
    }
    
    private func setupViews() {
    }
    
}
