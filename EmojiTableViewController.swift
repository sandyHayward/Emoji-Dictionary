//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by anthony on 7/5/17.
//  Copyright © 2017 Casandra Hayward. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    
    var emojiHeaderSections = ["Smiley & People", "Animals & Nature", "Food & Drink", "Activity", "Travel & Places", "Objects", "Symbols", "Flags"]
    
    
    var emojis:[[Emoji]] = []
            
            
            
            
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        
    emojis = Emoji.loadFromFile()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return emojis.count
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return emojis[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell
        let emoji = emojis[indexPath.section][indexPath.row]
        cell.update(with: emoji)
        print(cell.nameLabel)
        print(cell.descriptionLabel)
        
        //update cell in EmojiTableViewCell file
        //cell.textLabel?.text = "\(emoji.symbol) -- \(emoji.name)"
        //cell.detailTextLabel?.text = emoji.description
        
        
        
        
        
        
        
        cell.showsReorderControl = true
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return emojiHeaderSections [section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView (_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath)
    {
        
        
        
        let movedEmoji = emojis[fromIndexPath.section].remove(at: fromIndexPath.row)
        
        emojis[to.section].insert(movedEmoji, at: to.row)
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle(rawValue: 1)!
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojis[indexPath.section].remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if segue.identifier == "EditEmoji" {
            
            let section = tableView.indexPathForSelectedRow!.section
            guard let sectionNumber = Int(section.description) else {return}
            let emojiSection =  emojiHeaderSections[sectionNumber]
            
            print(emojiSection)
            
            let row = tableView.indexPathForSelectedRow!.row
            let emoji =  emojis[section][row]
            let addEditEmojiTableViewController = segue.destination as? AddEditEmojiTableViewController
            addEditEmojiTableViewController?.emoji = emoji
            addEditEmojiTableViewController?.emojiSection = emojiSection
            
            
            
        }else if segue.identifier == "AddEmoji" {
            let navigationController = segue.destination as? UINavigationController
            let addEditEmojiTableViewController = navigationController?.topViewController as? AddEditEmojiTableViewController
            addEditEmojiTableViewController?.navigationItem.title = "Add Emoji"
            
        }
        
    }
    
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        
        guard segue.identifier == "saveUnwind" else {return}
        let sourceViewController = segue.source as! AddEditEmojiTableViewController
        if let emoji = sourceViewController.emoji {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                emojis[selectedIndexPath.section][selectedIndexPath.row] = emoji
                
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                Emoji.saveToFile(emojis: emojis)
                
            }else {
                
                let newIndexPath = IndexPath(row: emojis[0].count, section: 0)
                emojis[0].append(emoji)
                
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                Emoji.saveToFile(emojis: emojis)
            }
            
        }
      
    }
    
    @IBAction func refreshControlActivated(_ sender: UIRefreshControl){
        tableView.reloadData()
        sender.endRefreshing()
    }
    
    
    
}
