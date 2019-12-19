//
//  save.swift
//  Animal
//
//  Created by Chuck Deerinck on 12/14/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation

func save(_ root:Node) {
    let filename = getDocumentsDirectory().appendingPathComponent("Animal.txt")
    do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(root)
        print("Saving knowledge of \(root.animalCount) animals.")
        do {
            try data.write(to: filename)
        } catch {
            print("Error writing file:", error)
        }
    } catch {
        print("Codable Encoding Error:", error)
    }

}
