//
//  ContentView.swift
//  Notes
//
//  Created by Brandon Robb on 4/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var noteApp = NoteViewModel()
    @State var note = NoteModel(title: "", notesdata: "")
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($noteApp.notes) { $note in
                    NavigationLink {
                        NoteDetail(note: $note)
                    } label: {
                        Text(note.title)
                    }
                }
                Section {
                    NavigationLink {
                        NoteDetail(note: $note)
                    } label: {
                        Text("New note")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 15))
                    }
                }
            }
            .navigationTitle("My Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Sign Out") {
                        authViewModel.signOut()
                    }
                }
            }
        }
        .onAppear {
            noteApp.fetchData()
        }
        .refreshable {
            noteApp.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
