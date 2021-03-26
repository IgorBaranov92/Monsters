import Foundation

struct Monsters: Codable {
    
    private(set) var myMonsters = [Monster]()
    
    static let names = ["Kano","Scorpion","Jade","Skarlet","Kabal","Frost","Geras"]
    
    var json: Data? { try? JSONEncoder().encode(self) }
    
    init?(json:Data) {
        if let validJSON = try? JSONDecoder().decode(Monsters.self, from: json) {
            self = validJSON
        }
    }
    
    init(){
        recreateMonsters()
    }
    
    var urlToSave: URL? {
        try? FileManager.default.url(for: .documentDirectory,
                                     in: .userDomainMask,
                                     appropriateFor: nil,
                                     create: true).appendingPathComponent("monsters")
    }
    
    mutating func add(_ monster:Monster) {
        myMonsters.append(monster)
        save()
    }
    
    mutating func deleteAt(_ index:Int) {
        myMonsters.remove(at: index)
        save()
    }
    
    private func save() {
        if let url = urlToSave,
           let json = json {
            try? json.write(to: url)
        }
    }
    
    private mutating func recreateMonsters() {
        if let url = urlToSave,
           let data = try? Data(contentsOf: url),
           let newValue = Monsters(json: data) {
            self = newValue
        }
    }
    
}
