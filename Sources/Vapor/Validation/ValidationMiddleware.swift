/**
    Catches validation errors and prints
    out a more readable JSON response.
*/
class ValidationMiddleware: HTTPMiddleware {

    func respond(to request: HTTP.Request, chainingTo chain: HTTPResponder) throws -> HTTP.Response {
        do {
            return try chain.respond(to: request)
        } catch let error as ValidationErrorProtocol {
            let json = JSON([
                "error": true,
                "message": error.message
            ])
            let data = try JSON.serializer(json: json).utf8.array
            return HTTP.Response(status: .badRequest, body: .data(data))
        }
    }
    
}
