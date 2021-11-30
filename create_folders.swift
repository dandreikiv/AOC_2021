#!/usr/bin/env swift
import Foundation

let fileManager = FileManager()
let currentDirectory = fileManager.currentDirectoryPath

for i in 1...25 {
    let name = "Day_\(i)"
    do {
        try fileManager.createDirectory(atPath: "\(currentDirectory)/\(name)/Part_1", withIntermediateDirectories: true)
        try fileManager.createDirectory(atPath: "\(currentDirectory)/\(name)/Part_2", withIntermediateDirectories: true)
    } catch {
        print("Coundn't create folder with name: \(name)")
    }
}   