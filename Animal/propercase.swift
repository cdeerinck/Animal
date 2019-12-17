//
//  propercase.swift
//  Animal
//
//  Created by Chuck Deerinck on 12/14/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

func propercase(_ thing: String) -> String {
    return thing.prefix(1).uppercased() + thing.dropFirst(1).lowercased()
}
