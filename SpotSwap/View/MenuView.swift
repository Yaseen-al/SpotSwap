//
//  MenuView.swift
//  SpotSwap
//
//  Created by Yaseen Al Dallash on 3/20/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import UIKit
//MARK: - Delegate protocols
protocol MenuDelegate {
    func signOutButtonClicked(_ sender: MenuView)
}
//MARK: - MenueStatus enum
enum MenuStatus{
    case visible
    case hidden
}
class MenuView: UIView {
    //MARK: - Properties
    
    var menueStatus = MenuStatus.hidden
    var delegate: MenuDelegate?
    //MARK: - Content
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "defaultProfileImage")
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "SweetCardi"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    lazy var userPointsLabel: UILabel = {
        let label = UILabel()
        label.text = "Points : 10"
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    lazy var signOutButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Sign out", for: .normal)
        button.addTarget(self, action: #selector(signOutButtonAction(_:)), for: .touchUpInside)
        button.backgroundColor = .yellow
        return button
    }()
    lazy var stackView: UIStackView = {
        let sView = UIStackView(arrangedSubviews: [userPointsLabel, signOutButton])
        sView.spacing = 5
        sView.axis = .vertical
        sView.backgroundColor = .yellow
        sView.distribution = .fillEqually
        return sView
    }()
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Stylesheet.Colors.GrayMain
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Layout subViews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImage.layer.cornerRadius = profileImage.bounds.size.width / 2.0
        profileImage.layer.masksToBounds = true
        
    }
    private func setupViews(){
        setupProfileImage()
        setupUserNameLabel()
        setupStackView()
    }
    private func setupSignOutButton(){
        addSubview(signOutButton)
        signOutButton.snp.makeConstraints { (constraint) in
            constraint.center.equalTo(snp.center)
        }
    }
    private func setupProfileImage(){
        addSubview(profileImage)
        profileImage.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(snp.top).offset(20)
            constraint.centerX.equalTo(snp.centerX)
            constraint.width.height.equalTo(snp.width).multipliedBy(0.65)
        }
    }
    private func setupUserNameLabel(){
        addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(profileImage.snp.bottom).offset(10)
            constraint.centerX.equalTo(profileImage.snp.centerX)
            constraint.width.equalTo(snp.width).multipliedBy(0.85)
        }
    }
    private func setupStackView(){
        addSubview(stackView)
        stackView.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(userNameLabel.snp.bottom).offset(10)
            constraint.leading.equalTo(snp.leading).offset(5)
            constraint.trailing.equalTo(snp.trailing)
            constraint.height.equalTo(snp.height).multipliedBy(0.45)
        }
    }
    //MARK: - Button Actions
    
    @objc func signOutButtonAction(_ sender: UIButton){
        delegate?.signOutButtonClicked(self)
    }
    //MARK: - Menu Handling
    
    public func handleMenu(_ mainView: UIView, sender: UIBarButtonItem){
        sender.isEnabled = false
        switch menueStatus {
        case .hidden:
            showMenu(mainView, sender: sender)
        case .visible:
            hideMenu(mainView, sender: sender)
        }
    }
    func addMaskToMainView(_ mainView: UIView) {
        let layerMask: UIView = {
            let view = UIView(frame: UIScreen.main.bounds)
            view.backgroundColor = .black
            view.layer.opacity = 0.25
            view.tag = 99
            return view
        }()
        
        mainView.addSubview(layerMask)
    }
    private func hideMenu(_ mainView: UIView, sender: UIBarButtonItem) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.frame.origin.x += 15
            mainView.frame.origin.x += 15
        }) { [weak self](completed) in
            guard let menue = self else {return}
            UIView.animate(withDuration: Double(0.5), animations: {
                menue.frame.origin.x -= menue.bounds.width + 15
                mainView.frame.origin.x -= menue.bounds.width + 15
                menue.layoutIfNeeded()
                for view in mainView.subviews{
                    if view.tag == 99 {
                        view.removeFromSuperview()
                    }
                }
            }, completion: { (completed) in
                sender.isEnabled = true
            })
            
        }
        menueStatus = .hidden
    }
    
    private func showMenu(_ mainView: UIView, sender: UIBarButtonItem) {
        addMaskToMainView(mainView)
        UIView.animate(withDuration: Double(0.5), animations: {
            
        })
        UIView.animate(withDuration: Double(0.5), animations: {
            self.frame.origin.x += self.bounds.width
            mainView.frame.origin.x += self.bounds.width
            self.layoutIfNeeded()
        }) { (completed) in
            sender.isEnabled = true
        }
        menueStatus = .visible
    }
    
}
