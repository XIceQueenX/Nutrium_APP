//
//  Persistance.swift
//  Nutrium
//
//  Created by Gloria Martins on 19/03/2025.
//


import Foundation
import CoreData
import Alamofire

class PersistenceController {
    static var shared = PersistenceController()
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    let container: NSPersistentContainer
    init(inMemory: Bool = false) {
        
        container = NSPersistentContainer(name: "CacheImage")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveProfessional(_ professionals: [Professional]) async {
        do {
            for professional in professionals {
                let fetchRequest: NSFetchRequest<ProfessionalCD> = ProfessionalCD.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id_professional == %d", professional.id)
                
                let existingProfessional = try context.fetch(fetchRequest).first ?? ProfessionalCD(context: context)
                
                existingProfessional.id_professional = Int16(professional.id)
                existingProfessional.name = professional.name
                existingProfessional.rating = Int16(professional.rating)
                existingProfessional.rating_count = Int16(professional.ratingCount)
                existingProfessional.profile_picture_url = await downloadImage(from: professional.profilePictureUrl)
                existingProfessional.expertise = professional.expertise as NSArray
                existingProfessional.languages = professional.languages as NSArray
            }
        
            try context.save()
        } catch {
            print("Failed saveProfessional: \(error.localizedDescription)")
        }
    }
    
    func fetchProfessionals(offset: Int, limit: Int) -> [ProfessionalCD] {
        let fetchRequest: NSFetchRequest<ProfessionalCD> = ProfessionalCD.fetchRequest()
        
        fetchRequest.fetchLimit = limit
        fetchRequest.fetchOffset = offset
        
        do {
            let professionalsCD = try context.fetch(fetchRequest)
            return professionalsCD
        } catch {
            print("Failed to fetchProfessionals: \(error.localizedDescription)")
            return []
        }
    }
}
