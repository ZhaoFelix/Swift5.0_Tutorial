import Foundation

public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
    var count: Int { get }
}

public  class QueueArray<T>: Queue {
  
    private var array: [T] = []
    public init(){
        
    }
    
    public var isEmpty: Bool {
        array.isEmpty
    }
    
    public var peek: T? {
        array.first
    }
    
    public var count: Int {
        array.count
    }
    @discardableResult
    public func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    
    @discardableResult
    public func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
    
    
}
