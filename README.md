# Mica: Automated Differential Testing for OCaml Modules 

[![OCaml-CI Build Status](https://img.shields.io/endpoint?url=https://ocaml.ci.dev/badge/ngernest/mica/main&logo=ocaml&style=for-the-badge)](https://ocaml.ci.dev/github/ngernest/mica) 
[![view - Documentation](https://img.shields.io/badge/view-Documentation-blue?style=for-the-badge)](https://ngernest.github.io/mica/mica/index.html)

(Submitted to the [ICFP '23 Student Research Competition](https://icfp23.sigplan.org/track/icfp-2023-student-research-competition))

**Mica** checks whether two OCaml modules implementing the same signature are observationally 
equivalent. Mica does this by parsing the signature & *automatically* generating 
property-based testing (PBT) code specialised to the signature.

ICFP SRC documents:              
- [Extended Abstract](./talks/icfp_src_abstract.pdf) 
- Poster (to come!)
- Talk (to come!)

Presentation slides on Mica:                 
- [Penn PLClub talk](./talks/mica_plclub_talk.pdf) (~45 mins) 
- [OPLSS '23 talk](./talks/mica_oplss_slides.pdf) (~10 mins)
        
## Description of source files 
Core components of Mica:
- [`Parser.ml`](./lib/Parser.ml): parser utility functions, modified from the Angstrom parser-combinator library
- [`ParserTypes.ml`](./lib/ParserTypes.ml): Datatypes defining an AST for OCaml module signatures
- [`ModuleParser.ml`](./lib/ModuleParser.ml): Parser for OCaml module signatures
- [`CodeGenerator.ml`](./lib/CodeGenerator.ml): Takes a parsed AST representing a module signature & generates specialized PBT code 
- [`CmdLineParser.ml`](./lib/CmdLineParser.ml): Parses user input from the command line

Auxiliary utility files:
- [`Utils.ml`](./lib/Utils.ml): Utility functions for the code generator
- [`Stats.ml`](./lib/Stats.ml): Functions for examining the distribution of randomly generated symbolic expressions
- [`Latin.ml`](./lib/Latin.ml): QuickCheck generator for Latin words (taken from [Lorem Ipsum](https://en.wikipedia.org/wiki/Lorem_ipsum) placeholder text)

Executables (located in [`bin`](./bin)):
- [`Main.ml`](./bin/main.ml): Entry point for the Mica executable
- [`Benchmark.ml`](./bin/benchmark.ml): Runs performance benchmarks on Mica and the auto-generated PBT executables

## Examples 
The `lib` directory also contains five example module signatures, 
each of which has two different implementations. Mica has been tested
extensively with these five pairs of modules. 

The code for these example modules has been adapted from various sources, 
listed in the [references](#references) section of this README.

**1. Finite Sets** (Lists & BSTs)
  - Signature: [`SetInterface.ml`](./lib/sets/SetInterface.ml)
  - List implementation: [`ListSet.ml`](./lib/sets/ListSet.ml)
  - BST implementation: [`BSTSet.ml`](./lib/sets/BSTSet.ml)

**2. Regex matchers** ([Brzozowski derivatives](https://en.wikipedia.org/wiki/Lorem_ipsum) & DFAs)
  - Signature: [`RegexMatcher.mli`](./lib/regexes/RegexMatcher.mli) (Commented version: [`RegexMatcher.ml`](./lib/regexes/RegexMatcher.ml))
  - Brzozowski derivatives: [`Brzozowski.ml`](./lib/regexes/Brzozowski.ml)
  - DFAs: [`DFA.ml`](./lib/regexes/DFA.ml)

**3. Polynomials** ([Horner schema](https://en.wikipedia.org/wiki/Horner%27s_method) & list folds)
  - Signature: [`PolyInterface.ml`](./lib/polynomials/PolyInterface.ml)
  - Polynomial evaluation using list folds: [`Poly1.ml`](./lib/polynomials/Poly1.ml) 
  - Polynomial evaluation using Horner's algorithm: [`Poly2.ml`]((./lib/polynomials/Poly2.ml))

**4. Functional Maps** (Association lists & Red-black trees)
  - Signature: [`MapInterface.ml`](./lib/maps/MapInterface.ml) (Commented version: [`MapInterface.mli`](./lib/maps/MapInterface.mli))
  - Association lists: [`AssocListMap.ml`](./lib/maps/AssocListMap.ml)
    - See [`AssocList.ml`](./lib/maps/AssocList.ml) for the definition of the `AssocList` type & its QuickCheck generator
  - Red-Black tree maps: [`RedBlackMap.ml`](./lib/maps/RedBlackMap.ml)

**5. Stacks** (List & algebraic data type representations)
  - Signature: [`StackInterface.ml`](./lib/stacks/StackInterface.ml)
  - Implementation using lists: [`ListStack.ml`](./lib/stacks/ListStack.ml)
  - Implementation using custom ADT: [`VariantStack.ml`](./lib/stacks/VariantStack.ml)

## Building & running
Run `make` (or `dune build`) to build and compile the library.         
Run `make install` to install dependencies. 

**Usage**:       
```
dune exec -- bin/main.exe [.ml file containing signature] [.ml file containing 1st module] [.ml file containing 2nd module]
```
This command runs Mica and creates two new files:
1. `lib/Generated.ml` (contains PBT code for testing an OCaml module)
2. `bin/compare_impls.ml` (code for an executable that tests two modules for observational equivalence)

To run the generated executable, run `dune exec -- bin/compare_impls.exe`. 

### Example (finite sets)
```
  dune exec -- bin/main.exe lib/sets/SetInterface.ml lib/sets/ListSet.ml lib/sets/BSTSet.ml
```
This runs Mica on the Set example above, checking if the `ListSet` and `BSTSet` modules 
both correctly implement the interface `SetInterface`.       
The files `lib/GeneratedSetPBTCode.ml` and `lib/GeneratedSetExecutable.ml` contain PBT code that is 
automatically generated by Mica. 

### Dependencies
Please see `mica.opam` for a full list of dependencies. 
Mica has been primarily tested with version 4.13.1 of the OCaml base compiler. 
- [Base](https://github.com/janestreet/base) & [Base_quickcheck](https://github.com/janestreet/base_quickcheck)
- [Core](https://github.com/janestreet/core) & [Core.Quickcheck](https://blog.janestreet.com/quickcheck-for-core/))
- [Angstrom](https://github.com/inhabitedtype/angstrom)
- [PPrint](https://github.com/fpottier/pprint)
- [Stdio](https://github.com/janestreet/stdio)
- [Re](https://github.com/ocaml/ocaml-re)
- [Odoc](https://github.com/ocaml/ocaml-re) (for generating documentation)
- [Core_bench](https://github.com/janestreet/core_bench) (for running benchmarks)
- [OCaml-CI](https://github.com/ocurrent/ocaml-ci) (for CI)

## Acknowledgements
I'm incredibly fortunate to have two fantastic advisors: [Harry Goldstein](https://harrisongoldste.in) & Prof. [Benjamin Pierce](https://www.cis.upenn.edu/~bcpierce/). Harry & Benjamin have 
provided lots of useful feedback on the design of Mica, and I'm extremely grateful for 
their mentorship. 

I'd also like to thank:
- Penn's [PLClub](https://www.cis.upenn.edu/~plclub/) for their feedback on my presentation slides
- [Jan Midtggard](http://janmidtgaard.dk) (Tarides) & Carl Eastlund (Jane Street) for answering 
my questions about QCSTM and Core.Quickcheck
- [Cassia Torczon](https://cassiatorczon.github.io) for the idea behind the name Mica


## Origin of name
Mica stands for "Module-Implementation Comparison Automation". Mica is also a type
[mineral](https://en.wikipedia.org/wiki/Mica) commonly found in rocks -- this name was inspired 
by several relevant OCaml libraries that are also named after stones/rocks:         
- [Monolith](https://gitlab.inria.fr/fpottier/monolith) (Randomised testing tool for OCaml modules)
- [Opal](https://github.com/pyrocat101/opal) (parser combinator library)
- [Menhir](http://gallium.inria.fr/~fpottier/menhir/) (parser library)
- [Obelisk](https://github.com/Lelio-Brun/Obelisk) (pretty-printer for Menhir)

## References
- Jane Street's [Base_quickcheck](https://opensource.janestreet.com/base_quickcheck/) & [Core.Quickcheck](https://blog.janestreet.com/quickcheck-for-core/)
- [QuviQ QuickCheck](https://dl.acm.org/doi/10.1145/1159789.1159792)
- [QCSTM](https://github.com/jmid/qcstm)   
- [Model_quickcheck](https://github.com/suttonshire/model_quickcheck)
- [Monolith](https://gitlab.inria.fr/fpottier/monolith)
- [Articheck](http://www.lix.polytechnique.fr/Labo/Gabriel.Scherer/doc/articheck-long.pdf)
- [*Advanced Topics in Types & Programming Languages*](https://www.cis.upenn.edu/~bcpierce/attapl/), Chapter 8
- [*Real World OCaml*](https://dev.realworldocaml.org/index.html)

The code for the example modules has been adapted from the following sources:

Finite Sets:
- [Cornell CS 3110 OCaml textbook](https://cs3110.github.io/textbook/chapters/ds/hash_tables.html#maps-as-hash-tables)
- [Penn CIS 1200 lecture notes](https://www.seas.upenn.edu/~cis120/23su/files/120notes.pdf#page=3)
- [Yale-NUS YSC2229 website](https://ilyasergey.net/YSC2229/week-11-bst.html)         

Regex matchers:
- Harry Goldstein's [livestream](https://www.youtube.com/watch?v=QaMU0wMMczU&t=2199s) on regex derivatives & DFAs

Polynomials:
- [Jean-Christophe Filliatre's implementation](https://www.lri.fr/~filliatr/ftp/ocaml/ds/poly.ml.html)
- [Shayne Fletcher's implementation](https://blog.shaynefletcher.org/2017/03/polynomials-over-rings.html)

Functional maps:  
- [Colin Shaw's RB tree implementation](https://github.com/CompScienceClub/ocaml-red-black-trees)
- [Benedikt Meurer RB tree implementation](https://github.com/bmeurer/ocaml-rbtrees/blob/master/src/rbset.ml)
- [Cornell CS 3110 textbook, chapter 8](https://cs3110.github.io/textbook/chapters/ds/rb.html#id1)            
- The implementation of red-black tree deletion follows the approach taken by 
[Germane & Might (2014)](https://matt.might.net/papers/germane2014deletion.pdf).

Stacks:
- [Cornell CS 3110 textbook, chapter 5](https://cs3110.github.io/textbook/chapters/modules/functional_data_structures.html#stacks)
