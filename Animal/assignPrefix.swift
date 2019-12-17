//
//  assignPrefix.swift
//  Animal
//
//  Created by Chuck Deerinck on 12/14/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

func assignPrefix(_ thing:String) -> String {
    //Do not include U, as proper english would be "a unicorn".
    return "AEIO".contains(thing.prefix(1).capitalized) ? "an \(thing)" : "a \(thing)"
}
