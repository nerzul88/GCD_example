import UIKit
import PlaygroundSupport
//принудительно заставляем Playground постоянно выполнять вычисления
PlaygroundPage.current.needsIndefiniteExecution = true

//Блоки

//class SafeArray<Element> {
//    private var array = [Element]()
//    private let queue = DispatchQueue(label: "DispatchBarrier", attributes: .concurrent)
//
//    public func append(element: Element) {
//        queue.async(flags: .barrier) {
//            self.array.append(element)
//        }
//    }
//
//    public var elements: [Element] {
//        var result = [Element]()
//        queue.sync {
//            result = self.array
//        }
//        return result
//    }
//}
//
//var safeArray = SafeArray<Int>()
////метод, выполняющий параллельные запросы
//DispatchQueue.concurrentPerform(iterations: 10) { (index) in
//    safeArray.append(element: index)
//}
//print("safeArray: \(safeArray.elements)")
//
//var array = [Int]()
////метод, выполняющий параллельные запросы
//DispatchQueue.concurrentPerform(iterations: 10) { (index) in
//    array.append(index)
//}
//print("array: \(array)")

//Группы

////создаём очередь
//let queue = DispatchQueue(label: "ru.swiftbook", attributes: .concurrent)
////создаём очередь
//let group = DispatchGroup()
////помещаем группу в очередь
//queue.async(group: group) {
//    for i in 0...10 {
//        if i == 10 {
//            print(i)
//        }
//    }
//}
//
//queue.async(group: group) {
//    for i in 0...20 {
//        if i == 20 {
//            print(i)
//        }
//    }
//}
//
//group.notify(queue: .main) {
//    print("Всё закончено в группе: group")
//}
//
////создаём вторую группу
//let secondGroup = DispatchGroup()
////входим во вторую группу
//secondGroup.enter()
//queue.async(group: group) {
//    for i in 0...30 {
//        if i == 30 {
//            print(i)
//            sleep(2)
//            secondGroup.leave()
//        }
//    }
//}
//
//let result = secondGroup.wait(timeout: .now() + 1)
//print(result)
//
//secondGroup.notify(queue: .main) {
//    print("Всё закончено в группе: secondGroup")
//}
//
//print("Этот принт должен быть выше последнего")
//
//secondGroup.wait()

//Блоки

//let workItem = DispatchWorkItem(qos: .utility, flags: .detached) {
//    print("Performing workitem")
//}
//
////workItem.perform()
//
//let queue = DispatchQueue(label: "ru.swiftbook", qos: .utility, attributes: .concurrent, autoreleaseFrequency: .workItem, target: DispatchQueue.global(qos: .userInitiated))
//
//queue.asyncAfter(deadline: .now() + 1, execute: workItem)
//
//workItem.notify(queue: .main) {
//    print("workitem is completed!")
//}
//
//workItem.isCancelled
//workItem.cancel()
//workItem.isCancelled
//
//workItem.wait()

//Семафоры

//let queue = DispatchQueue(label: "ru.swiftbook", attributes: .concurrent)
////создаём семафор с числом одновременно пропускаемых потоков
//let semaphore = DispatchSemaphore(value: 0)
//semaphore.signal()
//queue.async {
//    //ждём, пока не получим сигнал
//    semaphore.wait(timeout: .distantFuture)
//    //приостанавливаем поток на определённое время
//    Thread.sleep(forTimeInterval: 4)
//    print("Block 1")
//    //подаём сигнал семафору для запуска следующего потока
//    semaphore.signal()
//}
//
//queue.async {
//    //ждём, пока не получим сигнал
//    semaphore.wait(timeout: .distantFuture)
//    //приостанавливаем поток на определённое время
//    Thread.sleep(forTimeInterval: 2)
//    print("Block 2")
//    //подаём сигнал семафору для запуска следующего потока
//    semaphore.signal()
//}
//
//queue.async {
//    //ждём, пока не получим сигнал
//    semaphore.wait(timeout: .distantFuture)
//    print("Block 3")
//    //подаём сигнал семафору для запуска следующего потока
//    semaphore.signal()
//}
//
//queue.async {
//    //ждём, пока не получим сигнал
//    semaphore.wait(timeout: .distantFuture)
//    print("Block 4")
//    //подаём сигнал семафору для запуска следующего потока
//    semaphore.signal()
//}

//Источники отправки

let queue = DispatchQueue(label: "ru.swiftbook", attributes: .concurrent)
//создаём таймер
let timer = DispatchSource.makeTimerSource(queue: queue)
//настраиваем таймер
timer.schedule(deadline: .now(), repeating: .seconds(2), leeway: .milliseconds(300))
timer.setEventHandler {
    print("Hello world")
}
//создаём блок отмены
timer.setCancelHandler {
    print("Timer is cancelled")
}
//запускаем таймер
timer.resume()
