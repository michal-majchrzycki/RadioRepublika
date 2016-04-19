import UIKit
import AVFoundation
import MediaPlayer
import SystemConfiguration

class FirstViewController: UIViewController {
    @IBOutlet weak var playButton: UIButton!
    @IBAction func buttonPressed(sender: AnyObject) {
        toggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Remote Controller from locked screen:
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, withOptions: [])
        try! AVAudioSession.sharedInstance().setActive(true)
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        
        //Button Play - border, color & background:
        playButton.layer.cornerRadius = 15
        playButton.layer.borderWidth = 1.5
        playButton.layer.borderColor = UIColor(
            red: 0/255.0,
            green: 24/255.0,
            blue: 136/255.0,
            alpha: 1.0).CGColor
        playButton.layer.backgroundColor = UIColor.clearColor().CGColor

        
        // Hide bottom line for Navigation Controller & upper line for TabBar Controller:
        self.navigationController?.navigationBar.clipsToBounds = true
        self.tabBarController?.tabBar.clipsToBounds = true

        // Info about Radio name at the locked screen:
        if NSClassFromString("MPNowPlayingInfoCenter") != nil {
            let image:UIImage = UIImage(named: "logo_player_background")!
            let albumArt = MPMediaItemArtwork(image: image)
            let songInfo: NSMutableDictionary = [
                MPMediaItemPropertyTitle: "Radio Republika",
                MPMediaItemPropertyArtist: "Tv Republika - audio na żywo",
                MPMediaItemPropertyArtwork: albumArt
            ]
            MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = songInfo as NSObject as? [String : AnyObject]

        }
        
               }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    // Now playing functions:
    
    func toggle() {
        if RadioPlayer.sharedInstance.currentlyPlaying() {
            pauseRadio()
        } else {
            playRadio()
        }
    }
    
    // Check if internet connection is enabled:
    
    func playRadio() {
        RadioPlayer.sharedInstance.play()
        playButton.setImage(UIImage(named: "pause@3.png"), forState: UIControlState.Normal)
        
        if self.isConnectedToNetwork() {
            print("Connected to internet")
        }
        else {
            print(self.isConnectedToNetwork())
            let alertController = UIAlertController(title: "", message: "Brak połączenia z internetem", preferredStyle: .Alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
                print("you have pressed OK button");
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true, completion:nil)
            
        }
        
            }
    
    func pauseRadio() {
        RadioPlayer.sharedInstance.pause()
        playButton.setImage(UIImage(named: "play@3.png"), forState: UIControlState.Normal)
    }
    

}