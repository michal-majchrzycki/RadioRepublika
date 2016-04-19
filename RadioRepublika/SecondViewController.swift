import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    
    let swiftBlogs = ["Poniedziałek", "", "Wtorek", "", "Środa", "", "Czwartek", "", "Piątek", "", "Sobota", "", "Niedziela"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       tableView.delegate = self
        tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.navigationController?.navigationBar.clipsToBounds = true
    }
    
    // MARK:  UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        
        let tableBorderLeft: CGFloat = 50
        let tableBorderRight: CGFloat = 50
        
        var tableRect: CGRect = self.view.frame
        tableRect.origin.x += tableBorderLeft
        tableRect.size.width -= tableBorderLeft + tableBorderRight
        tableView.frame = tableRect
        
        
       if indexPath.row % 2 == 0 {
        cell.textLabel?.text = swiftBlogs[row]
        cell.contentView.layer.borderColor = UIColor(
            red: 0/255.0,
            green: 24/255.0,
            blue: 136/255.0,
            alpha: 1.0).CGColor
        cell.contentView.layer.borderWidth = 1.5
        cell.contentView.layer.borderColor = UIColor(
            red: 0/255.0,
            green: 24/255.0,
            blue: 136/255.0,
            alpha: 1.0).CGColor
        cell.contentView.layer.cornerRadius = 15.0
        
        cell.textLabel!.highlightedTextColor = UIColor.redColor()
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = UIColor.clearColor()
        cell.selectedBackgroundView = myCustomSelectionColorView
        }
        else {
        cell.textLabel?.text = nil
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = UIColor.clearColor()
        cell.selectedBackgroundView = myCustomSelectionColorView
            }
        return cell
    }


    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
        return 50.0
        }
        else {
            return 7.7
        }
    }
   
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        tableView.allowsSelection = true
        
        if indexPath.row == 0 {
            performSegueWithIdentifier("segueMonday", sender:self)
        }
        if indexPath.row == 2 {
            performSegueWithIdentifier("segueTuesday", sender:self)
        }
        if indexPath.row == 4 {
            performSegueWithIdentifier("segueWednesday", sender:self)
        }
        if indexPath.row == 6 {
            performSegueWithIdentifier("segueThursday", sender:self)
        }
        if indexPath.row == 8 {
            performSegueWithIdentifier("segueFriday", sender:self)
        }
        if indexPath.row == 10 {
            performSegueWithIdentifier("segueSaturday", sender:self)
        }
        if indexPath.row == 12 {
            performSegueWithIdentifier("segueSunday", sender:self)
        }
    }
}