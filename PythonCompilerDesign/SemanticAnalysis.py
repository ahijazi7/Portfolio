# -------------------------------------------------------------------------
# hw3-starter.py: Starter code for DLang Semantic Analyzer
# Run with source file 
# -------------------------------------------------------------------------
import sys
from sly import Lexer, Parser
import traceback

class SymbolTable:

    def __init__(self):
        self.table = []

    def add_name(self, name):
        '''Insert a new identified to the symbol table'''
        new_entry = {}
        new_entry['name'] = name
        self.table.append(new_entry)

    def add_type(self, name, typee):
        '''Insert type of an identifier to the symbol table'''
        for i in range(len(self.table)):
            if self.table[i]['name'] == name:
                self.table[i]['type'] = typee

    def add_formals(self, name, formalVar):
        '''Insert formals (parameters) of a function to the symbol table'''
        for i in range(len(self.table)):
            if self.table[i]['name'] == name:
                if 'formals' in self.table[i].keys():
                    self.table[i]['formals'].append(formalVar)
                else:
                    self.table[i]['formals'] = []
                    self.table[i]['formals'].append(formalVar)

    def get_formals(self, symbol):
        '''Get formals of a function symbol'''
        for elt in self.table:
            if elt['name'] == symbol:
                if 'formals' in elt.keys():
                    return elt['formals']
        return []  # symbol not found or formals not found

    def insert_value(self, name, value):
        '''Insert a value of symbol to the symbol table'''
        for i in range(len(self.table)):
            if self.table[i]['name'] == name:
                self.table[i]['value'] = value

    def lookup_name(self, name):
        '''Check whether an idenfifier name exists in symbol table'''
        for elt in self.table:
            if elt['name'] == name:
                return 1
        return 0

    def get_type(self, symbol):
        '''Get the type of a symbol'''
        for elt in self.table:
            if elt['name'] == symbol:
                if 'type' in elt.keys():
                    return elt['type']
        return 0  # symbol not found

    def get_value(self, symbol, typee):
        '''Get the type of a symbol'''
        for elt in self.table:
            if elt['name'] == symbol and elt['type'] == typee:
                return elt['value']
        return 0  # symbol is not found


# global object that instantiates symbol table: use this to insert, get, loookup, ...
tab = SymbolTable()


class DLangLexer(Lexer):
    # Define names of tokens
    tokens = {LE, GE, EQ, NE, AND, OR, INT, DOUBLE, STRING, IDENTIFIER, NOTHING, INTK, DOUBLEK, BOOL, BOOLK, STRINGK,
              NULL, FOR, WHILE, IF, ELSE, RETURN, BREAK, OUTPUT, INPUTINT, INPUTLINE}

    # Single-character literals can be recognized without token names
    # If you use separate tokens for each literal, that is fine too
    literals = {'+', '-', '*', '/', '%', '<', '>', '=', '!', ';', ',', '.', '[', ']', '(', ')', '{', '}'}

    # Specify things to ignore
    ignore = ' \t\r'  # space, tab, and carriage return
    ignore_comment1 = r'\/\*[^"]*\*\/'  # c-style multi-line comment (note: test with input from file)
    ignore_comment = r'\/\/.*'  # single line comment
    ignore_newline = r'\n+'  # end of line

    # Specify REs for each token
    STRING = r'\"(.)*\"'
    DOUBLE = r'[0-9]+\.[0-9]*([E][+-]?\d+)?'
    INT = r'[0-9]+'
    EQ = r'=='
    NE = r'!='
    LE = r'<='
    GE = r'>='
    AND = r'&&'
    OR = r'\|\|'
    IDENTIFIER = r'[a-zA-Z_][a-zA-Z0-9_]{0,39}'
    # IDENTIFIER lexemes overlap with keywords.
    # To avoid confusion, we do token remaping.
    # Alternatively, you can specify each keyword before IDENTIFIER
    IDENTIFIER['nothing'] = NOTHING
    IDENTIFIER['int'] = INTK
    IDENTIFIER['double'] = DOUBLEK
    IDENTIFIER['string'] = STRINGK
    IDENTIFIER['bool'] = BOOLK
    IDENTIFIER['True'] = BOOL
    IDENTIFIER['False'] = BOOL
    IDENTIFIER['null'] = NULL
    IDENTIFIER['for'] = FOR
    IDENTIFIER['while'] = WHILE
    IDENTIFIER['if'] = IF
    IDENTIFIER['else'] = ELSE
    IDENTIFIER['return'] = RETURN
    IDENTIFIER['break'] = BREAK
    IDENTIFIER['Output'] = OUTPUT
    IDENTIFIER['InputInt'] = INPUTINT
    IDENTIFIER['InputLine'] = INPUTLINE

    def error(self, t):
        print("Invalid character '%s'" % t.value[0])
        self.index += 1

semanticErrorOccured = False

class DLangParser(Parser):
    # Parser log file
    debugfile = 'dlang-parser.log'

    # Fetch tokens from the lexer
    tokens = DLangLexer.tokens

    # Set operator preceedence
    precedence = (
        ('nonassoc', EQ, NE, LE, GE, AND, OR, '<', '>'),
        ('left', '+', '-'),
        ('left', '*', '/', '%'),
        ('nonassoc', '=')
    )

    

    def __init__(self):
        self.IDENTIFIERs = {}
        

    def semantic_error(self, msg):
        global semanticErrorOccured 
        semanticErrorOccured = True
        print('\n Semantic Error:', msg)

    # Program ->Decl+
    @_('Decl DeclRest', 'Epsilon')
    def Program(self, p):
        

        print('\n Parsing completed Successfully!\n')
        return p

    @_('Decl DeclRest', 'Epsilon')
    def DeclRest(self, p):
        return p

    # Decl ->VariableDecl
    @_('VariableDecl')
    def Decl(self, p):
        return p

    # Decl ->Stmt
    @_('Stmt')
    def Decl(self, p):
        return p

    # Decl -> FunctionDecl
    @_('FunctionDecl')
    def Decl(self, p):
        return p

    @_(' Variable ";" ')
    def VariableDecl(self, p):
        return p

    @_('Type IDENTIFIER')
    def Variable(self, p):
        if tab.get_type(p.IDENTIFIER) == 0:
            tab.add_name(p.IDENTIFIER)
            tab.add_type(p.IDENTIFIER, p.Type)
        else:
            self.semantic_error(f"Variable '{p.IDENTIFIER}' already declared.")
        return p

    @_('INTK', 'DOUBLEK', 'BOOLK', 'STRINGK')
    def Type(self, p):
        return p

    # FunctionDecl -> Type ident ( Formals ) StmtBlock
    @_('Type IDENTIFIER "(" Formals ")" StmtBlock')
    def FunctionDecl(self, p):
        if tab.get_type(p.IDENTIFIER) == 0:     
            tab.add_name(p.IDENTIFIER)
            tab.add_type(p.IDENTIFIER, p.Type)
            tab.add_formals(p.IDENTIFIER, p.Formals)
        else:
            self.semantic_error(f"Function '{p.IDENTIFIER}' already declared.")
        return p

    # FunctionDecl -> nothing ident ( Formals ) StmtBlock
    @_('NOTHING IDENTIFIER "(" Formals ")" StmtBlock')
    def FunctionDecl(self, p):
        return p

    # Formals -> Variable+,|ε
    @_('Variable VariableRest', 'Epsilon')
    def Formals(self, p):
        return p

    @_(' "," Variable VariableRest', 'Epsilon')
    def VariableRest(self, p):
        return p

    @_('"{" "}"', ' "{" VariableDecl "}" ', ' "{" VariableDecl VariableDeclRest "}" ', ' "{" Stmt "}" ',
       ' "{" Stmt StmtRest "}" ', ' "{" VariableDecl VariableDeclRest Stmt StmtRest  "}" ')
    def StmtBlock(self, p):
        return p

    @_('VariableDecl VariableDeclRest', 'Epsilon')
    def VariableDeclRest(self, p):
        return p

    @_('Stmt StmtRest', 'Epsilon')
    def StmtRest(self, p):
        return p

        # Stmt can be many things

    @_('Expr ";" ', ' ";" ', 'IfStmt', 'WhileStmt', 'ForStmt', 'BreakStmt', 'ReturnStmt', 'OutputStmt', 'StmtBlock')
    def Stmt(self, p):
        return p

    # if ( Expr ) Stmt <else Stmt>
    @_('IF "(" Expr ")" Stmt IfRest')
    def IfStmt(self, p):
        return p

    @_('ELSE Stmt', 'Epsilon')
    def IfRest(self, p):
        return p

    # while ( Expr ) Stmt
    @_('WHILE "(" Expr ")" Stmt')
    def WhileStmt(self, p):
        return p

    # for ( <Expr> ; Expr ; <Expr> ) Stmt
    @_('FOR "(" Expr ";" Expr ";" Expr ")" Stmt')
    def ForStmt(self, p):
        return p

        # return <Expr> ;

    @_('RETURN Expr ";" ', 'RETURN ";"')
    def ReturnStmt(self, p):
        return p

    # break ;
    @_('BREAK ";" ')
    def BreakStmt(self, p):
        print('BreakStmt')
        return p

    # Output ( Expr+, ) ;
    @_('OUTPUT "(" Expr ExprRest ")" ";" ')
    def OutputStmt(self, p):
        return p

    @_(' "," Expr ExprRest', 'Epsilon')
    def ExprRest(self, p):
        return p

    @_('"!" Expr', 'IDENTIFIER', 'Constant', 'Call', ' "("  Expr ")" ', '"-" Expr', 'INPUTINT "(" ")"',
       'INPUTLINE "(" ")"')
    def Expr(self, p):
        return p


    @_('Expr "+" Expr', 'Expr "-" Expr', 'Expr "*" Expr', 'Expr "/" Expr', 'Expr "%" Expr', 'Expr "<" Expr',
       'Expr LE Expr', 'Expr ">" Expr', 'Expr GE Expr', 'Expr EQ Expr', 'Expr  NE Expr', 'Expr AND Expr',
       'Expr OR Expr')
    def Expr(self, p):
        
        #get expr types
        p0 = tab.get_type(p.Expr0[1])
        p1 = tab.get_type(p.Expr1[1])

        if p0 != p1:
             self.semantic_error(f"Operands '{p.Expr0[1]}' and '{p.Expr1[1]}' are incompatable/unsafe to typecast.")
        
        return p

    @_('IDENTIFIER "=" Expr')
    def Expr(self, p):
        if tab.get_type(p.IDENTIFIER) == 0:
            self.semantic_error(f"Variable '{p.IDENTIFIER}' not declared.")
        else:
            tab.insert_value(p.IDENTIFIER, p.Expr)
        return p

    @_('IDENTIFIER "(" Actuals ")"')
    def Call(self, p):
        if tab.lookup_name(p.IDENTIFIER) == 1:
            formals = tab.get_formals(p.IDENTIFIER)
            if len(formals) != len(p.Actuals):
                self.semantic_error(f"Function '{p.IDENTIFIER}' called with wrong number of arguments.")
        else:
            self.semantic_error(f"Function '{p.IDENTIFIER}' not declared.")
        return p

    # Expr+, |ε
    @_('Expr ExprRest1', 'Epsilon')
    def Actuals(self, p):
        return p

    @_(' "," Expr ExprRest1', 'Epsilon')
    def ExprRest1(self, p):
        return p

    @_('INT', 'DOUBLE', 'BOOL', 'STRING', 'NULL')
    def Constant(self, p):
        return p

    # Empty production
    @_('')
    def Epsilon(self, p):
        pass

    # identifier
    @_('IDENTIFIER')
    def Decl(self, p):
        try:
            return self.IDENTIFIERs[p.IDENTIFIER]
        except LookupError:
            print("Undefined IDENT '%s'" % p.IDENTIFIER)
            return 0

    def error(self, p):
        print("Syntax error near '%s'" % p.value[0], traceback.print_exc())


if __name__ == '__main__':

    # Read DLang source from file
    if len(sys.argv) == 2:
        lexer = DLangLexer()
        parser = DLangParser()
        with open(sys.argv[1]) as source:
            dlang_code = source.read()
            try:
                tokens = lexer.tokenize(dlang_code)
                for tok in tokens:
                    # Add identifier tokens to the symbol table
                    if tok.type == 'IDENTIFIER':
                        if tab.lookup_name(tok.value) == 0:
                            tab.add_name(tok.value)
                parser.parse(lexer.tokenize(dlang_code))
                if not semanticErrorOccured:
                    print('\n No Semantic Error!\n')
                print('Symbol Table Content')
                print(tab.table)
            except EOFError:
                exit(1)
    else:
        print("[DLang]: Source file missing")