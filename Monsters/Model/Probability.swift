import Foundation


class Probability {
    
    static var twentyPercent: Bool { (1...20).contains(random) }
    
    static var thirtyPercent: Bool { (1...30).contains(random) }
    
    static private var random: Int { .random(in: 1...100)}
    
}
