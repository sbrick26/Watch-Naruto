//
//  VideoTableViewController.swift
//  Watch Naruto
//
//  Created by Swayam Barik on 8/16/16.
//  Copyright © 2016 Swayam Barik. All rights reserved.
//

import Foundation
import UIKit

var episodeInfoForDisplay = ""
var episodeLinkForDisplay = ""

class VideoTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    var filteredEpisodes = [String]()
    var resultSearchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.placeholder = "Enter Episode Number"
        searchController.searchBar.keyboardType = .NumberPad
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if searchController.active && searchController.searchBar.text != "" {
            episodeInfoForDisplay = filteredEpisodes[indexPath.row]
            var index = 0
            for episode in episodeNames{
                if episode == episodeInfoForDisplay
                {
                    index = episodeNames.indexOf(episode)!
                }
            }
            episodeLinkForDisplay = videoLinks[index]
            print(episodeLinkForDisplay)
            
        } else {
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if cell?.reuseIdentifier == "FirstCell"{
                print("first Cell was tapped")
            }
            else{
                episodeInfoForDisplay = episodeNames[indexPath.row-1]
                episodeLinkForDisplay = videoLinks[indexPath.row-1]
//                let episodecell = cell as! VideoMenuCell
//                print( (episodecell.episodeTitle.text)!)
//                episodeInfoForDisplay = (episodecell.episodeTitle.text)!
            }

        }
        
        
  
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }


    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if searchController.active && searchController.searchBar.text != "" {
            return self.filteredEpisodes.count
        }
        return episodeNames.count+1

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        if searchController.active && searchController.searchBar.text != "" {
            let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath)as!VideoMenuCell
            cell.textLabel?.text = self.filteredEpisodes[indexPath.row]
            return cell
        } else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("FirstCell", forIndexPath: indexPath)as!LatestVideoCell
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath)as!VideoMenuCell
                cell.episodeTitle.text = "Episode \(episodeNames[indexPath.row-1])"
                return cell
            }
        }
        
        
    }
   
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredEpisodes = episodeNames.filter { episode in
            return episode.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }
    
}

extension VideoTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
