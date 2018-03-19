import UIKit
import Firebase

class LaunchViewController: UIViewController {
    
    //view instance
    let launchView = LaunchView()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(launchView)
        launchView.segmentedControl.addTarget(self, action: #selector(segmentorTapped), for: .valueChanged)
        configureNavBar()
        view.backgroundColor = .white
    }
    func configureNavBar(){
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        configureNavBar()
    }
    
    //MARK: - Segmentor Actions
    @objc func segmentorTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            let loginVc = LoginViewController()
            self.navigationController?.pushViewController(loginVc, animated: true)
        default:
            break
            //TODO: Present signin
//            let signupVc =
//            present(SignupViewController, animated: true, completion: nil)
        }
    }
    
}




