import Vapor
import Fluent

final class Poi: Model {
    
    static var entity = "pois"
    
    var id: Node?
    var raceId: Node
    
    var title: String
    var description: String
    
    var showOn: String
    var lat: Double
    var lng: Double
    var imagePath: String
    
    var isActive: Bool
    var createdAt: String
    var updatedAt: String
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        raceId = try node.extract("race_id")
       
        title = try node.extract("title")
        description = try node.extract("description")
        
        showOn = try node.extract("show_on")
        lat = try node.extract("lat")
        lng = try node.extract("lng")
        imagePath = try node.extract("image_path")
        
        isActive = try node.extract("is_active")
        createdAt = try node.extract("created_at")
        updatedAt = try node.extract("updated_at")
    }
    
    func makeNode() throws -> Node {
        return try Node(node: [
            "id": id,
            "race_id": raceId,
            
            "title": title,
            "description": description,
            
            "show_on": showOn,
            "lat": lat,
            "lng": lng,
            "image_path": imagePath,
            
            "is_active": isActive,
            "created_at": createdAt,
            "updated_at": updatedAt
        ])
    }
    
    func makeJSON() throws -> JSON {
        return try JSON(node: [
            "id": id,
            "title": title,
            "description": description
        ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("pois") { pois in
            pois.id()
            pois.int("race_id");
            
            pois.string("title")
            pois.string("description")
            
            pois.string("show_on")
            pois.double("lat")
            pois.double("lng")
            pois.string("image_path")
            
            pois.bool("is_active")
            pois.string("created_at", optional: true)
            pois.string("updated_at", optional: true)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("pois")
    }
}

extension Poi {
    func race() throws -> Parent<Race> {
        return try parent(raceId)
    }
}