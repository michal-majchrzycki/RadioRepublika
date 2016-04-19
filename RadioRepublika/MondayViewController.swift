import UIKit

class MondayViewController: UIViewController, NSXMLParserDelegate
{
    @IBOutlet weak var tbData: UITableView!
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.beginParsing()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func beginParsing()
    {
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string:"https://dl.dropboxusercontent.com/s/a9nyq2xs2frunke/poniedzialek.rss"))!)!
        parser.delegate = self
        parser.parse()
        
        tbData!.reloadData()
    }
    
    //XMLParser Methods
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        if (elementName as NSString).isEqualToString("item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("item") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "title")
            }
            
            posts.addObject(elements)
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        if element.isEqualToString("title") {
            title1.appendString(string)
        } else if element.isEqualToString("pubDate") {
            date.appendString(string)
        }
    }
    
    //Tableview Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        
        if(cell.isEqual(NSNull)) {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as! UITableViewCell;
        }
        if indexPath.row % 2 == 0 {
            cell.textLabel?.textColor = UIColor.redColor()
            cell.textLabel?.font = UIFont.boldSystemFontOfSize(12)
        }
        else {
            cell.textLabel?.textColor = UIColor(
                red: 0/255.0,
                green: 24/255.0,
                blue: 136/255.0,
                alpha: 1.0)
            cell.textLabel?.font = UIFont(name:"Baskerville", size:15)
        }
        
        cell.textLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("title") as! NSString as String
        
        return cell as UITableViewCell
    }
    
    @IBAction func doneButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
}