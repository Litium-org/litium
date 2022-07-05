request = {}

https = require 'https'

function request.newRequest(url)
    return https.request(url)
end

return request