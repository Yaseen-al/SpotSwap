import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    //view instance
    let loginView = LoginView()
    
    var keyboardHeight: CGFloat = 0
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        self.loginView.passwordTextField.delegate = self
        self.loginView.emailTextField.delegate = self
        loginView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        view.backgroundColor = Stylesheet.Colors.OrangeMain
        configureNavBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    }
    
    func configureNavBar(){
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        let barButton = UIBarButtonItem(customView: loginView.loginButton)
        //assigns button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    //MARK: - Setup Button Action
    @objc func loginTapped(sender:UIButton!) {
        guard let emailText = loginView.emailTextField.text, let passwordText = loginView.passwordTextField.text else{
            //TODO Kaniz handle the errors
            return
        }
        print("I've been tapped!")
        //TODO: Call firebase manager to authenticate the user and login
        AuthenticationService.manager.signIn(email: emailText, password: passwordText, completion: { (user) in
            //present alert
            let alert = UIAlertController(title: "Login Successful!", message: "Finding nearby parking spots", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "ok", style: .default, handler: { (alertAction) in
                let mapView = ContainerViewController.storyBoardInstance()
                self.present(mapView, animated: true, completion: nil)
            })
            alert.addAction(alertAction)
            self.present(alert, animated: true)
            
        }) { (error) in
            let alert = UIAlertController(title: "Login Error!", message: "\(error)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    
    //MARK: - Setup Keyboard Handling
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardHeight == 0 {
                keyboardHeight = keyboardSize.height
            }else{
                return
            }
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.view.frame.origin.y -= self.keyboardHeight
            }, completion: nil)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.view.frame = self.view.bounds
        }) { (animated) in
            self.keyboardHeight = 0
        }
    }
}

//MARK: - textFieldDelegate
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard textField.text != nil else {
            return false
        }
        return true
    }
}
