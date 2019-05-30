# linc_sys

Allows getting thread id (SPID) from [Haxe](https://www.haxe.org) on Linux cpp target. The library has a more general name, so later features may be added in necessary.

`Sys.gettid() : Int` returns the thread id (SPID) from the current thrad.

## How to install

You just need to `haxelib git` this repo, and target CPP with a `-lib linc_sys`.

Thanks to [Linc](http://snowkit.github.io/linc/).
