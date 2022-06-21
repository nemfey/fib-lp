from antlr4 import *
from jsbachLexer import jsbachLexer
from jsbachParser import jsbachParser
from TreeVisitor import TreeVisitor
import playsound
import sys
import os


filename, extension = os.path.splitext(sys.argv[1])

if extension != '.jsb':
    raise Exception('Error. Format file not accepted, try with jsb files!')

input_stream = FileStream(filename+extension, encoding="utf-8")

lexer = jsbachLexer(input_stream)
token_stream = CommonTokenStream(lexer)
parser = jsbachParser(token_stream)
tree = parser.root()

if len(sys.argv) == 2:
    visitor = TreeVisitor()
elif len(sys.argv) == 3:
    visitor = TreeVisitor(sys.argv[2])
else:
    args = []
    for arg in sys.argv[3:]:
        args.append(int(arg))
    visitor = TreeVisitor(sys.argv[2], args)

visitor.visit(tree)

##### Execution finished, now we generate Lilypond and other files #####

musicnotes = visitor.getMusicsheet()
if musicnotes:
    musicsheet = ' '.join(map(str, musicnotes))

    f = open(filename+".lily", "w")
    f.write("""\\version "2.20.0"
    \\score {
        \\absolute {
            \\tempo 4 = 120
            """)

    f.write(musicsheet)

    f.write("""    }
        \\layout { }
        \\midi { }
    }""")

    f.close()

    os.system("lilypond "+filename+".lily")
    os.system("timidity -Ow -o "+filename+".wav "+filename+".midi")
    os.system("ffmpeg -i "+filename+".wav -codec:a libmp3lame -qscale:a 2 "+filename+".mp3")

    ##### Let's dislpay the music also! #####
    playsound.playsound(filename+".mp3")
