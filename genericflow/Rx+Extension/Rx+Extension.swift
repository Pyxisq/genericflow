import UIKit
import RxSwift
import RxCocoa

public extension ObservableType where Element == String? {
  func unwrap() -> Observable<String> {
    compactMap { $0 }
  }
}

public extension Reactive where Base: UIScrollView {

  var reachedBottom: Observable<Void> {
    return contentOffset
      .flatMap { [scrollView = base] contentOffset -> Observable<Void> in
        let contentInsetVertical = scrollView.contentInset.top + scrollView.contentInset.bottom
        let visibleHeight = scrollView.frame.height - contentInsetVertical
        let contentOffsetY = contentOffset.y + scrollView.contentInset.top
        let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)

        return contentOffsetY > threshold ? Observable.just(()) : Observable.empty()
      }
  }
}
