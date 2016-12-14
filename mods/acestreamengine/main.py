import sys

from acestreamengine import Core

params = sys.argv[:]
params.append('--client-console')

Core.run(params)

