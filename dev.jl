using Pkg; Pkg.activate(".")
using Toolips
using Revise
using DefaultsTester

IP = "127.0.0.1"
PORT = 8000
DefaultsTesterServer = DefaultsTester.start(IP, PORT)
