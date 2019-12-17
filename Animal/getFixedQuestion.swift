//
//  getFixedQuestion.swift
//  Animal
//
//  Created by Chuck Deerinck on 12/14/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

func getFixedQuestion() -> String {
    while true {
        if var answer = readLine() {
            if answer.count > 3 {
                answer = propercase(answer)
                while "?. ".contains(answer.suffix(1)) {
                    answer = String(answer.dropLast())
                }
                return answer
            }
        }
    }
}
