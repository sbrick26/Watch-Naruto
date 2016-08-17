//
//  ViewEpisodeController.swift
//  Watch Naruto
//
//  Created by Swayam Barik on 8/16/16.
//  Copyright © 2016 Swayam Barik. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class ViewEpisodeController: UIViewController{
    
    @IBOutlet weak var episodeLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        episodeLabel.text = "Episode \(episodeInfoForDisplay)"
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //episodeLabel.text = episodeInfoForDisplay
        let triggerTime = (Int64(NSEC_PER_SEC) * 1)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            let videoURL = NSURL(string: "http://mp4engine.com:182/d/a2cdi3vdcqqgkpskitcklfei5g73tibmy5ytfkqjgxsskyupqy2avfqp/[SD]_Naruto_Hurricane_Chronicles_-_001-002[25846B77].mp4")
            let player = AVPlayer(URL: videoURL!)
            let playerLayer = AVPlayerLayer(player: player)
            
            playerLayer.frame = CGRectMake(0, 0, 100, 100)
            self.view.layer.addSublayer(playerLayer)
            player.play()
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    


}