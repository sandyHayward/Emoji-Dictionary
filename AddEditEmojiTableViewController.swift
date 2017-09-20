//
//  AddEditEmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by anthony on 7/5/17.
//  Copyright © 2017 Casandra Hayward. All rights reserved.
//

import UIKit

class AddEditEmojiTableViewController: UITableViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var usageTextField: UITextField!
    
    @IBOutlet weak var sectionHeaderLabel: UILabel!
    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var emoji: Emoji?
    var emojiSection: String?

    override func viewDidLoad() {
        super.viewDidLoad()
      
            
        
        if let emoji = emoji {
            title = "Edit Emoji"
            symbolTextField.text = emoji.symbol
            nameTextField.text = emoji.name
            descriptionTextField.text = emoji.detailDescription
            usageTextField.text = emoji.usage
        
      //      emojiSectionPickerView. = emojiSection
        sectionHeaderLabel.text = emojiSection
    }
        
        updateSaveButtonState()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateSaveButtonState() {
        let sectionText = sectionHeaderLabel.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let usageText = usageTextField.text ?? ""
        let symbolText = symbolTextField.text ?? ""
        saveButton.isEnabled = !sectionText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty && !usageText.isEmpty && !symbolText.isEmpty
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for:segue, sender: sender)
        guard segue.identifier == "saveUnwind" else {return}
        let symbol = symbolTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        let usage = usageTextField.text ?? ""
        
            emoji = Emoji(symbol: symbol, name: name , detailDescription: description, usage: usage )
         emojiSection = "New Emoji Added"
        
        
    }
    
    
}
