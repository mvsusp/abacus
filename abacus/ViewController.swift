import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var one: NumberView!
    @IBOutlet weak var two: NumberView!
    @IBOutlet weak var three: NumberView!
    @IBOutlet weak var four: NumberView!
    @IBOutlet weak var five: NumberView!
    @IBOutlet weak var six: NumberView!
    @IBOutlet weak var seven: NumberView!
    @IBOutlet weak var eight: NumberView!
    @IBOutlet weak var nine: NumberView!
    @IBOutlet weak var ten: NumberView!
    
    @IBOutlet weak var currentNumberLabel: UILabel!
    
    @IBOutlet weak var zeroSpace: NSLayoutConstraint!
    @IBOutlet weak var oneSpace: NSLayoutConstraint!
    @IBOutlet weak var twoSpace: NSLayoutConstraint!
    @IBOutlet weak var threeSpace: NSLayoutConstraint!
    @IBOutlet weak var fourSpace: NSLayoutConstraint!
    @IBOutlet weak var fiveSpace: NSLayoutConstraint!
    @IBOutlet weak var sixSpace: NSLayoutConstraint!
    @IBOutlet weak var sevenSpace: NSLayoutConstraint!
    @IBOutlet weak var eightSpace: NSLayoutConstraint!
    @IBOutlet weak var nineSpace: NSLayoutConstraint!
    
    var delegate: MainViewController?
    
    var spaces: [NSLayoutConstraint] = []
    var originalSpacing: [CGFloat] = []
    var hiddenSpacing: [CGFloat] = []
    var numbers: [NumberView] = []
    var currentNumber = 0
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spaces = [zeroSpace, oneSpace,twoSpace,threeSpace,fourSpace,fiveSpace,sixSpace,sevenSpace,eightSpace,nineSpace]
        numbers = [one,two,three,four,five,six,seven,eight,nine,ten]
        
        originalSpacing = map(spaces, {(space:NSLayoutConstraint) in return space.constant})
        hiddenSpacing = map(spaces, {(space:NSLayoutConstraint) in return space.constant + self.view.bounds.width})
        //        eraseBoard()
    }
    
    @IBAction func viewTapped(sender: UITapGestureRecognizer) {
        setCurrentNumber(++currentNumber%10, alert: true)
        
    }
    
    @IBAction func rightSwiped(sender: UISwipeGestureRecognizer) {
        setCurrentNumber(--currentNumber%10, alert: true)
    }
    
    @IBAction func leftSwiped(sender: UISwipeGestureRecognizer) {
        setCurrentNumber(++currentNumber%10, alert: true)
    }
    
    
    func setCurrentNumber(value: Int, alert: Bool){
        if alert {
            delegate?.numberChanged()
        }
        currentNumberLabel.text = "\(value)"
        
        for index in 1...10 {
            if index <= value {
                showNumber(index)
            } else {
                hideNumber(index)
            }
        }
        
        currentNumber = value
    }
    
    func eraseBoard(){
        for index in 1...10 {
            hideNumber(index, animate: false)
        }
    }
    
    func animateLayout(){
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 1, options: nil, animations: {
            self.view.layoutSubviews()
            }, completion: nil)
    }
    
    func showNumber(value: Int){
        spaces[value-1].constant = self.originalSpacing[value-1] + 20
        if value == 1 {
            spaces[value-1].constant = self.originalSpacing[value-1]
        }
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 1, options: nil, animations: {
            self.view.layoutSubviews()
            }, completion: {
                (success)in
                if value != 1 {
                    UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: nil , animations: {
                        self.spaces[value-1].constant = self.originalSpacing[value-1]
                        self.view.layoutSubviews()
                        }, completion: nil)
                }
        })
    }
    
    func hideNumber(value: Int, animate: Bool = true){
        if value > 9 {
            return
        }
        if spaces[value-1].constant < self.view.bounds.width {
            let duration = animate ? 1.0 : 0
            
            UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 1, options: nil, animations: {
                self.spaces[value-1].constant = self.originalSpacing[value-1] + 20
                self.view.layoutSubviews()
                }, completion: {
                    (success)in
                    UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: nil , animations: {
                        self.spaces[value-1].constant = self.hiddenSpacing[value-1]
                        self.view.layoutSubviews()
                        }, completion: nil)
                    
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

