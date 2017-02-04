//
//  DataSource.swift
//  PeekAndPopExample
//
//  Created by James Matteson on 1/21/17.
//  Copyright © 2017 James Matteson. All rights reserved.
//

import Foundation

class DataSource {
    fileprivate let emojis: [String] = ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "☺️", "😊", "😇", "🙂", "🙃", "😉", "😌", "😍", "😘", "😗", "😙", "😚", "😋", "😜", "😝", "😛", "🤑", "🤗", "🤓", "😎", "🤡", "🤠", "😏", "😒", "😞", "😔", "😟", "😕", "🙁", "☹️", "😣", "😖", "😫", "😩", "😤", "😠", "😡", "😶", "😐", "😑", "😯", "😦", "😧", "😮", "😲", "😵", "😳", "😱", "😨", "😰", "😢", "😥", "🤤", "😭", "😓", "😪", "😴", "🙄", "🤔", "🤥", "😬", "🤐", "🤢", "🤧", "😷", "🤒", "🤕"]
    
    fileprivate(set) var messages = [Message]()
    
    var numberOfMessages: Int {
        return self.messages.count
    }
    
    init() {
        let shuffledEmojis = emojis.shuffled()
        
        for emoji in shuffledEmojis {
            let message = Message(emoji: emoji)
            messages.append(message)
        }
    }
}

fileprivate extension Array {
    func shuffled() -> [Element] {
        // Poor man's shuffle
        return sorted { _, _ in
            return arc4random() < arc4random()
        }
    }
}
