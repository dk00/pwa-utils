import
  path: {join}
  fs
  webpack
  \memory-fs : MemoryFS

output-path = join process.cwd!, \www
fixture-path = \./test/fixtures
function create-fs
  base = new MemoryFS
  base.mkdirp-sync output-path
  base

function run-webpack options, files
  compiler = webpack options
  compiler.output-file-system = fs = create-fs files

  new Promise (resolve, reject) ->
    compiler.run (err, stats) ->
      | err => reject err
      | stats.has-errors! => reject stats
      | _ => resolve fs

export default: run-webpack
