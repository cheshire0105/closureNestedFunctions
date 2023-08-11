import UIKit

/*:
 # 중첩함수
 Nested Functions
 
 함수 내부에 또 다른 함수를 정의할 수 있습니다. \
 이렇게 함수 내부에 정의된 함수를 중첩 함수라고 합니다.
 */
func outerFunction() {
    print("외부 함수 입니다.")
    
    func innerFunction() {
        print("내부 함수 입니다.")
    }
    
    // 함수 내부에서 함수를 호출하게 작동 합니다.
    innerFunction()
}

outerFunction()
/*:
 # 중첩함수와 클로저
 Nested Functions & Closure
 
 클로저와 중첩함수는 깊은 연관이 있습니다. \
 많은 공통점을 가지고 있고, 클로저는 중첩함수의 연장선이라고 이해 할 수도 있습니다.
 
 ## 중첩함수와 클로저의 관계
 - 익명성: 중첩 함수는 이름을 가지고 있지만, 클로저는 이름이 없는 코드 블록입니다.
 - 캡쳐링 (Capturing): 클로저는 그들이 정의된 범위에서 변수와 상수를 "캡쳐"할 수 있습니다. \
 이는 클로저가 해당 변수와 상수에 접근하고 수정할 수 있음을 의미합니다. 중첩 함수도 동일한 환경에서 변수를 캡쳐할 수 있습니다.
 - 전달 가능: 스위프트에서 함수와 클로저는 일급 객체이므로 다른 함수의 매개변수로 전달할 수 있습니다. \
 중첩 함수를 외부로 반환하면, 그것은 사실상 클로저가 됩니다.
 */
//: ### 중첩함수
func outerFunction(value: Int) -> (Int) -> Int {
    func innerFunction(anotherValue: Int) -> Int {
        return value + anotherValue
    }
    return innerFunction
}

let resultFunction = outerFunction(value: 5)
print(resultFunction(10))  // 출력: 15
/*:
 위의 예제에서 outerFunction은 중첩 함수 innerFunction을 반환합니다. \
 반환된 innerFunction은 사실상 클로저로 동작하며, value 변수를 캡쳐해서 사용합니다. \
 이렇게 중첩 함수와 클로저는 매우 밀접한 관계를 가지며, 많은 특성을 공유합니다. \
 중첩 함수는 그 자체로도 유용하지만, 클로저와 함께 사용하면 스위프트의 함수형 프로그래밍 기능을 최대한 활용할 수 있습니다.
 */
//: ### 위와 같지만 클로저를 사용한 예시
func outerFunctionWithClosure(value: Int) -> (Int) -> Int {
    let closure: (Int) -> Int = { anotherValue in
        return value + anotherValue
    }
    return closure
}

let resultClosure = outerFunctionWithClosure(value: 3)
print(resultClosure(5))

/*:
 두 버전 모두 outerFunction에서 정의된 value를 캡쳐하여 나중에 사용합니다. \
 클로저 버전에서는 명시적으로 이름이 없는 코드 블록({})을 사용하고 있습니다. \
 이 예제를 통해 중첩 함수와 클로저가 동일한 기능을 할 수 있음을 확인할 수 있습니다. \
 클로저는 더 간결하고 유연한 문법을 제공하기 때문에, 특히 비동기 작업이나 고차 함수에서 더 자주 사용됩니다.
 */
/*:
 # 클로저의 @escaping 키워드
 
 @escaping은 클로저가 함수의 실행을 완료한 후에도 호출될 수 있음을 나타냅니다. \
 예를 들어, 비동기 작업에서 클로저가 나중에 실행될 수 있습니다.
 
 클로저는 클래스 처럼 참조 타입이기 때문에 범위를 벗어나면 메모리에서 해제 됩니다. \
 그렇기 때문에 @escaping 키워드를 사용해서 범위를 벗어나더라도 계속 유지 될 수 있게 해 주어야 합니다. \
 기본적인 클로저의 생명 주기는 함수 범위 내부 입니다.
 
 앞서 설명 했던 비동기 작업의 예시인 네트워크 작업으로 예를 들어보겠습니다. \
 네트워크 작업의 경우 간단하게 설명 하자면 시간이 걸리는 작업이기 때문에 다른 쓰레드에서 작업이 진행 됩니다. \
 클로저를 사용 하지 않으면 다른 쓰레드에서 실행 되고 메모리에서 해제 되기 때문에 작업이 완료 된 후에 알 길이 없습니다. \
 그렇기 때문에 @escaping 키워드를 사용해서 작업이 완료 됐다는 것을 받아야 합니다.
 
 주의점으로 메모리에서 계속 유지 됨으로 메모리 관리에 유의 해야 합니다.
 */
var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

/*:
 # 오토클로저
 Auto Closure
 
 자동으로 클로저를 만들어 주는 문법 입니다. 위의 키워드와 같은 형식입니다. @autoclosure
 
 @autoclosure 사용 시 \
 함수를 호출할 때, 단순한 표현식만을 인자로 전달할 수 있습니다. 클로저 문법을 사용할 필요가 없습니다.
 
 표현식의 실행 시점 \
 표현식은 함수 내에서 클로저가 호출될 때 실행됩니다. 따라서 @autoclosure로 전달된 표현식은 즉시 실행되지 않을 수 있습니다.
 
 */

var kakaoFriends = ["muzi", "ryon", "apeach", "neo", "tube", "con"]

func removeAt(_ closure: @autoclosure () -> String) -> String {
    return closure()
}

print(removeAt(kakaoFriends.removeFirst())) // "muzi"

removeAt(kakaoFriends.removeLast())

/*:
 @autoClosure를 사용 하지 않았을 때 코드 입니다. \
 클로저 문법 {}를 사용하여 함수를 호출해야 합니다.
 
 클로저 문법을 사용하므로, 클로저 내부의 표현식 실행 시점은 클로저가 호출되는 시점에 결정됩니다.
 
 
 */

func removeAtWithoutAutoclosure(_ closure: () -> String) -> String {
    return closure()
}

print(removeAtWithoutAutoclosure { kakaoFriends.removeFirst() })  // "muzi"

/*:
 # 응용 및 정리
 
 배열 내부의 숫자를 정리 하는 함수를 이해해봅시다.
 
 */
func sortUsingNestedFunction(_ array: [Int]) -> [Int] {
    func ascending(_ a: Int, _ b: Int) -> Bool {
        return a < b
    }
    
    return array.sorted(by: ascending)
}
//: 위의 함수를 클로저를 통해 간결하게 바꾸었습니다.
func sortUsingClosure(_ array: [Int]) -> [Int] {
    return array.sorted(by: { (a, b) -> Bool in
        return a < b
    })
}
//: 좀 더 간결하게 바꿀 수도 있습니다.
func sortUsingClosureShort(_ array: [Int]) -> [Int] {
    return array.sorted(by: { a, b in a < b })
}

sortUsingNestedFunction([3,1,2])
sortUsingClosure([8,6,9])
sortUsingClosureShort([10,5,6])
