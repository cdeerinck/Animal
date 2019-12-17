//
//  GotYesAnswer.swift
//  Animal
//
//  Created by Chuck Deerinck on 12/14/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

func gotYesAnswer() -> Bool {
    while true {
        if let answer = readLine() {
            if answer.prefix(1).uppercased() == "Y" {
                return true
            }
            if answer.prefix(1).uppercased() == "N" {
                return false
            }
        }
        print("Please answer Yes or No : ", terminator:"")
    }
}
