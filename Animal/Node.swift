//
//  Node.swift
//  Animal
//
//  Created by Chuck Deerinck on 12/14/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

class Node: Codable {

    private enum NodeType: String, Codable {
        case question//(question: String, yesNode:Node, noNode: Node)
        case answer//(answer: String)
    }

    private var nodeType:NodeType
    private var str:String
    private var yesNode:Node?
    private var noNode:Node?

    var count:Int {
        get {
            switch self.nodeType {
            case .answer:
                return 1
            case .question:
                return self.yesNode!.count + self.noNode!.count
            }
        }
    }

    init(answer theAnswer:String) {
        self.nodeType = .answer
        self.str = theAnswer
    }

    init(question theQuestion:String, yesAnswer:String, noAnswer:String) {
        self.nodeType = .question
        self.str = theQuestion
        self.yesNode = Node(answer: yesAnswer)
        self.noNode = Node(answer: noAnswer)
    }

    func ask() {
        switch self.nodeType {
            case .question:
                print("\(self.str) ? ", terminator:"")
                if gotYesAnswer() {
                    self.yesNode?.ask()
                } else {
                    self.noNode?.ask()
                }
            case .answer:
                print("Is it \(assignPrefix(self.str)) ? ", terminator:"")
                if gotYesAnswer() {
                    print("I win!")
                } else {
                    addBranch(missedGuess:self.str)
                }
        }
    }

    func addBranch(missedGuess: String) {
        print("What was your animal ? ", terminator:"")
        var animal = ""
        while animal.count < 2 {
            animal = propercase(readLine() ?? "").capitalized
        }
        print("Please type a question that would distinguish between \(assignPrefix(animal)) and \(assignPrefix(missedGuess)) : ", terminator:"")
        let question = getFixedQuestion()
        print("And for \(assignPrefix(animal)) the answer would be : ", terminator:"")
        if gotYesAnswer() {
            self.nodeType = .question
            self.str = question
            self.yesNode = Node(answer: animal)
            self.noNode = Node(answer: missedGuess)
        } else {
            self.nodeType = .question
            self.str = question
            self.yesNode = Node(answer: missedGuess)
            self.noNode = Node(answer: animal)
        }
        print("I have learned.")
    }
}
