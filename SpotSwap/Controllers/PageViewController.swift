
import UIKit

class PageViewController: UIPageViewController {
    
    let walkthroughVC = WalkthroughViewController()
    
    //some hard coded data for our walkthrough screens
    var pageHeaders = ["Reserve a parking spot", "Offer a parking spot", "Earn points!", "Find a spot!"]
    var pageImages: [UIImage] = [
        #imageLiteral(resourceName: "phone"), #imageLiteral(resourceName: "phone"),#imageLiteral(resourceName: "phone"), #imageLiteral(resourceName: "phone")
    ]
    var pageDescriptions = ["On the map, tap the space you would like to reserve", "Once you're ready to leave your parking spot, swipe the leaving button", "Offer more spots gain more points! At 100 points you'll get access to parking spots before anyone else", ""]
    
    var colors = [UIColor.red, UIColor.blue, UIColor.orange]
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Stylesheet.Colors.GrayMain
        //view.backgroundColor = .green// for testing
        
        //this class is the page view controller's data source itself
        self.dataSource = self
        
        //create the first walkthrough VC
        if let startWalkthroughVC = self.viewControllerAtIndex(index: 0) {
            setViewControllers([startWalkthroughVC], direction: .forward, animated: true, completion: nil)
        }
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
        walkthroughVC.walkthroughView.headerLabel.text = pageHeaders[index]
        walkthroughVC.walkthroughView.descriptionLabel.text = pageDescriptions[index]
        walkthroughVC.index = index
        walkthroughVC.walkthroughView.tutorialImageView.image = pageImages[index]
        //walkthroughVC.view.backgroundColor = colors[index] //for testing
        
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

//MARK: - UIPageViewControllerDelegates
extension PageViewController: UIPageViewControllerDelegate {
    
    func tutorialPageViewController(tutorialPageViewController: PageViewController,
                                    didUpdatePageCount count: Int) {
        walkthroughVC.walkthroughView.pageControl.numberOfPages = count
    }
    
    func tutorialPageViewController(tutorialPageViewController: PageViewController,
                                    didUpdatePageIndex index: Int) {
        walkthroughVC.walkthroughView.pageControl.currentPage = index
    }
    
    
    
}

