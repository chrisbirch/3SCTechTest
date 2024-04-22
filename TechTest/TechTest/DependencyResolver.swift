import Foundation

@propertyWrapper
struct Inject<T> {
    public var wrappedValue: T {
        DependencyResolver.shared.resolve()
    }

    public init() { }
}

@propertyWrapper
struct InjectOptional<T> {
    public var wrappedValue: T? {
        DependencyResolver.shared.resolveOptional()
    }

    public init() { }
}

class DependencyResolver {

    private var storage = [String: Any]()

    static let shared = DependencyResolver()
    
    private init() {
        reset()
    }

    func clear() {
        storage = [:]
    }

    func reset() {
        clear()
        add(NetworkServiceImplementation() as NetworkService)
        add(DateServiceImplementation() as DateService)
        add(DateFormatterServiceImplementation() as DateFormatterService)
    }

    func add<T>(_ injectable: T) {
        let key = String(describing: T.self)
            .replacingOccurrences(of: "Optional<", with: "")
            .replacingOccurrences(of: ">", with: "")

        storage[key] = injectable
    }

    func resolve<T>(or alternative: T? = nil) -> T {
        let key = String(describing: T.self)
        if key.contains("Optional<") {
            fatalError("Use resolveOptional: instead")
        }
        guard let injectable = storage[key] as? T else {
            fatalError("\(key) has not been added as an injectable object.")
        }

        return injectable
    }
    func resolveOptional<T>() -> T? {
        let key = String(describing: T.self)
            .replacingOccurrences(of: "Optional<", with: "")
            .replacingOccurrences(of: ">", with: "")

        let injectable = storage[key] as? T

        return injectable
    }
}
