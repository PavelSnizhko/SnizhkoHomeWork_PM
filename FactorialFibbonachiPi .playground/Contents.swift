import Foundation
import SwiftUI
import PlaygroundSupport

enum ComputingValuesResult: Error {
    case InnapropriateNegattiveValue(String)
    case TooBigNumberForCalculation(String)
    case AllowedOnlyInteger(String)
    case Succes(Int)
}

enum TypeOfOperation{
    case factorial
    case fibbonachi
    case digitOfPi
}



struct Services{
    
    static func getWithRecurionFactorial(number: Int) -> Int {
        guard number > 0 else { return 1 }
        return number * getWithRecurionFactorial(number:(number - 1))
    }
    
    static func getdWithIterationFactorial(number: Int) -> Int{
        guard number != 0 else {return 1}
        var result = 1
        for currentValue in 1...number{
            result *= currentValue
        }

        return result
    }
    
    static func getFibbonachiSequence(lengthOfSequence: Int) -> [Int]{
        
        if lengthOfSequence == 0{
            return [0]
        }
        else if lengthOfSequence == 1 {
            return [0, 1]
        }
        var sequance = [0, 1]
        while sequance.count < lengthOfSequence {
            sequance.append(sequance[sequance.count - 1] + sequance[sequance.count - 2])
        }
        print(sequance)
        return sequance
    }
    
    static func checkNumberForFactorial<T: Comparable>(number: T) -> ComputingValuesResult{
        guard T.self == Int.self else { return .AllowedOnlyInteger("There are not alowed to use not integer values")}
        guard number >= 0 as! T  else { return .InnapropriateNegattiveValue("There are not alowed to use negative values")}
        guard number < 20 as! T else { return .TooBigNumberForCalculation("Can't calculate value bigger than 20")}
        return .Succes(number as! Int)
    }
    
    static func checkNumberForFibbonachi<T: Comparable>(number: T) -> ComputingValuesResult{
        guard T.self == Int.self else { return .AllowedOnlyInteger("There are not alowed to use not integer values")}
        guard number >= 0 as! T  else { return .InnapropriateNegattiveValue("There are not alowed to use negative values")}
        guard number < 92 as! T else { return .TooBigNumberForCalculation("Can't make sequance huge number")}
        return .Succes(number as! Int)
    }
    
    static func checkNumberForPi<T: Comparable>(number: T) -> ComputingValuesResult{
        guard T.self == Int.self else { return .AllowedOnlyInteger("There are not alowed to use not integer values")}
        guard number >= 0 as! T  else { return .InnapropriateNegattiveValue("There are not alowed to use negative values")}
        guard number < 14 as! T else { return .TooBigNumberForCalculation("Can't take the number after comma")}
        return .Succes(number as! Int)
    }
    
    
}

extension Double{
    func getNumberOfPi(number: Int) -> Int {
        return Int(Int(self * pow(10.0, Double(number))) % 10)
    }
}


func getResult(value: Int, recursionFlag: Bool = false, type: TypeOfOperation ) -> Text{
    switch Services.checkNumberForFactorial(number: value) {
    case .InnapropriateNegattiveValue(let text):
        return Text(text)
    case .TooBigNumberForCalculation(let text):
        return Text(text)
    case .AllowedOnlyInteger(let text):
        return Text(text)
    case .Succes(let value):
        switch type {
        case .factorial:
            if recursionFlag{
                return Text("The result by the recursive method  \(Services.getWithRecurionFactorial(number: value))")
            }
            else{
                return Text("The result by the iterative method:  \(Services.getWithRecurionFactorial(number: value))")
            }
        case .fibbonachi:
            return Text("Fibbonachi sequence  \(Services.getFibbonachiSequence(lengthOfSequence: value).description)")
        case .digitOfPi:
            return Text("N digit of Pi number fraction is  \(Double.pi.getNumberOfPi(number: value))")
        }
    }
}




struct FactorialView: View {
    @State var factorialNumber: Int?
    @State var recursionFlag = false

       var body: some View {
           VStack(alignment: .leading) {
                Text("Please enter your number to calculate a factorial")
                Divider();
                TextField("Enter number...", value: $factorialNumber, formatter: NumberFormatter()
                ).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.numberPad)
                // TODO: find solution to prevent type double keyboardType is not good
                Toggle(isOn: $recursionFlag) {
                    Text("Recurtion")
                }
                if factorialNumber != nil{
                    Group {
                        getResult(value: factorialNumber!, recursionFlag: recursionFlag ,type: TypeOfOperation.factorial)
                    }
                }
                else{
                    Text("Waiting for calculation").padding(10).border(Color.green)
                }
           }.padding()
    }
}


struct FibbonachiSequence: View{
    @State var lenOfFibbonachi: Int?
    
    var body: some View {
        VStack(alignment: .leading) {
            Divider();
            Text("Please enter the length of the Fibbonachi sequence")
            Divider();
            TextField("Enter number...", value: $lenOfFibbonachi, formatter: NumberFormatter()).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.numberPad)
           
            if lenOfFibbonachi != nil{
                Group {
                    getResult(value: lenOfFibbonachi!, type: TypeOfOperation.fibbonachi)
                }
            }
            else{
                Text("Waiting for calculation").padding(10).border(Color.green)
            }
        }
    
    }
    
}



struct PiView: View{
    
    
    @State var numberOfPi: Int?
    
    var body: some View {
        VStack(alignment: .leading) {
            Divider();
            Text("Please enter the Nth digit of Pi number fraction")
            Divider();
            TextField("Enter number...", value: $numberOfPi, formatter: NumberFormatter()).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.numberPad)
            if numberOfPi != nil{
                Group {
                    getResult(value: numberOfPi!, type: TypeOfOperation.digitOfPi)
                }
            }
            else{
                Text("Waiting for calculation").padding(10).border(Color.green)
            }
        }
    
    }
    
}

PlaygroundPage.current.setLiveView(FactorialView())
PlaygroundPage.current.setLiveView(FibbonachiSequence())
PlaygroundPage.current.setLiveView(PiView())





