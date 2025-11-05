import Cocoa

// Stage 1: Implement a URL shortener that can:
// - Generate a short code for a given long URL
// - Retrieve the original URL from a short code

let LETTERS = "abcdefghijklmnopqrstuvwxyz"
let NUMBERS = "0123456789"

struct URLShortener {
    var records = [String: String]()
    
    mutating func shorten(_ url: String) -> String {
        var shortened = randomizer(url)
        records[shortened] = url
        
        return shortened
    }
    
    func expand(_ shortened: String) -> String? {
        let unwrappedExpanded = records[shortened]
        
        guard let unwrappedExpanded = unwrappedExpanded else {
            return nil
        }
                 
        return unwrappedExpanded
    }
    
    private func randomizer(_ url: String) -> String {
        let letters = String((0..<3).map { input in
            guard let random = LETTERS.randomElement() else {
                abort()
            }
            
            return random
        })
        
        let numbers = String((0..<3).map { input in
            guard let random = NUMBERS.randomElement() else {
                abort()
            }
            
            return random
        })
        
        return letters + numbers
    }
}

var shortener = URLShortener(records: [:])

let shortenedMaps = shortener.shorten("https://google.com/maps")
print(shortenedMaps)
let shortenedCal = shortener.shorten("https://google.com/cal")
print(shortenedCal)
