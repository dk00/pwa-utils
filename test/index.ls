require \../register <| plugins: [\istanbul]

{describe} = require \riteway

describe 'Web App Manifest' (require './manifest' .default)
describe 'Web App index.html' (require './html' .default)
