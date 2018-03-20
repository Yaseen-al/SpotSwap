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
        view.backgroundColor = .orange
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
            //TODO: Send user to the map homepage
            let mapView = MapViewController()
            self.present(mapView, animated: true, completion: nil)
        }) { (error) in
            //alert
        }
        
    }

}
