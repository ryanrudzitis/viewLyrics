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
    @IBOutlet weak var rapGeniusBtn: UIButton!
    @IBOutlet weak var whoSampledBtn: UIButton!
    
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
    
    @IBAction func musicAppPressed(sender: AnyObject) {
        let stringURL = "music:"
        let url: NSURL = NSURL(string: stringURL)!
        UIApplication.sharedApplication().openURL(url)
    }
    
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appDidBecomeActive:", name: UIApplicationDidBecomeActiveNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appWillEnterForeground:", name: UIApplicationWillEnterForegroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "songDidChange:", name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification, object: nil)
        musicPlayer.beginGeneratingPlaybackNotifications()
    }
    
    
    func appDidBecomeActive(notifcation: NSNotification) {
       updateSongInfo()    }
    
    func appWillEnterForeground(notification: NSNotification) {
        print("will enter foreground")
        updateSongInfo()
        
    }
    
    func updateSongInfo() {
        if musicPlayer.nowPlayingItem != nil {
            titleLabel.text = musicPlayer.nowPlayingItem?.title
            artistLabel.text = musicPlayer.nowPlayingItem?.artist
            
            rapGeniusBtn.enabled = true
            whoSampledBtn.enabled = true
            
            let artwork = musicPlayer.nowPlayingItem?.artwork
            let image = artwork?.imageWithSize(CGSizeMake(150, 150))
            
            if image != nil {
                artworkView.image = image
                self.view.addSubview(artworkView)
            }

        } else {
            titleLabel.text = "No song playing"
            artistLabel.text = " "
            rapGeniusBtn.enabled = false
            whoSampledBtn.enabled = false
            
            artworkView.image = UIImage(named: "no_sign")
        }
    }
    
    func songDidChange(notification: NSNotification) {
        print("did cnhange")
        updateSongInfo()
    }
}

