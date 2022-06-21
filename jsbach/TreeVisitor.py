from copy import deepcopy

if __name__ is not None and "." in __name__:
    from .jsbachParser import jsbachParser
    from .jsbachVisitor import jsbachVisitor
else:
    from jsbachParser import jsbachParser
    from jsbachVisitor import jsbachVisitor


def add(x, y): return x + y
def sub(x, y): return x - y
def mult(x, y): return x * y


def div(x, y):
    if y == 0:
        raise Exception('Error. Trying to divide a number by 0!')
    else:
        return x // y


def pow(x, y): return x ** y
def mod(x, y): return x % y


def less(x, y): return int(x < y)
def lessequal(x, y): return int(x <= y)
def great(x, y): return int(x > y)
def greatequal(x, y): return int(x >= y)
def equal(x, y): return int(x == y)
def notequal(x, y): return int(x != y)


operations = {'+': add, '-': sub, '*': mult, '/': div, '^': pow, '%': mod,
              '<': less, '<=': lessequal, '>': great, '>=': greatequal, '=': equal, '/=': notequal}

note2number = {'A0': 0,  'B0': 1,
               'C1': 2,  'D1': 3,    'E1': 4,    'F1': 5,    'G1': 6,    'A1': 7,    'B1': 8,
               'C2': 9,  'D2': 10,   'E2': 11,   'F2': 12,   'G2': 13,   'A2': 14,   'B2': 15,
               'C3': 16, 'D3': 17,   'E3': 18,   'F3': 19,   'G3': 20,   'A3': 21,   'B3': 22,
               'C': 23,  'D': 24,    'E': 25,    'F': 26,    'G': 27,    'A': 28,    'B': 29,
               'C4': 23, 'D4': 24,   'E4': 25,   'F4': 26,   'G4': 27,   'A4': 27,   'B4': 29,
               'C5': 30, 'D5': 31,   'E5': 32,   'F5': 33,   'G5': 34,   'A5': 35,   'B5': 36,
               'C6': 37, 'D6': 38,   'E6': 39,   'F6': 40,   'G6': 41,   'A6': 42,   'B6': 43,
               'C7': 44, 'D7': 45,   'E7': 46,   'F7': 47,   'G7': 48,   'A7': 49,   'B7': 50,
               'C8': 51}

number2lilypond = {'0': "a,,,",  '1': "b,,,",
                   '2': "c,,",   '3': "d,,",     '4': "e,,",    '5': "f,,",     '6': "g,,",     '7': "a,,",     '8': "b,,",
                   '9': "c,",    '10': "d,",     '11': "e,",    '12': "f,",     '13': "g,",     '14': "a,",     '15': "b,",
                   '16': "c",    '17': "d",      '18': "e",     '19': "f",      '20': "g",      '21': "a",      '22': "b",
                   '23': "c'",   '24': "d'",     '25': "e'",    '26': "f'",     '27': "g'",     '28': "a'",     '29': "b'",
                   '30': "c''",  '31': "d''",    '32': "e''",   '33': "f''",    '34': "g''",    '35': "a''",    '36': "b''",
                   '37': "c'''", '38': "d'''",   '39': "e'''",  '40': "f'''",   '41': "g'''",   '42': "a'''",   '43': "b'''",
                   '44': "c''''", '45': "d''''", '46': "e''''", '47': "f''''",  '48': "g''''",  '49': "a''''",  '50': "b''''",
                   '51': "c'''''"}


class Function:
    def __init__(self, name, arguments, block):
        self.name = name            # function name
        self.arguments = arguments  # arguments
        self.block = block          # instrutions


class TreeVisitor(jsbachVisitor):
    def __init__(self, name='Main', arguments=[]):
        self.arguments = arguments
        self.name = name

        self.functions = {}
        self.context = []
        self.musicsheet = []

    def visitRoot(self, ctx):
        l = list(ctx.getChildren())
        for f in l:
            self.visit(f)
        self.executeFunction(self.name, self.arguments)

    def visitFunction(self, ctx):
        l = list(ctx.getChildren())
        name = l[0].getText()
        if name in self.functions:
            raise Exception('Error. Duplicated name of function!')
        arguments = []
        for i in range(1, len(l)-3):
            arguments.append(l[i].getText())
        self.functions[name] = Function(name, arguments, ctx.block())

    def visitExpression(self, ctx):
        l = list(ctx.getChildren())
        if len(l) == 1:
            return self.visit(l[0])
        else:  # len(l) == 3
            if(l[0].getText() == '(' and l[2].getText() == ')'):
                return self.visit(l[1])
            else:
                op = operations[l[1].getText()]
                return op(self.visit(l[0]), self.visit(l[2]))

    def visitWhilecondition(self, ctx):
        l = list(ctx.getChildren())
        while(self.visit(l[1])):
            for i in range(3, len(l)-1):
                self.visit(l[i])

    def visitIfcondition(self, ctx):
        l = list(ctx.getChildren())
        if(self.visit(l[1])):
            self.visit(l[3])
        elif(len(l) == 6):
            self.visit(l[5])

    def visitElsecondition(self, ctx):
        l = list(ctx.getChildren())
        self.visit(l[2])

    def visitCondition(self, ctx):
        l = list(ctx.getChildren())
        op = operations[l[1].getText()]
        return op(self.visit(l[0]), self.visit(l[2]))

    def visitCallfunction(self, ctx):
        l = list(ctx.getChildren())
        arguments = []
        for i in range(1, len(l)):
            arguments.append(self.visit(l[i]))
        self.executeFunction(l[0].getText(), arguments)

    def visitAssignation(self, ctx):
        l = list(ctx.getChildren())
        value = self.visit(l[2])
        self.context[-1][l[0].getText()] = deepcopy(value)

    def visitRead(self, ctx):
        l = list(ctx.getChildren())
        value = int(input())
        self.context[-1][l[1].getText()] = value

    def visitWrite(self, ctx):
        l = list(ctx.getChildren())
        for i in range(1, len(l)):
            elem = self.visit(l[i])
            if(isinstance(elem, list)):
                print('[' + ' '.join(str(x) for x in elem) + ']', end=" ")
            else:
                print(elem, end=" ")
        print("\r")

    def visitReproduce(self, ctx):
        l = list(ctx.getChildren())
        newmusic = self.visit(l[1])
        if isinstance(newmusic, list):
            for note in newmusic:
                self.musicsheet.append(note)
        else:
            self.musicsheet.append(newmusic)

    def visitCreatelist(self, ctx):
        l = list(ctx.getChildren())
        self.context[-1][l[0].getText()] = self.visit(l[2])

    def visitGetfromlist(self, ctx):
        l = list(ctx.getChildren())
        index = self.visit(l[2])
        if index > len(self.context[-1][l[0].getText()]):
            raise Exception('Error. Index out of possible range!')
        return self.context[-1][l[0].getText()][index-1]

    def visitAddtolist(self, ctx):
        l = list(ctx.getChildren())
        elem = self.visit(l[2])
        self.context[-1][l[0].getText()].append(elem)

    def visitLengthlist(self, ctx):
        l = list(ctx.getChildren())
        return len(self.context[-1][l[1].getText()])

    def visitRemovefromlist(self, ctx):
        l = list(ctx.getChildren())
        index = self.visit(l[3]) - 1    # -1 porque el primer indice es 1
        self.context[-1][l[1].getText()].pop(index)

    def visitSinglelist(self, ctx):
        l = list(ctx.getChildren())
        newlist = []
        for i in range(1, len(l)-1):
            newlist.append(self.visit(l[i]))
        return newlist

    def visitVar(self, ctx):
        l = list(ctx.getChildren())
        result = l[0].getText()
        if result in self.context[-1]:
            return self.context[-1][result]
        else:
            return 0

    def visitNum(self, ctx):
        l = list(ctx.getChildren())
        result = l[0].getText()
        return int(result)

    def visitString(self, ctx):
        l = list(ctx.getChildren())
        return l[0].getText()[1:-1]

    def visitNote(self, ctx):
        l = list(ctx.getChildren())
        note = l[0].getText()
        if not note in note2number:
            raise Exception('Error. Note declared does not exist in JSBach!')
        return note2number[l[0].getText()]

    ########## AUXILIAR FUNCTIONS ##########

    def executeFunction(self, name, args):
        if name not in self.functions:
            raise Exception('Error. Function name does not exist!')
        elif len(args) != len(self.functions[name].arguments):
            raise Exception('Error. Number of arguments not what expected!')

        variables = {}
        for i in range(0, len(args)):
            argumentId = self.functions[name].arguments[i]
            variables[argumentId] = args[i]
        self.context.append(variables)
        self.visit(self.functions[name].block)
        self.context.pop(-1)

    def getMusicsheet(self):
        lilymusichseet = []
        for note in self.musicsheet:
            lilymusichseet.append(number2lilypond[str(note)])
        return lilymusichseet
