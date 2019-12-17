//
//  load.swift
//  Animal
//
//  Created by Chuck Deerinck on 12/14/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation

func load() -> Node {
    let filename = getDocumentsDirectory().appendingPathComponent("Animal.txt")
    do {
        let json = try String(contentsOf: filename, encoding: .utf8).data(using: .utf8)!
        let jsonDecoder = JSONDecoder()
        let root = try jsonDecoder.decode(Node.self, from: json)
        print("I know of \(root.count) animals.")
        return root
    } catch {
        print("Defaults created.  Error reading file:", error)
        return Node(question: "Does it fly", yesAnswer: "Bluebird", noAnswer: "Dolphin")
    }

}
