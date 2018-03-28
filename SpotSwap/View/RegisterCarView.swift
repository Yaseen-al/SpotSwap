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
    var height = NSLayoutConstraint()
    
    lazy var cameraButton: UIButton = {
        var button = UIButton()
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    lazy var carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "defaultVehicleImage")
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
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
    
    lazy var carMakeTextField: SearchTextField = {
        let textField = SearchTextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        textField.placeholder = " Enter car make"
        textField.borderStyle = .none
        textField.backgroundColor = .white
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
        textField.placeholder = "Select Model"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var dropDownButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        //        button.layer.cornerRadius = 5
        button.setTitle("  Select model", for: .normal)
        button.setTitleColor(Stylesheet.Colors.LightGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        return button
    }()
    
    lazy var dropDownView: UIView = {
        let drpDwnVw = UIView()
        return drpDwnVw
    }()
    
    //    TableView
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = Stylesheet.Colors.PinkMain
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        superview?.bringSubview(toFront: dropDownView)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = Stylesheet.Colors.GrayMain
        setupViews()
    }
    
    
    override func layoutSubviews() {
        // here you get the actual frame size of the elements before getting
        // laid out on screen
        super.layoutSubviews()
        carImageView.layer.cornerRadius = carImageView.bounds.width/2.0
        carImageView.layer.masksToBounds = true
        carImageView.layer.borderColor = Stylesheet.Colors.OrangeMain.cgColor
        carImageView.layer.borderWidth = 4
        dropDownButton.contentHorizontalAlignment = .left
    }
    
    private func setupViews() {
        setupCarImage()
        setupCameraButton()
        setupMakeLabel()
        setupMakeTF()
        setupModelLabel()
        setupDropDownButton()
        setupDropDownView()
        setupTableView()
    }
    
    private func setupCarImage() {
        addSubview(carImageView)
        carImageView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.50)
            make.height.equalTo(carImageView.snp.width)
        }
    }
    
    private func setupCameraButton() {
        addSubview(cameraButton)
        cameraButton.snp.makeConstraints { (make) in
            make.top.equalTo(carImageView.snp.top)
            make.centerX.equalTo(carImageView.snp.centerX)
            make.width.equalTo(carImageView.snp.width)
            make.height.equalTo(carImageView.snp.width)
        }
        
    }
    
    private func setupMakeLabel() {
        addSubview(makeLabel)
        makeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(carImageView.snp.bottom).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(40)
        }
    }
    
    private func setupMakeTF() {
        addSubview(carMakeTextField)
        carMakeTextField.snp.makeConstraints { (make) in
            make.top.equalTo(makeLabel.snp.bottom).offset(5)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.6)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.05)
        }
    }
    
    private func setupDropDownButton() {
        addSubview(dropDownButton)
        dropDownButton.snp.makeConstraints { (make) in
            make.top.equalTo(modelLabel.snp.bottom).offset(5)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.6)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.05)
        }
    }
    
    private func setupModelLabel() {
        addSubview(modelLabel)
        modelLabel.snp.makeConstraints { (make) in
            make.top.equalTo(carMakeTextField.snp.bottom).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(40)
        }
    }
    
    private func setupModelTF() {
        addSubview(carModelTextField)
        carModelTextField.snp.makeConstraints { (make) in
            make.top.equalTo(modelLabel.snp.bottom).offset(5)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.6)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.05)
        }
    }
    
    private func setupDropDownView() {
        addSubview(dropDownView)
        dropDownView.snp.makeConstraints { (make) in
            make.top.equalTo(dropDownButton.snp.bottom)
            make.width.equalTo(dropDownButton.snp.width)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            height = dropDownView.heightAnchor.constraint(equalToConstant: 0)
        }
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(dropDownView.snp.top)
            make.leading.equalTo(dropDownView.snp.leading)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.trailing.equalTo(dropDownView.snp.trailing)
            make.bottom.equalTo(dropDownView.snp.bottom)
        }
    }
    
}

