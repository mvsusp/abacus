import UIKit

class MainViewController: UIViewController {
    
    var digits: [ViewController?] = [nil,nil,nil,nil,nil,nil,nil]
    var expression : Expression = Digit(number: 0)
    
    
    @IBOutlet weak var inputField: UILabel!
    
    @IBOutlet weak var calcViewTopSpace: NSLayoutConstraint!
    
    var isLidClose = true
    
    @IBOutlet weak var operationLabel: UILabel!
    
    
    @IBAction func digitsTapped(sender: UITapGestureRecognizer) {
        if isLidClose {
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 2, options: nil, animations: {
                self.calcViewTopSpace.constant = self.calcViewTopSpace.constant - self.view.bounds.height + self.inputField.bounds.height
                self.view.layoutSubviews()
                }, completion: nil)
        } else {
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 2, options: nil, animations: {
                self.calcViewTopSpace.constant = self.calcViewTopSpace.constant + self.view.bounds.height - self.inputField.bounds.height
                self.view.layoutSubviews()
                }, completion: nil)
        }
        isLidClose = !isLidClose
    }
    
    @IBAction func digitTapped(sender: UIButton) {
        var newDigit = Digit(string: sender.titleLabel!.text!)
        
        expression = expression.addDigit(newDigit)
        inputField.text = expression.display()
        
        setValue(expression.currentNumber)
    }
    
    @IBAction func abacusTapped(sender: UIButton) {
        operationLabel.text = "="
        expression = expression.addEqualsSign()
        inputField.text = expression.display()
        isLidClose = !isLidClose
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 2, options: nil, animations: {
            self.calcViewTopSpace.constant = self.calcViewTopSpace.constant + self.view.bounds.height - self.inputField.bounds.height
            self.view.layoutSubviews()
            }, completion: {(success: Bool) in
                dispatch_async(dispatch_get_main_queue(),{
                    self.setValue(NSString(string: self.inputField.text! ).doubleValue)
                    
                    self.view.layoutSubviews()
                })
                
                
        })
    }
    
    @IBAction func clearTapped(sender: UIButton) {
        expression = Digit(number: 0)
        operationLabel.text = ""
        
        inputField.text = expression.display()
        setValue(expression.currentNumber)
    }
    
    @IBAction func equalsTapped(sender: UIButton) {
        operationLabel.text = "="
        expression = expression.addEqualsSign()
        inputField.text = expression.display()
        setValue(expression.currentNumber)
    }
    
    @IBAction func plusTapped(sender: UIButton) {
        operationLabel.text = "+"
        expression = expression.addSign(PlusSign())
        inputField.text = expression.display()
        setValue(expression.currentNumber)
    }
    
    @IBAction func minusTapped(sender: UIButton) {
        operationLabel.text = "-"
        expression = expression.addSign(MinusSign())
        inputField.text = expression.display()
        setValue(expression.currentNumber)
    }
    
    @IBAction func timesTapped(sender: UIButton) {
        operationLabel.text = "*"
        expression = expression.addSign(TimesSign())
        inputField.text = expression.display()
        setValue(expression.currentNumber)
    }
    
    @IBAction func divideTapped(sender: UIButton) {
        operationLabel.text = "/"
        expression = expression.addSign(DivideSign())
        inputField.text = expression.display()
        setValue(expression.currentNumber)
    }
    
    @IBAction func dotTapped(sender: UIButton) {
        expression = expression.addDot()
    }
    
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
        controller.delegate = self
    }
    
    func numberChanged(){
        let count = digits.count
        
        var mod = 1
        var text: Double = 0
        for i in 1...count {
            text += Double(mod) * Double(digits[i-1]!.currentNumber%10)
            mod *= 10
        }
        let result = text / 100
        inputField.text = "\(result)"
        expression = Digit(number: result)
    }
    
    func setValue(value: Double) {
        let count = digits.count
        var currentValue = Int(value * 100)
        var mod = 10
        for i in 0..<count {
            let digit = currentValue % mod
            digits[i]?.setCurrentNumber(digit, alert: false)
            currentValue = currentValue / 10
        }
        
    }
    
}
