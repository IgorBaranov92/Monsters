import UIKit

class MyTeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private(set) var monsters = Monsters()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var label: UILabel! { didSet {
        label.isHidden = !monsters.myMonsters.isEmpty
    }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(goBack))
        screenEdgeRecognizer.edges = .left
        view.addGestureRecognizer(screenEdgeRecognizer)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monsters.myMonsters.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTeamCell", for: indexPath)
        if let myTeamCell = cell as? MyTeamTableViewCell {
            myTeamCell.monsterImageView.image = UIImage(named: "\(monsters.myMonsters[indexPath.row].name)")
            myTeamCell.nameLabel.text = monsters.myMonsters[indexPath.row].name
            myTeamCell.levelLabel.text = String(monsters.myMonsters[indexPath.row].level)
            return myTeamCell
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            monsters.deleteAt(indexPath.row)
            label.isHidden = !monsters.myMonsters.isEmpty
            tableView.reloadData()
        }
    }
    
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        goBack()
    }

    @objc
    private func goBack() {
        dismiss(animated: true)
    }
    
    
}
