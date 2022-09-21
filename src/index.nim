import nimib
import nimiSlides

nbInit(theme = revealTheme)
setSlidestheme(Black)

slide:
  nbText: "## Nim for Hackers"

# what is and why use
slide:
  slide:
    nbText: "## what is nim?"
    nbImage("../images/nim_for_hackers.png")
  slide:
    nbText: "[nim-lang.org](https://nim-lang.org/)"
    nbText: "\"Efficient, expressive, elegant\""
    nbText: "\"Nim is a statically typed compiled systems programming language. It combines successful concepts from mature languages like Python, Ada and Modula\""
  slide:
    nbText: "Esoteric language (like  🦀)"
  slide:
    nbText: "Creates small binaries"
    nbText: "Nim compiler generates executables across all major platforms"
    nbText: "Supports different backends: C, Cpp, [Javascript](../deliverables/simple.html)"
    nbText: "Different memory management models"
  slide:
    nbText: "nim can be used to do a lot.."
    nbText: "- gui"
    nbText: "- cli"
    nbText: "- these slides"
  slide:
    nbText: "nim can also not do a lot"
    nbText: "- \"young\" lang, no comercial support"
  slide:
    nbText: "installation:"
    nbText: "- [/install.html](https://nim-lang.org/install.html)"
    nbText: "unix = easy"
    nbText: "windows = gl;hf"

# opsec
slide:
  slide:
    nbText: "## opsec"
    nbText: "what is the simplest nim program we can analyze"
    nbCode: 
      echo "hello uscg"
    nbClearOutput()
    nbText: "let's compile with:"
    nbText: "`nim c -d:release simple.nim`"

  slide:
    nbText: "main()"
    nbImage("../images/simple_main.png")
    nbImage("../images/simple_main_disasm.png")
  slide:
    nbText: "NimMain()"
    nbImage("../images/simple_nimmain.png")
  slide:
    nbText: "PreMainInner()"
    nbImage("../images/simple_premaininner.png")
  slide:
    nbText: "NimMainInner()"
    nbImage("../images/simple_nimmaininner.png")
  slide:
    nbText: "tldr:"
    nbText: """
    main -> 
      NimMain -> 
        PreMainInner (init libraries) -> 
          NimMainInner (main logic)
    """

# let's learn nim
slide:
  slide:
    nbText: "## learn nim in Y minutes"
  slide:
    nbText: "comments"
    nbCode:
      # single-line comment
      #[
        multi line comment 
        are put inside this
      ]#

      ## two are used for docstrings

      discard """
      discarding a string can work as a comment
      """
      echo "fin"
  
  slide: 
    nbText: "variables"
    nbCode:
      var letter: char = 'n'  # char are c-like in ''
      var
        lang = "N" & "im"     # str are in "", & concats
        nLen: int = len(lang) # : can declare type, w/o infers
        boat: float           # unassigned, but initialized 
        r_str = r"raw\string\"
        escaped = "escaped\t\\string"
      
      let legs = 400          # immutable
      let arms = 2_000        # visual separation

      const debug = true      # computed at compile 

      discard 1               # if not used, compiler complains
    
  slide:
    nbText: "variables (result)"
    nbCode:
      proc getAlphabet(): string =
        for letter in 'a' .. 'z':
          result.add(letter)
      echo getAlphabet()
    nbText: "result var is an implicit return variable"


  slide:
    nbText: "data structs"
    nbCode:
      # tuples
      var
        hacker: tuple[name: string, hacks:int]
      hacker = ("neo", 9000)  

      echo "Name: " & hacker.name
      echo "Hacks: " & $hacker.hacks   # type cast to str with $
  slide:
    nbText: "data structs (cont)"
    nbCode:
      # seqs 
      var langs: seq[string]
      langs = @["nim", "rust", "python"]
      langs.add("c")

      echo langs
      echo "langs size: " & $langs.len
      echo "idxes: " & $langs.low & "-" & $langs.high
  slide:
    nbText: "seq cont"
    nbCode:
      var seq2 = newSeq[int]()
      seq2.add(0)
      seq2.add(2)
      seq2.add(4)
      echo seq2
      echo seq2[^1]

  slide:
    nbText: "conditionals - python-like"
    nbCode:
      var conditional = 42
      if conditional < 0:
        echo "A"
      elif conditional > 0:
        echo "B"
      else:
        echo "C"

      var ternary = if conditional == 42: true else: false
      echo ternary
  slide:
    nbText: "conditionals - case"
    nbCode:
      var case_x = 5
      case case_x
      of 3:
        echo "3"
      of 5,10,15:
        echo "5"
      of 7,14,21:
        echo "7"
      else:
        echo "unknown"

  slide:
    nbText: "ranges / for loops"
    nbCode: 
      for i_idx in 0 .. 5:
        echo i_idx
      
      for j_idx in 0 ..< 5:
        echo j_idx
  slide:
    nbText: "more loop"
    nbCode:
      import strformat
      for i, letter in "uscg":
        echo &"letter {i} is {letter}"
  slide:
    nbText: "procs"
    nbText: """
    proc doSomething(s: string): string
      # does something and returns string
      # s is immutable
      return someString

    var s1 = "i'm a string"
    echo doSomething(s1)  
    """
  slide:
    nbText: "discard statement"
    nbText: """
    proc doStuff(x,y: int): int =
      ## does stuff, return result
    
    doStuff(1,2)          # fails to compile
    discard doStuff(1,2)  # compiles
    """
    nbText: "can add {.discardable.} pargma to be ignored implicitly"
  slide:
    nbText: "uniform function call syntax"
    nbText: """
    proc procName(arg1, arg2)

    # both valid
    procName(a, b)
    a.procName(b) 
    """
  slide:
    nbText: "type conversion"
    nbCode:
      var int1: int32 = 32.int32
      var int2: int8 = int8('a')
      var float1 = 2.5

  slide:
    nbText: "objects"
    nbCode:
      type
        Person = object 
          name: string
          age: int
      var p1 = Person(name:"Peter", age:30)
      echo p1.name

      var p2 = p1 # copy of p1
      p2.age += 100
      echo p2.age


  slide:
    nbText: "FFI (foreign function interface)"
    nbCode:
      proc strcmp(a, b: cstring): cint {.importc: "strcmp", nodecl.}
      proc printf(format: cstring): cint {.importc, varargs, header: "stdio.h".}
      let cmp = strcmp("C", "Nim")
      discard printf("Result of strcmp: %d", cmp) # doesn't print in slides

# compiling and using nimble
slide:
  slide:
    nbText: "## nimble and [compiler usage](https://nim-lang.org/docs/nimc.html)"
  slide:
    nbText: "nimble init -> create package"
    nbImage("../images/nimble.png")
  slide:
    nbText: "nimble install <package>"
  slide:
    nbText: "compiler usage"
  slide:
    nbText: "nim command [options] [projectfile] [arguments]"
    nbText: "nim c -r test.nim"
    nbText: "nim c -r -d:release test.nim"
    nbText: "nim js test.nim"
    nbText: "nim --thread:on threaded_proj.nim"
  slide:
    nbText: "--os:SYMBOL => cross compiliation"
    nbText: "--cpu:SYMBOL => cross compilation"
    nbText: "--mm:SYMBOL => memory management (gc)"
    nbText: "--opt:none|speed|size => optimize"
    nbText: "-d: => define switch"
    nbText: "to cross compile for windows: apt install mingw-w64 (or equivalent for pkgmgr)"
  slide:
    nbText: "config.nims file"
    nbText: """
    switch("d", "ssl")
    """
  slide:
    nbText: "generated c code dir"
    nbText: "$XDG_CACHE_HOME/nim/$projectname(_r|_d)"

# let's do some hackin
slide:
  slide:
    nbText: "## hacking"
    nbText: "just random things"

# web
slide:
  slide:
    nbText: "web"
  slide:
    nbText: "sending http request 1"
    nbCode:
      import std/httpclient
      # create a client
      var client = newHttpClient()
      # send get request
      echo client.getContent("https://example.com/")
      # close client
      client.close()  

  slide:
    nbText: "sending http request 2"
    nbCode:
      import std/httpclient
      var c2 = newHttpClient()
      # send request
      var resp = c2.request("https://example.com/",
                        httpMethod = HttpGet)
      c2.close()
      echo "Response status: " & resp.status
      echo "Response len: " & $resp.body.len 
      echo "Response headers: " & $resp.headers
  slide:
    nbText: "std/httpclient"
    nbText: "[documentation](https://nim-lang.org/docs/httpclient.html) is good reference for using httpclient."
  slide:
    nbText: "using [puppy](https://github.com/treeform/puppy)"
    nbCode:
      import puppy
      echo fetch("http://neverssl.com")
  slide:
    nbText: "puppy use2"
    nbCode:
      import puppy
      let req = Request(
        url: parseUrl("http://example.com"),
        verb: "get"
      )

      let pres = fetch(req)
      echo pres.code
      echo pres.body.len

# os
slide:
  slide:
    nbText: "os stuff"
  slide:
    nbText: "reading file"
    nbCode:
      let entireFile = readFile("./deliverables/txt_file1.txt")
      echo entireFile
  slide:
    nbText: """
    let f = open("cats.txt")
    defer: f.close()
    let fLine = f.readLine()
    """
  slide:
    nbText: "writing file"
    nbCode: 
      let text = "you can't eat cats kevin"
      writeFile("./deliverables/cats_kevin.txt", text)
      echo readFile("./deliverables/cats_kevin.txt")
  slide:
    nbText: """
    let lines = ["a", "b", "c", "d"]
    let f = open("cats.txt")
    defer: f.close()

    for line in lines:
      f.writeLine(line)
    """
  slide:
    nbText: "reading user input"
    nbText: """
    let name = readLine(stdin)
    let age = readLine(stdin).parseInt()
    """
  slide:
    nbText: "executing system cmds"
    nbCode:
      import std/[osproc]
      var (res, _) = execCmdEx("uptime")
      echo res
      var (res2, err) = execCmdEx("date")
      echo res2
  slide:
    nbText: "interacting with OS with:"
    nbText: "- [os](https://nim-lang.org/docs/os.html)"
    nbText: "- [osproc](https://nim-lang.org/docs/osproc.html)"
  slide:
    nbText: "pretty terminal output with:"
    nbText: "- [terminal](https://nim-lang.org/docs/terminal.html)"

  slide:
    nbText: "data conversion [#14810](https://github.com/nim-lang/Nim/issues/14810)"
    nbCode:
      proc toByteSeq*(str: string): seq[byte] {.inline.} =
        ## Converts a string to the corresponding byte sequence.
        @(str.toOpenArrayByte(0, str.high))

      proc toString*(bytes: openArray[byte]): string {.inline.} =
        ## Converts a byte sequence to the corresponding string.
        let length = bytes.len
        if length > 0:
          result = newString(length)
          copyMem(result.cstring, bytes[0].unsafeAddr, length)

  slide:
    nbText: "defining different code for different os at compile time"
    nbText: """
    when defined(windows):
      echo "I'd run on windows binary"
    when defined(linux):
      echo "I'd run on linux binary"
    """

# math
slide:
  slide:
    nbText: "math"
    
  slide: 
    nbText: "nim's std rng"
    nbCode:
      import std/random
      randomize() # init default rng, must be called
      let num = rand(100)
      echo num

  slide:
    nbText: "sysrand -> \"cryptographically secure\" rng"
    nbCode:
      import std/sysrand  
      echo urandom(5)
    
  slide:
    nbText: "not really math, but kinda math"
    nbCode:
      import std/base64
      let enc = encode("hello uscg")
      echo enc 

      let decoded = decode("SGVsbG8gV29ybGQ=")
      echo decoded == "Hello World"

      # url safe
      let u_enc = encode("safe_url_encoded", safe=true)
      echo u_enc
    

# python
slide:
  slide:
    nbText: "python interop"
  slide:
    nbText: "with [nimpy](https://github.com/yglukhov/nimpy), python can be called from within a nim program"
    nbCode:
      import nimpy
      import nimpy/py_lib
      pyInitLibPath "/usr/lib/x86_64-linux-gnu/libpython3.10.so.1.0"
      let sys = pyImport("sys")
      echo "Path: " & $sys.version
  slide:
    nbCode:
      import nimpy
      import nimpy/py_lib
      pyInitLibPath "/usr/lib/x86_64-linux-gnu/libpython3.10.so.1.0"

      let pwn = pyImport("pwn")
      discard pwn.context(arch="amd64", os="linux")
      var sc = pwn.asm(pwn.shellcraft.sh())
      echo sc
  slide:
    nbText: "nimpy an work both ways, can implement a python module in nim"
    nbText: "example of this is on nimpy's github"

# C
slide:
  slide:
    nbText: "c interop"
  slide:
    nbText: "with [c2nim](https://github.com/nim-lang/c2nim), ANSI C/Cpp code can be translated to nim."
    nbText: "preliminary meant to translate c header files"
    nbText: "this is cmdline tool"

# windows
slide:
  slide:
    nbText: "windows"
  slide:
    nbText: "there are a few libraries that make it easy to interact with the windows api. winim is one of the libraries."
    nbText: "winim contains API, struct, and constant definitions for nim"
  slide:
    nbText: "##### Messagebox"
    nbText: """
    import winim/lean

    MessageBox(0, "Title bar", "text for messagebox", 0)
    """
    nbText: "[MSDN - MessageBox function - winuser.h](https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-messagebox)"
  slide:
    nbText: "##### Enumerating procs"
    nbText: """
    proc findTarget(target: string): int =
      var pe32: PROCESSENTRY32W
      var hProcSnap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)
      if INVALID_HANDLE_VALUE == hProcSnap: return 0
      pe32.dwsize = sizeof(PROCESSENTRY32W).DWORD
      if Process32First(hProcSnap, pe32):
        while Process32Next(hProcSnap, pe32):
          if target in $$pe32.szExeFile:
            CloseHandle(hProcSnap)
            return pe32.th32ProcessID
      CloseHandle(hProcSnap)
      return 0
    """
  slide:
    nbText: "let's do process injection"
    nbText: "windows demo"
    nbText: ""
  slide:
    nbText: "interacting with windows registry"
    nbText: "[std/registry](https://nim-lang.org/docs/registry.html) allows access to get and set unicode values. "
    nbText: "[nim-registry](https://github.com/miere43/nim-registry) nimble package that deals with windows registry"
    

# resources
slide:
  slide:
    nbText: "## Resources"
  slide:
    nbText: "[nim documentation](https://nim-lang.org/documentation.html)"
    nbText: "[nim-by-example](https://nim-by-example.github.io/)"
    nbText: "\n"
    nbText: "[curated packages](https://github.com/nim-lang/Nim/wiki/Curated-Packages) (bit outdated)"
    nbText: "[awesome-nim](https://github.com/ringabout/awesome-nim)"
    nbText: "[official nimble.directory](https://nimble.directory/)"
    nbText: "nim community discord and irc server"
  slide:
    nbText: "[nim for python programmers](https://github.com/nim-lang/Nim/wiki/Nim-for-Python-Programmers)"
    nbText: "[nim on rosettacode](https://rosettacode.org/wiki/Category:Nim)"
  slide:
    nbText: "some personal favorite packages:"
    nbText: "- [nim-terminaltables](https://github.com/xmonader/nim-terminaltables)"
    nbText: "- [nim-argparse](https://github.com/iffy/nim-argparse)"
    nbText: "- [OffensiveNim 🐐👑](https://github.com/byt3bl33d3r/OffensiveNim)"
    nbText: "- [morelogging](https://github.com/FedericoCeratto/nim-morelogging)"


nbSave()