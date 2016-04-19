import UIKit
class RadioTabBarItem: UINavigationController
{
    @IBOutlet weak var radioTabBarItem: UITabBarItem!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        radioTabBarItem.setTitleTextAttributes([
            NSFontAttributeName : (UIFont(name: "Baskerville", size: 12.0))!
            ]
            , forState: .Normal)
        
    }
    
}