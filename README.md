# BuildKite.jl

Yet another API implementation of BuildKite REST-ful APIs, but in julia. (simply wraping APIs with HTTP.jl and JSON.jl) So BuildKite.jl tries to provide some functions, which adheres to [BuildKite APIs (Version 2) | BuildKite Documentation](https://buildkite.com/docs/apis).

(~~Actually, the main purpose of this repository for me is only to read API docs, own a understanding of some specific concepts, use my PC as a buildkite agent to run CI pipeline builds and test functions in this repository to make sure they could and would work, which got myself much more familiar with BuildKite platform.~~)

## Credit

* [GitHub.jl](https://github.com/JuliaWeb/GitHub.jl): refer to HTTP action wrapper implementation; really learn a lot meta-programming and design ideas from `@ghdef` although I didn't use these thoughts here.
* [HTTP.jl](https://github.com/JuliaWeb/HTTP.jl): refer to client functionalities.
