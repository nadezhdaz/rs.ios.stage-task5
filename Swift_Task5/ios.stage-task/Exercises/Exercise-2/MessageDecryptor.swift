import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        if (message.count == 0 || message.count > 60) {
            return ""
        }
        
        let string = message
        var result = ""
        var bracesCount = 0
        var index = 0
        var numbers = [Int](repeating: 1, count: string.count)
        var words = [String](repeating: "", count: string.count)
        
        let chars = Array(string)
        
        
        for i in 0..<chars.count {
            
            if chars[i] == "[" {
                bracesCount += 1
                
            } else if chars[i] == "]" {
                bracesCount = bracesCount - 1
                index += 1 //working
            } else if var number = chars[i].wholeNumberValue {
                //if bracesCount == 0 {
                    index += 1 //working
                //}
                if i < chars.count - 2, let nextNumber = chars[i+1].wholeNumberValue {
                    number = number * 10 + nextNumber
                } else if i < chars.count - 3, let nextNumber = chars[i+1].wholeNumberValue, let thirdNumber = chars[i+2].wholeNumberValue {
                    number = number * 100 + nextNumber * 10 + thirdNumber
                }
                numbers[index] = number
            } else {
                words[index] += String(chars[i])
            }
        }
        
        for i in words.indices {
            let addingString = String(repeating: words[i], count: numbers[i])
            result += addingString
        }
        
        return result
    }
}
