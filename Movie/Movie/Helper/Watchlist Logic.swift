//
//  Watchlist Logic.swift
//  Movies Fox
//
//  Created by Nirmal on 23/04/24.
//

import Foundation
// Function to add a MovieElement to the existing plist file
func addMovieElement(_ movie: MovieElement) {
    // Get the document directory URL
    if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        // Append the file name to the directory URL
        let plistURL = documentsDirectory.appendingPathComponent("movieElements.plist")
        
        // Check if the plist file exists
        if !FileManager.default.fileExists(atPath: plistURL.path) {
            // Create an empty array of MovieElement
            let initialMovieElements: [MovieElement] = []
            
            do {
                // Create a PropertyListEncoder
                let encoder = PropertyListEncoder()
                encoder.outputFormat = .xml // You can choose .binary or .xml
                
                // Encode the empty array and write it to the disk
                let initialData = try encoder.encode(initialMovieElements)
                try initialData.write(to: plistURL)
                print("Plist file created successfully.")
            } catch {
                print("Error creating plist file: \(error)")
                return
            }
        }
        
        do {
            // Read the existing data from the plist file
            let existingData = try Data(contentsOf: plistURL)
            
            // Decode the existing data into an array of MovieElement
            var movieElements = try PropertyListDecoder().decode([MovieElement].self, from: existingData)
            
            // Append the new movie to the array
            movieElements.append(movie)
            
            // Create a PropertyListEncoder
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml // You can choose .binary or .xml
            
            // Encode the updated array and write it to the disk
            let newData = try encoder.encode(movieElements)
            try newData.write(to: plistURL)
            print("MovieElement added successfully.")
        } catch {
            print("Error adding MovieElement: \(error)")
        }
    } else {
        print("Could not get documents directory.")
    }
}


// Function to remove a MovieElement from the existing plist file
func removeMovieElement(withTitle title: String) {
    // Get the document directory URL
    if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        // Append the file name to the directory URL
        let plistURL = documentsDirectory.appendingPathComponent("movieElements.plist")
        
        // Check if the plist file exists
        if FileManager.default.fileExists(atPath: plistURL.path) {
            do {
                // Read the existing data from the plist file
                let existingData = try Data(contentsOf: plistURL)
                
                // Decode the existing data into an array of MovieElement
                var movieElements = try PropertyListDecoder().decode([MovieElement].self, from: existingData)
                
                // Remove the movie with the specified title from the array
                movieElements.removeAll { $0.title == title }
                
                // Create a PropertyListEncoder
                let encoder = PropertyListEncoder()
                encoder.outputFormat = .xml // You can choose .binary or .xml
                
                // Encode the updated array and write it to the disk
                let newData = try encoder.encode(movieElements)
                try newData.write(to: plistURL)
                print("MovieElement with title '\(title)' removed successfully.")
            } catch {
                print("Error removing MovieElement: \(error)")
            }
        } else {
            print("Plist file does not exist.")
        }
    } else {
        print("Could not get documents directory.")
    }
}

// Function to read MovieElements from the plist file
func readMovieElements() -> [MovieElement]? {
    // Get the document directory URL
    if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        // Append the file name to the directory URL
        let plistURL = documentsDirectory.appendingPathComponent("movieElements.plist")
        
        // Check if the plist file exists
        if FileManager.default.fileExists(atPath: plistURL.path) {
            do {
                // Read the existing data from the plist file
                let existingData = try Data(contentsOf: plistURL)
                
                // Decode the existing data into an array of MovieElement and return it
                let movieElements = try PropertyListDecoder().decode([MovieElement].self, from: existingData)
                return movieElements
            } catch {
                print("Error reading MovieElements: \(error)")
                return nil
            }
        } else {
            print("Plist file does not exist.")
            return nil
        }
    } else {
        print("Could not get documents directory.")
        return nil
    }
}
func readMovieElements(byTitle : String) -> Bool? {
    // Get the document directory URL
    if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        // Append the file name to the directory URL
        let plistURL = documentsDirectory.appendingPathComponent("movieElements.plist")
        
        // Check if the plist file exists
        if FileManager.default.fileExists(atPath: plistURL.path) {
            do {
                // Read the existing data from the plist file
                let existingData = try Data(contentsOf: plistURL)
                
                // Decode the existing data into an array of MovieElement and return it
                let movieElements = try PropertyListDecoder().decode([MovieElement].self, from: existingData)
                return movieElements.contains { movies in
                    movies.title == byTitle
                }
            } catch {
                print("Error reading MovieElements: \(error)")
                return nil
            }
        } else {
            print("Plist file does not exist.")
            return nil
        }
    } else {
        print("Could not get documents directory.")
        return nil
    }
}

