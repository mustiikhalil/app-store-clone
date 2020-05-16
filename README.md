This is an implementation for the app store that is running on the itunes api that's provided from Apple. 

Please do run `pod install` and `brew install swiftlint` before opening the project since i am using `swiftlint`

## NOTE:

The podfile contains a private repository on gitlab, which was made for testing reasons. Please change it to the following:

`pod 'iTunesClient', :git => 'https://github.com/mustiikhalil/iTunesClient/'`

The application is using operations to handle all the jobs the applications does, where all of the operations created extend the following class `BaseOperation`
``` swift
infix operator >>>

class BaseOperation: Operation {
    private var _isAsynchronous = false
    override var isAsynchronous: Bool {
        get {
            return _isAsynchronous
        }
        set {
            willChangeValue(forKey: "isAsynchronous")
            _isAsynchronous = newValue
            didChangeValue(forKey: "isAsynchronous")
        }
    }
    
    func executing(_ isExecuting: Bool) {
        self.isExecuting = isExecuting
        self.isFinished = !isExecuting
    }
}

extension OperationQueue {
    
    func cancelAllOperationsWithDependencies() {
        for operation in operations.reversed() {
            operation.cancel()
        }
    }
}

extension Operation {
    
    static func >>>(lhs: Operation, rhs: Operation) {
        rhs.addDependency(lhs)
    }
}

```

1. Delay Operations

```swift

class DelayOperation: BaseOperation {

    override func main() {
        timer.setEventHandler { [weak self] in
            os_log("Delay operation done", type: .debug)
            self?.executing(false)
        }
        timer.schedule(deadline: delay)
        timer.resume()
    }
}

```

2. Fetching from the iTunes API

```swift

class FetchOperation: BaseOperation {

    override func main() {
        //... more logic
        URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
        //... more logic
        }.resume()
    }
}

```

3. Decoding the JSON data into it's respective codables

```swift

class DecodeOperation<T: Codable>: BaseOperation {

    override func main() {
        //... more logic
        result.data = try JSONDecoder().decode(T.self, from: currentData)
        //... more logic
    }
}

```

4. Some UI elements operations

```swift
class SomeViewController: UIViewController {

    func updateUI() {
        activityIndicator.startAnimating()
        refreshOperation.completionBlock = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.groups = self.orderedGroup.filter { $0.appGroup != nil }
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
}

```
