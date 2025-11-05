import Cocoa

// Stage 3: Custom Short Codes
// - Allow users to specify their own custom short codes.
// - Handle cases where the custom code is already taken.

let LETTERS = "abcdefghijklmnopqrstuvwxyz"
let NUMBERS = "0123456789"

struct URLShortener {
    var records = [String: String]()
    
    mutating func shorten(_ url: String, custom: String? = nil) -> String? {
        var shortened: String = ""
        if let custom = custom {
            shortened = custom
        } else {
            shortened = randomizer(url)
        }
            
        guard records[shortened] == nil else {
            if custom != nil {
                print("custom string exists, try again")
                return nil
            } else {
                return shorten(url)
            }
        }
        
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

let shortenedMaps = shortener.shorten("https://google.com/maps", custom: "goog101")
let shortenedCal = shortener.shorten("https://google.com/cal", custom: "goog101")
