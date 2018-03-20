import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    //view instance
    let loginView = LoginView()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        loginView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        view.backgroundColor = Stylesheet.Colors.OrangeMain
        configureNavBar()
    }
 
    func configureNavBar(){
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: - Setup Button Actions
    @objc func loginTapped(sender:UIButton!) {
        print("I've been tapped!")
        //TODO: Call firebase manager to authenticate the user and login
        AuthenticationService.manager.signIn(email: loginView.emailTextField.text!, password: loginView.passwordTextField.text!, completion: { (user) in
            //present alert
            let alert = UIAlertController(title: "Login Successful!", message: "Finding nearby parking spots", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            //TODO: Send user to the map homepage
            let mapView = MapViewController()
            self.present(mapView, animated: true, completion: nil)
            
        }) { (error) in
            let alert = UIAlertController(title: "Login Error!", message: "\(error)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
    }

}
