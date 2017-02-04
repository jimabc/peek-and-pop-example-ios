//
//  Message.swift
//  PeekAndPopExample
//
//  Created by James Matteson on 1/21/17.
//  Copyright © 2017 James Matteson. All rights reserved.
//

import Foundation
import UIKit

struct Message {
    let emoji: String
    
    var name: String {
        return emoji.unicodeName().localizedCapitalized
    }
}
