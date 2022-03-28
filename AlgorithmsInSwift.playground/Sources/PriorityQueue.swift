import Foundation

/*
 1、优先队列
 优先队列可以分为最大优先和最小优先队列两种。优先队列经常被用来查找最小值和最大值。
 */

public protocol Queue {
    associatedtype Element
    /// 插入一个元素，如果操作成功，返回true
    mutating func enqueue(_ element: Element) -> Bool
    /// 移除优先级最大的元素，并且返回移除的值；如果队列为空，返回`nil`。
    mutating func dequeue() -> Element?
    /// 队列是否为空
    var isEmpty: Bool? { get }
    /// 返回队列中优先级最大的元素
    var peek: Element? { get }
}

/// 使用堆创建一个优先队列，同时继承上面的`Queue`协议。

public struct PriorityQueue<Element: Equatable> : Queue {
    mutating public func enqueue(_ element: Element) -> Bool {
        heap.insert(element)
        return true
    }
    
    mutating public func dequeue() -> Element? {
        heap.remove()
    }
    
    public var isEmpty: Bool? {
        heap.isEmpty
    }
    
    public var peek: Element? {
        heap.peek()
    }
    
    private var heap: Heap<Element>
    public init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
        heap = Heap(sort: sort, elements: elements)
    }
}


/// 基于数组的优先队列
public struct PriorityQueueArray<Element: Equatable>: Queue {
    /// - note: 整体的时间复杂度为O(n)
    public mutating func enqueue(_ element: Element) -> Bool {
        // 循环遍历数组
        for (index, otherElement) in elements.enumerated() {
            if sort(element, otherElement) {
                // 将元素插入指定位置
                elements.insert(element, at: index)
                return true
            }
        }
        // 如果不存在低优先级的元素，直接插入到末尾
        elements.append(element)
        return true
    }
    
    public mutating func dequeue() -> Element? {
        isEmpty! ? nil : elements.removeFirst()
    }
    
    public var isEmpty: Bool? {
        elements.isEmpty
    }
    
    public var peek: Element? {
        elements.first
    }
    
    private var elements: [Element] = []
    let sort: (Element, Element) -> Bool
    public init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
        self.sort = sort
        self.elements = elements
        // 将元素按照自定义的排序规则进行排序
        self.elements.sort(by: sort)
    }
    
}



// 按照指定的优先级，优先买票

/// 用户属性
/// - para: isMilitary 是否属于军人
public struct Person: Equatable {
    let name: String
    let age: Int
    let isMilitary: Bool
    public init(name: String, age: Int, isMilitary: Bool) {
        self.age = age
        self.name = name
        self.isMilitary = isMilitary
    }
}

/// 按照优先级对两个人进行排序
/// - return: 如果person1的优先级高于person2，返回true
/// - note: 优先级定义为 军人优先 > 年长者优先 > 普通人
public func tswiftSort(person1: Person, person2: Person) -> Bool {
    if person1.isMilitary == person2.isMilitary {
        return person1.age > person2.age
    }
    return person1.isMilitary
}


