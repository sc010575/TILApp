import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Post
    router.post("api", "acronyms") { req -> Future<Acronym> in
        // 2
        return try req.content.decode(Acronym.self)
            .flatMap(to: Acronym.self) { acronym in
                // 3
                return acronym.save(on: req)
        }
    }
    
    // Get all acronyms
    router.get("api", "acronyms") { req -> Future<[Acronym]> in
        // 2
        return Acronym.query(on: req).all()
    }
    
    // Sorted all acronyms by short name
    router.get("api", "acronyms", "sorted") {
        req -> Future<[Acronym]> in
        // 2
        return Acronym.query(on: req)
                .sort(\.short, .ascending)
                .all()
    }
}
