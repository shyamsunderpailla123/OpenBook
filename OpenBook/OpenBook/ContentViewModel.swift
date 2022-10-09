import Foundation

@MainActor
class ContentViewModel: ObservableObject {
    @Published var bookList = [Doc]()
    @Published var didFailedRequest: Bool = false
    
    func fetchBooks(title: String) {
        RestAPIClient.getBooks(title: title) {[weak self] results in
            switch results {
            case .success(let bookDetails):
                self?.bookList = bookDetails.docs ?? []
            case .failure(let error):
                print(error.localizedDescription)
                self?.didFailedRequest = true
            }
        }
    }
    
}
