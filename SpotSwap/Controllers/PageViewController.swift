
import UIKit

class PageViewController: UIPageViewController {
    
    //some hard coded data for our walkthrough screens
    var pageHeaders = ["Reserve a parking spot", "Offer a parking spot", "Earn points!"]
    var pageImages = ["defaultProfileimage", "spotSwapLogo", "SpotSwapIcon"]
    var pageDescriptions = ["blah", "blah", "blah"]
    
    var colors = [UIColor.red, UIColor.blue, UIColor.orange]
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        //this class is the age view controller's data source itself
        self.dataSource = self
        
        //create the first walkthrough VC
        if let startWalkthroughVC = self.viewControllerAtIndex(index: 0) {
            setViewControllers([startWalkthroughVC], direction: .forward, animated: true, completion: nil)
        }
        
        //set scroll direction
        
        //self.transitionStyle =
        
        //PageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    //MARK - Navigate
    func nextPageWithIndex(index: Int) {
        //if we do have the next page ...
        if let nextWalkthroughVC = self.viewControllerAtIndex(index: index + 1) {
            setViewControllers([nextWalkthroughVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func viewControllerAtIndex(index: Int) -> WalkthroughViewController? {
        if index == NSNotFound || index < 0 || index >= self.pageDescriptions.count {
            return nil
        }
        
        //TODO:Change to dependency injection?
        let walkthroughVC = WalkthroughViewController()
        walkthroughVC.imageName = pageImages[index]
        //walkthroughVC.headerText = pageHeaders[index]
        walkthroughVC.walkthroughView.headerLabel.text = pageHeaders[index]
        walkthroughVC.descriptionText = pageDescriptions[index]
        walkthroughVC.index = index
        walkthroughVC.view.backgroundColor = colors[index]
        
        return walkthroughVC
    }
    
}


//MARK: - UIPageViewControllerDataSource
extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkthroughViewController).index
        index -= 1
        
        return self.viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkthroughViewController).index //@14:38
        index += 1
        return viewControllerAtIndex(index: index)//self.viewControllers?.index(of: index)
        
    }
    
    
}

