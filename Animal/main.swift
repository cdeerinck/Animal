//
//  main.swift
//  Animal
//
//  Created by Chuck Deerinck on 12/14/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation

func main() {

    let root = load() //This loads the entire tree, and root is simply the top of the tree.
    let initialAnimalCount = root.animalCount
    root.analyze()
    
    while true {
        print("Welcome to the game of Animal.  Please think of an animal.")
        root.ask() //This begins a round of play, and continues recursively until it is done.
        print("Would you like to play again ? ", terminator:"")
        if !gotYesAnswer() {
            //The player said they did not want to continue
            let learnedAnimalCount = root.animalCount - initialAnimalCount
            if learnedAnimalCount != 0 {
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
