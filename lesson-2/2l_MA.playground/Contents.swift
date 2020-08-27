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
