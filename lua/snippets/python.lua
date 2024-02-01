local ls = require "snippets"
c = ls.c
fmt = ls.fmt
i = ls.i
s = ls.s

return {
  s(
    "im",
    c(1, {
      fmt("import {} as {}", { i(1), i(2) }),
      fmt("from {} import {} as {}", { i(1), i(2), i(3) }),
      fmt("from {} import {}", { i(1), i(2) }),
      fmt("import {}", { i(1) }),
      fmt("from {} import *", { i(1) }),
    })
  )
}
