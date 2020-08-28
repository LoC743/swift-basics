/* ////////////////////////////////////////////////////////////////
/// Написать функцию, которая определяет, четное число или нет. ///
//////////////////////////////////////////////////////////////// */

func isEven(number: Int) -> Bool {
    var result = false
    
    if number % 2 == 0 {
        result = true
    }
    
    return result
}

isEven(number: 2)
isEven(number: 3)


/* /////////////////////////////////////////////////////////////////////////////
/// Написать функцию, которая определяет, делится ли число без остатка на 3. ///
///////////////////////////////////////////////////////////////////////////// */

func isDivisibleByThree(number: Int) -> Bool {
    var result = false
    
    if number % 3 == 0 {
        result = true
    }
    
    return result
}

isDivisibleByThree(number: 7)
isDivisibleByThree(number: 6)


/* //////////////////////////////////////////////
/// Создать возрастающий массив из 100 чисел. ///
///////////////////////////////////////////// */

func createIntArray(size: Int) -> [Int] {
    guard size > 0 else {
        return []
    }
    
    var array: [Int] = []
    
    for i in 1...size {
        array.append(i)
    }
    
    return array
}

let array = createIntArray(size: 100)


/* ////////////////////////////////////////////////////////////////////////////////////
/// Удалить из этого массива все четные числа и все числа, которые не делятся на 3. ///
//////////////////////////////////////////////////////////////////////////////////// */

func removeNumbersFrom(array: [Int]) -> [Int] {
    let resultArray = array.filter {
        if isEven(number: $0) || !isDivisibleByThree(number: $0) {
            return false
        }
        return true
    }
    
    return resultArray
}

removeNumbersFrom(array: array)


/* ///////////////////////////////////////////////////////////////////////
/// Написать функцию, которая добавляет в массив новое число Фибоначчи,///
////////////// и добавить при помощи нее 50 элементов.////////////////////
/////////Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2. //////
/////////////////////////////////////////////////////////////////////// */

func createFibonacciArray(size: Int) -> [Int] {
    var array: [Int] = [0, 1]
    for i in 2...size {
        let newElement = array[i - 2] + array[i - 1]
        array.append(newElement)
    }
    
    return array
}

func addFibbonacci(to array: [Int], numberOfElements: Int) -> [Int] {
    guard array.count > 3 else {
        return createFibonacciArray(size: numberOfElements)
    }
    
    guard numberOfElements > 0 else {
        return array
    }
    
    var result: [Int] = array
    
    for _ in 0..<numberOfElements {
        let arraySize = result.count
        let newElement = result[arraySize - 2] + result[arraySize - 1]
        
        result.append(newElement)
    }
    
    return result
}

let fibArr = createFibonacciArray(size: 10)
fibArr.count  // Создается на 1 больше чем указан size, потому что первый элемент "0" считается 0-ым

let newFibArr = addFibbonacci(to: fibArr, numberOfElements: 50)
