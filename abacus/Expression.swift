import Foundation

public protocol Expression {
    func addDigit(operation: Digit) -> Expression
    func addSign(operation: Sign) -> Expression
    func display() -> String
    func addEqualsSign() -> Expression
    func addDot() -> Expression
    var currentNumber: Double { get }
}

public class Digit : NSObject, Expression {
    
    public var currentNumber: Double
    
    public init(string: String){
        self.currentNumber = Double(string.toInt()!)
    }
    
    public init(number: Double){
        self.currentNumber = number
    }
    
    public func display() -> String {
        if currentNumber % 1 > 0 {
            return "\(currentNumber)"
        }
        
        return "\(Int(currentNumber))"
    }
    
    public func addDigit(operation: Digit) -> Expression {
        let concatenation: Double = currentNumber * 10 + operation.currentNumber
        
        currentNumber = concatenation
        return self
    }
    
    public func addDot() -> Expression {
        return Dot(integer: Int(currentNumber))
    }
    
    public func addSign(operation: Sign) -> Expression {
        operation.firstElement = self.currentNumber
        return operation
    }
    
    public func addEqualsSign() -> Expression {
        return EqualsSign(firstElement: currentNumber)
    }
}

public class Dot : NSObject, Expression {
    var integer = 0
    var fraction = 0
    
    public var currentNumber: Double {
        get {
            var stringValue = "\(integer)"
            stringValue.extend(".")
            stringValue.extend("\(fraction)")
            return NSString(string: stringValue).doubleValue
        }
    }
    
    public func addEqualsSign() -> Expression {
        return EqualsSign(firstElement: currentNumber)
    }
    
    public func display() -> String {
        var stringValue = "\(integer)"
        stringValue.extend(".")
        stringValue.extend("\(fraction)")
        
        return stringValue
    }
    
    init(integer: Int){
        self.integer = integer
    }
    
    public func addDigit(operation: Digit) -> Expression {
        let concatenation = fraction * 10 + Int(operation.currentNumber)
        fraction = concatenation
        
        return self
    }
    
    public func addDot() -> Expression {
        return self
    }
    
    public func addSign(operation: Sign) -> Expression {
        operation.firstElement = self.currentNumber
        return operation
    }
}

public class Sign : NSObject, Expression {
    var firstElement: Double
    var secondElement: Expression?
    var calculationFunc: (firstElement: Double, secondElement: Double) -> Double
    
    public init(firstElement: Double, calculationFunc: (firstElement: Double, secondElement: Double) -> Double){
        self.firstElement = firstElement
        self.calculationFunc = calculationFunc
    }
    
    public init(calculationFunc: (firstElement: Double, secondElement: Double) -> Double) {
        self.calculationFunc = calculationFunc
        self.firstElement = 0
    }
    
    public var currentNumber: Double {
        get {
            if secondElement == nil {
                return firstElement
            } else {
                return secondElement!.currentNumber
            }
        }
    }
    
    public func display() -> String {
        if currentNumber % 1 > 0 {
            return "\(currentNumber)"
        }
        
        return "\(Int(currentNumber))"
    }
    
    public func addDigit(digit: Digit) -> Expression {
        if secondElement == nil {
            secondElement = digit
        } else {
            secondElement = secondElement!.addDigit(digit)
        }
        return self
    }
    
    public func addDot() -> Expression {
        if secondElement == nil {
            secondElement = Dot(integer: 0)
        } else {
            secondElement = secondElement!.addDot()
        }
        return self
    }
    
    public func addSign(newSign: Sign) -> Expression {
        if secondElement == nil {
            newSign.firstElement = firstElement
            return newSign
        }
        
        let result = calculationFunc(firstElement: firstElement, secondElement: secondElement!.currentNumber)
        
        newSign.firstElement = result
        return newSign
    }
    
    public func addEqualsSign() -> Expression {
        if secondElement == nil {
            return  EqualsSign(firstElement: firstElement, expression: self)
        } else {
            let result = calculationFunc(firstElement: firstElement, secondElement: secondElement!.currentNumber)
            return  EqualsSign(firstElement: result, expression: self)
        }
    }
}

public class EqualsSign : Expression {
    var firstElement: Double
    var expression: Expression?
    
    public init(firstElement: Double) {
        self.firstElement = firstElement
    }
    
    public init(firstElement: Double, expression: Expression) {
        self.firstElement = firstElement
        self.expression = expression
    }
    
    public func addDigit(operation: Digit) -> Expression {
        return operation
    }
    
    public func addDot() -> Expression {
        return Dot(integer: 0)
    }
    
    public func display() -> String {
        if currentNumber % 1 > 0 {
            return "\(firstElement)"
        }
        
        return "\(Int(firstElement))"
    }
    
    public var currentNumber: Double {
        get { return firstElement }
    }
    
    public func addSign(operation: Sign) -> Expression {
        operation.firstElement = firstElement
        return operation
    }
    
    public func addEqualsSign() -> Expression {
        return self
    }
}

public class PlusSign : Sign {
    public init(){
        let calculationFunc = {(firstElement: Double, secondElement: Double) in firstElement + secondElement}
        super.init(calculationFunc: calculationFunc)
    }
}

public class MinusSign : Sign {
    public init(){
        let calculationFunc = {(firstElement: Double, secondElement: Double) in firstElement - secondElement}
        super.init(calculationFunc: calculationFunc)
    }
}

public class TimesSign : Sign {
    public init(){
        let calculationFunc = {(firstElement: Double, secondElement: Double) in firstElement * secondElement}
        super.init(calculationFunc: calculationFunc)
    }
}

public class DivideSign : Sign {
    public init(){
        let calculationFunc = {(firstElement: Double, secondElement: Double) in firstElement / secondElement}
        super.init(calculationFunc: calculationFunc)
    }
}