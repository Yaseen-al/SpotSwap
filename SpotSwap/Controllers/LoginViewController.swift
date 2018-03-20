import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    //view instance
    let loginView = LoginView()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        self.loginView.passwordTextField.delegate = self
        self.loginView.emailTextField.delegate = self
        loginView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        view.backgroundColor = Stylesheet.Colors.OrangeMain
        configureNavBar()
    }
    
    func configureNavBar(){
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: - Setup Button Actions
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
                let mapView = MapViewController().inNavController()
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
