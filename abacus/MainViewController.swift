import UIKit

class MainViewController: UIViewController {
  
  var digits: [ViewController?] = [nil,nil,nil,nil,nil,nil,nil]
  
  @IBOutlet weak var inputField: UITextField!
  
  @IBOutlet weak var calcViewTopSpace: NSLayoutConstraint!
  
  var openCalcViewSpaceValue: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    inputField.text = "0"
    calcViewTopSpace.constant = calcViewTopSpace.constant + self.view.bounds.height - inputField.bounds.height
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
