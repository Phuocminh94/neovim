return {
  settings = {
    pylsp = {
      plugins = {
        autopep8 = { enabled = false },
        flake8 = { enabled = false },
        mccabe = { enabled = false },
        pycodestyle = { enabled = false, ignore = { "W391" } },
        pyflakes = { enabled = false },
        pylint = { enabled = false },
      },
    },
  },
}
