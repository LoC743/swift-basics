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
