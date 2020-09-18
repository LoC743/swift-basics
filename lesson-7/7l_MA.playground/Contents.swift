import UIKit
import Darwin

/* ///////////////////////////////////////////////////////////////////
 /// 1. Придумать класс, методы которого могут завершаться неудачей ///
 /// и возвращать либо значение, либо ошибку Error?.                ///
 /// Реализовать их вызов и обработать результат метода             ///
 /// при помощи конструкции if let, или guard let.                  ///
 /////////////////////////////////////////////////////////////////// */

struct Baggage {
    let id: Int
    let name: String
    let description: String
    let space: Int
}

enum Transmission: String {
    case auto = "Автоматическая"
    case manual = "Механическая"
    case none = "Отсутствует"
}

enum EngineStatus: String {
    case running = "Запущен"
    case stopped = "Не запущен"
}

enum WindowsStauts: String {
    case open = "Открыты"
    case close = "Закрыты"
}

enum TrunkError: Error {
    case nothingToRemove // "Багажник пуст!"
    case baggageDoesNotExists(id: Int) // "В багажнике нет вещи с id: \(id)"
    case noSpace // "В багажнике нет места!"
}


class Car {
    var model: String
    var year: UInt16
    var trunkSpace: Int
    var usedTrunkSpace: Int
    
    var baggageArray: [Baggage]

    
    init?(model: String, year: UInt16, trunkSpace: Int, baggageArray: [Baggage]) {
        self.usedTrunkSpace = 0
        for baggage in baggageArray {
            self.usedTrunkSpace += baggage.space
        }
        
        guard usedTrunkSpace <= trunkSpace else {
            return nil
        }
        
        self.model = model
        self.year = year
        self.trunkSpace = trunkSpace
        self.baggageArray = baggageArray
    }
    
    private func increaseTrunkSpace(_ space: Int) -> Bool {
        var result = false
        if usedTrunkSpace + space <= trunkSpace {
            usedTrunkSpace += space
            result = true
        }
        
        return result
    }
    
    private func decreaseTrunkSpace(_ space: Int) -> Bool {
        var result = false
        if usedTrunkSpace - space >= 0 {
            usedTrunkSpace -= space
            result = true
        }
        
        return result
    }
    
    func addBaggage(_ baggage: Baggage) -> TrunkError? {
        guard increaseTrunkSpace(baggage.space) else { return .noSpace }
        
        baggageArray.append(baggage)
        
        return nil
    }
    
    func removeBaggageBy(id: Int) -> (Baggage?, TrunkError?) {
        guard baggageArray.count > 0 else { return (nil, .nothingToRemove) }
            
        var result: Baggage? = nil
        
        for i in 0..<baggageArray.count {
            let baggage = baggageArray[i]
            if baggage.id == id {
                guard decreaseTrunkSpace(baggage.space) else {
                    return (nil, .nothingToRemove)
                }
                result = baggageArray.remove(at: i)
                break
            }
        }
        
        guard result != nil else { return (nil, .baggageDoesNotExists(id: id)) }
        
        return (result, nil)
    }
    
    func printStatus() {
        print("""
            \n
            Тип: Легковой
            Модель: \(model)
            Год выпуска: \(year)
            Объем багажника: \(trunkSpace)
            Использованный объем багажника: \(usedTrunkSpace)
            \n
            """)
    }
    
    func printBaggage() {
         guard baggageArray.count > 0 else {
             print("Багажник пуст.")
             return
         }
         
         print("\nСодержимое багажника:")
         for baggage in baggageArray {
             print("\(baggage.name) занимает \(baggage.space) пространства багажника.")
         }
         print("Занято \(usedTrunkSpace) из \(trunkSpace)\n")
     }
}

func testCar() {
    let car = Car(model: "Test", year: 2000, trunkSpace: 200, baggageArray: [])
    guard let strongCar = car else { return }
    
    let pc = Baggage(id: 0, name: "PC", description: "Обычный PC", space: 30)
    let chair = Baggage(id: 1, name: "Стул", description: "Обычный стул", space: 70)
    let table = Baggage(id: 2, name: "Стол", description: "Обычный стол", space: 180)
    
    strongCar.addBaggage(pc)
    strongCar.addBaggage(chair)
    strongCar.removeBaggageBy(id: 1) // Успешное удаление
    strongCar.addBaggage(table) // Ошибка о том что не поместится
    print(strongCar.removeBaggageBy(id: 1000)) // Удаление несуществующего элемента
    strongCar.removeBaggageBy(id: 0)
    strongCar.printBaggage()
    print(strongCar.removeBaggageBy(id: 0)) // Ошибка удаления элемента из пустого багажника.
}

testCar()

/* /////////////////////////////////////////////////////////////////////////////////
 /// 2. Придумать класс, методы которого могут выбрасывать ошибки.                ///
 /// Реализуйте несколько throws-функций.                                         ///
 /// Вызовите их и обработайте результат вызова при помощи конструкции try/catch. ///
 ///////////////////////////////////////////////////////////////////////////////// */

enum PasswordValidationError: Error {
    case tooShort
    case noCapitalLetters
    case noNumbers
    case noSymbols
    case noSmallLetters
}

class PasswordValidation {
    private let smallLetters = "qwertyuiopasdfghjklzxcvbnm"
    private let numbers = "0123456789"
    private let capitalLetters = "QWERTYUIOPASDFGHJKLZXCVBNM"
    private let symbols = "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
    
    private let minimalLength: Int
    
    init(minimalLength: Int) {
        self.minimalLength = minimalLength
    }
    
    private func checkSmallLetters(_ password: String) throws {
        var flag = false
        for char in password {
            if smallLetters.contains(char) {
                flag = true
                break
            }
        }
        
        if !flag { throw PasswordValidationError.noSmallLetters }
    }
    
    private func checkNumbers(_ password: String) throws {
        var flag = false
        for char in password {
            if numbers.contains(char) {
                flag = true
                break
            }
        }
        
        if !flag { throw PasswordValidationError.noNumbers }
    }
    
    private func checkCapitalLetters(_ password: String) throws {
        var flag = false
        for char in password {
            if capitalLetters.contains(char) {
                flag = true
                break
            }
        }
        
        if !flag { throw PasswordValidationError.noCapitalLetters }
    }
    
    private func checkSymbols(_ password: String) throws {
        var flag = false
        for char in password {
            if symbols.contains(char) {
                flag = true
                break
            }
        }
        
        if !flag { throw PasswordValidationError.noSymbols }
    }
    
    private func checkLength(_ password: String) throws {
        guard password.count >= minimalLength else { throw PasswordValidationError.tooShort }
    }
    
    func validate(password: String) throws {
        do {
            try checkLength(password)
            try checkSmallLetters(password)
            try checkCapitalLetters(password)
            try checkNumbers(password)
            try checkSymbols(password)
        } catch PasswordValidationError.noSmallLetters {
            throw PasswordValidationError.noSmallLetters
        } catch PasswordValidationError.noCapitalLetters {
            throw PasswordValidationError.noCapitalLetters
        } catch PasswordValidationError.noNumbers {
            throw PasswordValidationError.noNumbers
        } catch PasswordValidationError.noSymbols {
            throw PasswordValidationError.noSymbols
        } catch PasswordValidationError.tooShort {
            throw PasswordValidationError.tooShort
        }
    }
}

let validator = PasswordValidation(minimalLength: 6)

let pass0 = "qQ1/aaa" // Все ок
let pass1 = "qQ1aaa" // без символов
let pass2 = "qQ/aaa" // без цифр
let pass3 = "Q1/111" // без маленьких букв
let pass4 = "q1/aaa" // без заглавных букв
let pass5 = "q1/A" // Меньше заданной длинны

do {
//    try validator.validate(password: pass0)
    try validator.validate(password: pass1)
//    try validator.validate(password: pass2)
//    try validator.validate(password: pass3)
//    try validator.validate(password: pass4)
//    try validator.validate(password: pass5)
} catch PasswordValidationError.noSmallLetters {
    print("Пароль не содержит маленьких букв!")
} catch PasswordValidationError.noCapitalLetters {
    print("Пароль не содержит заглавных букв!")
} catch PasswordValidationError.noNumbers {
    print("Пароль не содержит цифр!")
} catch PasswordValidationError.noSymbols {
    print("Пароль не содержит символов!")
} catch PasswordValidationError.tooShort {
    print("Пароль слишком короткий!")
}
