//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by anthony on 6/16/17.
//  Copyright © 2017 Casandra Hayward. All rights reserved.
//

import Foundation
class Emoji:NSObject, NSCoding{
    
    var symbol: String
    var name: String
    var detailDescription: String
    var usage: String
    static var archiveURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentDirectory.appendingPathComponent("emojis")
        return archiveURL
    }
    
    init(symbol: String, name: String, detailDescription: String, usage: String) {
        self.symbol = symbol
        self.name = name
        self.detailDescription = detailDescription
        self.usage = usage
    
    }
    struct PropertyKeys {
        static let symbol = "symbol"
        static let name = "name"
        static let detailDescription = "detailDescription"
        static let usage = "usage"
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(symbol, forKey: PropertyKeys.symbol)
        aCoder.encode(name, forKey: PropertyKeys.name)
        aCoder.encode(detailDescription, forKey: PropertyKeys.detailDescription)
        aCoder.encode(usage, forKey: PropertyKeys.usage)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let symbol = aDecoder.decodeObject(forKey: PropertyKeys.symbol) as! String
        let name = aDecoder.decodeObject(forKey: PropertyKeys.name) as! String
        let detailDescription = aDecoder.decodeObject(forKey: PropertyKeys.detailDescription) as! String
        let usage = aDecoder.decodeObject(forKey: PropertyKeys.usage) as! String
        self.init(symbol: symbol, name: name, detailDescription: detailDescription, usage: usage)
        
     
        
    }
    
    static func saveToFile(emojis: [[Emoji]]) {
        let archivedNote = NSKeyedArchiver.archiveRootObject(emojis, toFile: Emoji.archiveURL.path)
    }
    
    static func loadFromFile() -> [[Emoji]] {
        let unarchivedNote = NSKeyedUnarchiver.unarchiveObject(withFile: Emoji.archiveURL.path) as? [[Emoji]]
        return unarchivedNote!
    }
    
    
    static func loadSampleEmojis() -> [[Emoji]] {
        let emojisSample: [[Emoji]] =
        [
        [Emoji(symbol: "😀", name: "Grinning Face", detailDescription: "A typical smiley face.", usage: "happiness"),
        Emoji(symbol: "😕", name: "Confused Face", detailDescription: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
        Emoji(symbol: "😍", name: "Heart Eyes", detailDescription: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
        Emoji(symbol: "👮", name: "Police Officer", detailDescription: "A police officer wearing a blue cap with a gold badge.", usage: "person of authority")],
        
        
        [Emoji(symbol: "🐢", name: "Turtle", detailDescription: "A cute turtle.", usage: "Something slow"),
        Emoji(symbol: "🐘", name: "Elephant",detailDescription: "A gray elephant.", usage: "good memory")],
        
        
        
        
        [Emoji(symbol: "🍝", name: "Spaghetti", detailDescription: "A plate of spaghetti.", usage: "spaghetti")],
        
        [Emoji(symbol: "🎲", name: "Die", detailDescription: "A single die.", usage: "taking a risk, chance; game")],
        
        [Emoji(symbol: "⛺️", name: "Tent", detailDescription: "A small tent.", usage: "camping")],
        
        [Emoji(symbol: "📚", name: "Stack of Books", detailDescription: "Three colored books stacked on each other.", usage: "homework, studying")],
        
        [Emoji(symbol: "💔", name: "Broken Heart", detailDescription: "A red, broken heart.", usage: "extreme sadness"),
        Emoji(symbol: "💤", name: "Snore", detailDescription: "Three blue \'z\'s.", usage: "tired, sleepiness")],
        
        [Emoji(symbol: "🏁", name: "Checkered Flag", detailDescription: "A black-and-white checkered flag.", usage: "completion")]
        
        ]
        
        return emojisSample

    }
}
