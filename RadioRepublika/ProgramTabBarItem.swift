import UIKit
class ProgramTabBarItem: UINavigationController
{
    @IBOutlet weak var programTabBarItem: UITabBarItem!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        programTabBarItem.setTitleTextAttributes([
            NSFontAttributeName : (UIFont(name: "Baskerville", size: 12.0))!
            ]
            , forState: .Normal)
        
    }
    
}