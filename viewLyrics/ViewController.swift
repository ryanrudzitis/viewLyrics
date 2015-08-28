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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet weak var artworkView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var rapGeniusBtn: UIButton!
    @IBOutlet weak var whoSampledBtn: UIButton!
    
    let musicPlayer = MPMusicPlayerController()
    let brain = URLBrain()
    var resultSearchController = UISearchController()
    
    var myTableView = UITableView()
    var items = ["Ryan", "Rocks", "Tap to dismiss"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appDidBecomeActive:", name: UIApplicationDidBecomeActiveNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appWillEnterForeground:", name: UIApplicationWillEnterForegroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "songDidChange:", name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification, object: nil)
        musicPlayer.beginGeneratingPlaybackNotifications()
        
        myTableView.frame = CGRectMake(0, 0 - view.bounds.height, view.bounds.width, view.bounds.height-100)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.delegate = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.userInteractionEnabled = true
            controller.searchBar.hidden = false
            
            self.myTableView.tableHeaderView = controller.searchBar
            
            return controller
        })()

        
        
        myTableView.alpha = CGFloat(0.0)
        //myTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        //UIApplication.sharedApplication().keyWindow?.addSubview(myTableView)
        UIApplication.sharedApplication().keyWindow?.subviews.last?.addSubview(myTableView)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCellWithIdentifier("cell")
        
        cell?.textLabel!.text = self.items[indexPath.row]
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveLinear, animations: {
            self.resultSearchController.searchBar.resignFirstResponder()
            self.resultSearchController.active = false
            self.myTableView.frame = CGRectMake(0, 0 - self.view.bounds.height, self.view.bounds.width, self.view.bounds.height)
            self.myTableView.alpha = CGFloat(0.0)
            
            }, completion: nil)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        

    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
       
    }
    
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
    
    @IBAction func searchPressed(sender: AnyObject) {
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveLinear, animations: {
            
            self.myTableView.frame = CGRectMake(0, 20, self.view.bounds.width, self.view.bounds.height - 20)
            self.myTableView.alpha = CGFloat(1.0)
            //self.resultSearchController.searchBar.becomeFirstResponder()
            
            }, completion: nil)
        
           }
    
    @IBAction func musicAppPressed(sender: AnyObject) {
        let stringURL = "music:"
        let url: NSURL = NSURL(string: stringURL)!
        UIApplication.sharedApplication().openURL(url)
    }
    
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
//        let query = MPMediaQuery.songsQuery()
//        let hasMoney = MPMediaPropertyPredicate(value: "money", forProperty: MPMediaItemPropertyTitle, comparisonType: .Contains)
//        query.addFilterPredicate(hasMoney)
//        let result = query.collections
//        
//        for song in result! {
//            print(song.representativeItem?.title)
//        }
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
        updateSongInfo()
    }
}

