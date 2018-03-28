
import UIKit

class WalkthroughViewController: UIViewController {
    
    //view instance
    let walkthroughView = WalkthroughView()
    
    //MARK - Data model for each walkthrough screen
    var index = 0 //the current page index
    var headerText = ""
    var imageName = ""
    var descriptionText = ""
    
    //
    
    
    //just to make sure the status bar is white
    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWalkthroughView()
        //page control dots now know what page we are on
        walkthroughView.pageControl.currentPage = index
        
        walkthroughView.imageView.image = UIImage(named: imageName)
        
        walkthroughView.startButton.isHidden = (index == 3) ? false : true
        walkthroughView.nextButton.isHidden = (index == 3) ? true : false
        
        walkthroughView.startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        walkthroughView.nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }
    
    func setupWalkthroughView(){
        view.addSubview(walkthroughView)
        walkthroughView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    @objc func startTapped(sender: AnyObject) {
        
        //To keep track if this is the user's first time logging in
        //let userDefaults = UserDefaults.standard
        DataPersistence.manager.addStateToDefaults(state: true, UserDefaultsKeys.DisplayedWalkthrough)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //If the user clicks the next button, we will show the next page view controller
    @objc func nextTapped(sender: AnyObject) {
        let pageViewController = self.parent as! PageViewController //@28:43
        pageViewController.nextPageWithIndex(index: index)
    }
    
}

