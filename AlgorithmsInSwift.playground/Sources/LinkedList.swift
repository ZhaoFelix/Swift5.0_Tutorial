import Foundation


public class Node<Value> {
    public var value: Value
    public var next: Node?
    public init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}


public struct LinkedList<Value> {
    // 头指针
    public var head: Node<Value>?
    // 尾指针
    public var tail: Node<Value>?
    public init() {}
    public var isEmpty: Bool {
        head == nil
    }
    //copy-on-write 即COW
    private mutating func copyNodes() {
        guard var oldNode = head else {
            return
        }
        head = Node(value: oldNode.value)
        var newNode = head
        while let nextOldNode =  oldNode.next {
            newNode?.next = Node(value: nextOldNode.value)
            newNode = newNode?.next
            oldNode = nextOldNode
        }
        tail = newNode
    }
    
    private mutating func copyNodes(returningCopyOf node: Node<Value>?) -> Node<Value>? {
        guard !isKnownUniquelyReferenced(&head) else {
            return nil
        }
        guard var oldNode = head else {
            return nil
        }
        head = Node(value: oldNode.value)
        var newNode = head
        var nodeCopy: Node<Value>?
        while let nextOldNode = oldNode.next {
            if oldNode === node {
                nodeCopy = newNode
            }
            newNode?.next = Node(value: nextOldNode.value)
            newNode = newNode?.next
            oldNode = nextOldNode
        }
        return nodeCopy
    }
    
    // 头部插入值
    // 时间复杂度O(1)
    public mutating func push(_ value: Value) {
        copyNodes()
        head = Node(value: value, next: head)
        // 如果尾指针为空，说明是一个链表，头尾指针指向同一个节点
        if tail == nil {
            tail = head
        }
    }
    
    // 尾部插入元素
    // 时间复杂度O(1)
    public mutating func append(_ value: Value) {
        copyNodes()
        // 空链表
        guard !isEmpty else {
            push(value)
            return
        }
        // 尾部指针赋值新的节点
        tail!.next = Node(value: value)
        
        tail = tail?.next
    }
    
    // 获取指定索引位置的节点
    // 时间复杂度O(i)，i为指定的索引值
    public func node(at index: Int) -> Node<Value>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
    }
    
    // 在指点节点后插入新的节点
    @discardableResult
    public mutating func insert(_ value: Value, afater node: Node<Value>) -> Node<Value> {
        copyNodes()
        // 尾结点等于目标节点，直接尾部插入
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
     /// 移除头部元素
     /// 时间复杂度O(1)
    @discardableResult
    public mutating func pop() -> Value? {
        copyNodes()
        defer {
            // 将头部节点指向下一个
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    /// 移除尾部最后一个节点
    /// 时间复杂度O(1)
    @discardableResult
    public mutating func removeLast() -> Value? {
        copyNodes()
        // 头部为nil,不存在节点
        guard let head = head else {
            return nil
        }
        // 只存在一个节点
        guard head.next != nil else {
            return pop()
        }
        
         // 利用双指针，找到倒数第一和第二个节点
        var prev = head
        var current = head
        while let next = current.next {
            prev = current
            current = next
        }
        
        prev.next = nil
        tail = prev
        return current.value

    }
    
    /// 删除指定节点后的节点
    /// 时间复杂度O(1)
    @discardableResult
    public mutating func remove(after node: Node<Value>) ->Value? {
        copyNodes()
        guard let node = copyNodes(returningCopyOf: node) else {
            return nil
        }
        defer {
            //
            if node.next === tail {
                tail = node
            }
            // 指针指向下一个节点
            node.next = node.next?.next
        }
        return node.next?.value
    }
    
    
}


extension Node: CustomStringConvertible {
    public var description: String {
        guard let next = next else {
            return "\(value)"
        }
        return "\(value) -> " + String(describing: next) +  ""
    }
}


extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty List"
        }
        return String(describing: head)
    }
}

// 链表翻转
extension LinkedList {
    // 时间和空间复杂度O(n), n为链表长度。
   public mutating func reverse() {
        var temList = LinkedList<Value>()
        for value in self {
            temList.push(value)
        }
        head = temList.head
    }
    
    mutating func reverseSimple() {
        tail = head
        var prev = head
        var current = head?.next
        prev?.next = nil
        while current != nil {
            let next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
    }
    
}

// TODO: 集合相关的扩展

extension LinkedList: Collection {

    public struct Index: Comparable {
        public var node: Node<Value>?
        static public func ==(lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                 return false
            }
        }
        
        static public func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
        }
    }
    
    /// 头节点索引
    public var startIndex: Index {
        Index(node: head)
    }
    
    /// 尾节点索引
    public var endIndex: Index {
        Index(node: tail?.next)
    }
    
    public func index(after i: Index) -> Index {
        Index(node: i.node?.next)
    }
    public subscript(position: Index) -> Value {
        position.node!.value
    }
}
