//
//  NoteModel.swift
//  Notes
//
//  Created by Brandon Robb on 4/12/25.
//


import Foundation
import FirebaseFirestore

struct NoteModel : Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var notesdata: String
}
