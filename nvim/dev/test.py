from time import sleep
from pynvim import attach, api

nvim = attach(
    "socket",
    path="/var/folders/1h/kgcwlsr94n19h3p_st4dgsy80000gn/T/nvim.brian/zELJ7f/nvim.28224.0",
)

nvim.command('echo "hello world!"')

# buffer = nvim.current.buffer
# print(buffer)

# event = api.nvim.Nvim.from_nvim(nvim)  # use the loaded nvim session
# listen = event.subscribe(
#     "TextChangedI"
# )  # refer to events https://neovim.io/doc/user/autocmd.html#events
#
# while True:
#     sleep(2)
#     print(listen)
#     # read and print contents of the whole buffer
#     for line in range(len(buffer)):
#         print(buffer[line])
