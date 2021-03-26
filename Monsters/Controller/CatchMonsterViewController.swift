import UIKit
import RealityKit
import ARKit

class CatchMonsterViewController: UIViewController {

    @IBOutlet weak var arView: ARSCNView!
    @IBOutlet weak var catchButton: CatchButton!
    @IBOutlet weak var monsterInfoLabel: UILabel!
    
    var monster: Monster!
    
    private var monsters = Monsters()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        arView.session.run(configuration)
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arView.session.pause()
    }
    
    @IBAction func catchIfPossible() {
        catchMonster()
    }
    
    private func catchMonster() {
        if Probability.twentyPercent {
            monsters.add(monster)
            Alert.successIn(self, name: monster.name) { [unowned self] in done() }
        } else {
            giveMonsterChanceToEscape()
        }
    }
    
    private func giveMonsterChanceToEscape() {
        if Probability.thirtyPercent {
            Alert.failureIn(self) { [unowned self] in done() }
        } else {
            Alert.recatch(self) { [unowned self] in catchMonster() }
        }
    }
    
    private func done() {
        dismiss(animated: true)
    }
    
    private func setup() {
        if let image = UIImage(named: "\(monster.name)")?.scaled {
            let node = SCNNode(geometry: SCNPlane(width: 0.05, height: 0.05))
            node.geometry?.firstMaterial?.diffuse.contents = image
            arView.scene.rootNode.addChildNode(node)
        }
        monsterInfoLabel.text = "\(monster.name)\nУровень: \(monster.level)"
    }
    
    
}
