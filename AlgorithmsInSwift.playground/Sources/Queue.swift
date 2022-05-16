import Foundation

public struct  QueueArray<T>: Queue {
    private var array: [T] = []
    // 入队列
    public mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    // 出队列
    public mutating func dequeue() -> T? {
        isEmpty! ? nil : array.removeFirst()
    }
    
    public var isEmpty: Bool? {
        array.isEmpty
    }
    public var peek: T? {
        array.first
    }
    public init() {
        
    }
}


public class QueueLinkedList<T>: Queue {
    
}

