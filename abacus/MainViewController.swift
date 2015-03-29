import UIKit

class MainViewController: UIViewController {
  
  var digits: [ViewController?] = [nil,nil,nil,nil,nil,nil,nil]
  
  @IBOutlet weak var inputField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let controller = segue.destinationViewController as ViewController
    let index = segue.identifier!.toInt()!
    digits[index] = controller
  }
  
  
  @IBAction func setValue(sender: UIButton) {
    var value = Int(NSString(string: inputField.text!).doubleValue * 100)
    let count = digits.count
    var mod = 10
    for i in 0..<count {
      let digit = value % mod
      digits[i]?.setCurrentNumber(digit)
      value = value / 10
    }
    
  }
  
}
