import UIKit
func foo(){
    print("A")
    
    DispatchQueue.main.async {
        print("b")
    }
    DispatchQueue.global().sync {
        print("g")
    }
    print("C")
    
}

foo()

RunLoop.main.run()
