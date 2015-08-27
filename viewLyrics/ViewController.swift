//
//  ViewController.swift
//  viewLyrics
//
//  Created by Ryan Rudzitis on 2015-08-26.
//  Copyright © 2015 Ryan Rudzitis. All rights reserved.
//

import UIKit
import MediaPlayer
import SafariServices

class ViewController: UIViewController {

    @IBOutlet weak var artworkView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    let musicPlayer = MPMusicPlayerController()
    let brain = URLBrain()
    
    @IBAction func lyricsPressed(sender: UIButton) {
        let title = musicPlayer.nowPlayingItem?.title
        
        let rapGeniusURLWithoutTitle = "http://google.com/search?btnI=1&q=rap+genius+"
        
        if title != nil {
            let encodedTitle = brain.encodeTitle(title!)
            let finalURL = rapGeniusURLWithoutTitle + encodedTitle
            
            print(finalURL)
            
            
            let svc = SFSafariViewController(URL: NSURL(string: finalURL)!)

            self.presentViewController(svc, animated: true, completion: nil)
            
            
            
            
            
        }
    }
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appDidBecomeActive:", name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    
    func appDidBecomeActive(notifcation: NSNotification) {
        titleLabel.text = musicPlayer.nowPlayingItem?.title
        artistLabel.text = musicPlayer.nowPlayingItem?.artist
        
        let artwork = musicPlayer.nowPlayingItem?.artwork
        
        let image = artwork?.imageWithSize(CGSizeMake(150, 150))
        
        if image != nil {
            artworkView.image = image
            self.view.addSubview(artworkView)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

