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
        let artist = musicPlayer.nowPlayingItem?.artist
        
        if title != nil {
            let serviceName = (sender.titleLabel?.text)!
            let finalURL = brain.getURL(serviceName, songName: title!, artistName: artist!)
            
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
        print(musicPlayer.nowPlayingItem == nil)
        
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

