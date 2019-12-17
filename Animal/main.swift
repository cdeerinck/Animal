//
//  main.swift
//  Animal
//
//  Created by Chuck Deerinck on 12/14/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation

func main() {

    let root = load()
    let initialAnimalCount = root.count
    
    while true {
        print("Welcome to the game of Animal.  Please think of an animal.")
        root.ask()
        print("Would you like to play again ? ", terminator:"")
        if !gotYesAnswer() {
            let learnedAnimalCount = root.count - initialAnimalCount
            if learnedAnimalCount > 0 {
                print("Should I remember the \(learnedAnimalCount) \(learnedAnimalCount>1 ? "animals" : "animal") that I learned ? ", terminator:"")
                if gotYesAnswer() {
                    save(root)
                }
            }
            return
        }
        print()
    }
}

main()
