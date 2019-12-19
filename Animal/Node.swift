//
//  Node.swift
//  Animal
//
//  Created by Chuck Deerinck on 12/14/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

class Node: Codable {

    private enum NodeType: String, Codable {
        case question
        case answer
    }

    private var nodeType:NodeType
    private var str:String
    private var yesNode:Node?
    private var noNode:Node?
    private var yesIsNewer:Bool?

    var animalCount:Int {
        get {
            switch self.nodeType {
            case .answer:
                return 1
            case .question:
                return self.yesNode!.animalCount + self.noNode!.animalCount
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
                if gotYesAnswer(node:self) {
                    if self.yesNode == nil { return } //This can only happen on a Kill command.
                    self.yesNode?.ask()
                } else {
                    self.noNode?.ask()
                }
            case .answer:
                print("Is it \(assignPrefix(self.str)) ? ", terminator:"")
                if gotYesAnswer() {
                    print("I win!")
                } else {
                    addBranch()
                }
        }
    }

    func addBranch() {
        print("What was your animal ? ", terminator:"")
        let animal = getFixedQuestion()
        print("Please type a question that would distinguish between \(assignPrefix(animal)) and \(assignPrefix(self.str)) : ", terminator:"")
        let question = getFixedQuestion()
        print("And for \(assignPrefix(animal)) the answer would be : ", terminator:"")
        self.yesIsNewer = gotYesAnswer()
        if self.yesIsNewer! {
            self.nodeType = .question
            self.yesNode = Node(answer: animal)
            self.noNode = Node(answer: self.str) //Do this before we step on the missed animal.
            self.str = question //Now we can step on the missed animal answer.
        } else {
            self.nodeType = .question
            self.yesNode = Node(answer: self.str) //Do this before we step on the missed animal.
            self.noNode = Node(answer: animal)
            self.str = question //Now we can step on the missed animal answer.
        }
        print("I have learned.")
    }

    func removeBranch() {
        if self.yesIsNewer == nil {
            print("You can't remove the root.")
            return
        }
        let nodeToMove = self.yesIsNewer! ? self.noNode! : self.yesNode!
        self.nodeType = nodeToMove.nodeType
        self.str = nodeToMove.str
        self.yesNode = nodeToMove.yesNode
        self.noNode = nodeToMove.noNode
        self.yesIsNewer = nodeToMove.yesIsNewer
    }

    func dump(_ indent:Int=0) {
        print(String(repeating: " ", count: indent), terminator:"")
        if let x = self.yesIsNewer {
            print(x ? "Y " : "N ", terminator:"")
        } else {
            print("  ", terminator:"")
        }
        print(self.str, self.animalCount)
        self.yesNode?.dump(indent+1)
        self.noNode?.dump(indent+1)
    }

    func flatten(list: inout [Node]) {
        list.append(self)
        self.yesNode?.flatten(list: &list)
        self.noNode?.flatten(list: &list)
    }

    func analyzeOne() -> Double {
        if let y = self.yesNode, let n = self.noNode {
            var ratio = Double(y.animalCount) / Double(n.animalCount)
            if ratio < 1 { ratio = 1/ratio }
            return ratio
        }
        return 0.0
    }

    func analyze() {
        var nodeList: [Node] = []
        self.flatten(list: &nodeList)
        var maxRatio = 0.0
        var maxNode = self
        for node in nodeList {
            let ratio = node.analyzeOne()
            if ratio > maxRatio {
                maxRatio = ratio
                maxNode = node
            }
        }
        print("The worst imbalance in the tree is :", maxRatio, "for the question", maxNode.str)
    }
}

