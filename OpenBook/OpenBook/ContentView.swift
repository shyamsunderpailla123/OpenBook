import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            if viewModel.bookList.isEmpty {
                Text("No search result")
            } else {
                List {
                    ForEach(viewModel.bookList, id: \.self) { doc in
                        VStack {
                            Text(doc.title)
                            Text(doc.author_name.first ?? "")
                            Text(doc.key)
                        }
                    }
                }
                
            }
                
        }.onChange(of: searchText) { value in
            viewModel.fetchBooks(title: value)
        }
        .navigationTitle("Search books")
        .searchable(text: $searchText)
        .sheet(isPresented: $viewModel.didFailedRequest) {
            SheetView()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct SheetView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("The request failed. Please try again.")
            Button("Press to dismiss") {
                dismiss()
            }
            .font(.title)
        }
        .padding()
    }
}
