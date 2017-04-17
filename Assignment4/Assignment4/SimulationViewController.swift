
import UIKit

class SimulationViewController: UIViewController, EngineDelegate {

  @IBOutlet weak var gridView: GridView!
  var engine: StandardEngine!

  @IBAction func nextStep(_ sender: Any) {
    gridView.gridDataSource = gridView.gridDataSource?.next()
    gridView.setNeedsDisplay()
  }

  func engineDidUpdate(withGrid: GridProtocol) {
    self.gridView.setNeedsDisplay()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    engine = StandardEngine(gridView.size, gridView.size)
    engine.delegate = self
    gridView.gridDataSource = engine.grid
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

