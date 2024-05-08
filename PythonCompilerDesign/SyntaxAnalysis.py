# -------------------------------------------------------------------------
# dlang-parser.py: DLang Syntax Analyzer
# Run with source file
# -------------------------------------------------------------------------
import sys
from sly import Lexer, Parser


class DLangLexer(Lexer):
    # Define names of tokens
    tokens = {LE, GE, EQ, NE, AND, OR, INT, DOUBLE, STRING, IDENTIFIER, NOTHING, INTK, DOUBLEK, BOOL, BOOLK, STRINGK,
               NULL, FOR, WHILE, IF, ELSE, RETURN, BREAK,  OUTPUT, INPUTINT, INPUTLINE}

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
    IDENTIFIER = r'[a-zA-Z_][a-zA-Z0-9_]{0,49}'

    # IDENTIFIER lexemes overlap with keywords.
    # To avoid confusion, we do token remaping.
    # Alternatively, you can specify each keywork before IDENTIFIER
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
    IDENTIFIER['Output'] = OUTPUT
    IDENTIFIER['InputInt'] = INPUTINT
    IDENTIFIER['InputLine'] = INPUTLINE
    IDENTIFIER['break'] = BREAK
    def error(self, t):
        print("Invalid character '%s'" % t.value[0])
        self.index += 1


class DLangParser(Parser):
    tokens = DLangLexer.tokens
    debugfile = 'parser.out'

    #precedence to resolve ambiguity, and reduce shift/reduce conflicts. The 1 remaining conflict is a dangling else we're sure.
    precedence = (
        ('left', 'OR'),
        ('left', 'AND'),
        ('nonassoc', 'EQ', 'NE'),
        ('nonassoc', 'LE', 'GE', '<', '>'),
        ('left', '+', '-'),
        ('left', '*', '/', '%'),
        ('right', '!', '='),
        ('right', 'UMINUS'),

    )



    def __init__(self):
        self.IDENTIFIERs = {}


    # Program -> Decl+
    @_('Decls')
    def Program(self, p):
        print('Parsing completed successfully!')
        return p
    @_('Decl Decls ', 'Decl')
    def Decls(self, p):
        return p

    # Decl -> VariableDecl | FunctionDecl
    @_('VariableDecl')
    def Decl(self, p):
        return p.VariableDecl

    @_('FunctionDecl')
    def Decl(self, p):
        return p.FunctionDecl

    # VariableDecl -> Variable;
    @_('Variable ";"')
    def VariableDecl(self, p):
        print('Found VariableDecl')


    # Variable -> Type ident
    @_('Type IDENTIFIER')
    def Variable(self, p):
        return ('variable', p.Type, p.IDENTIFIER)

    # Type -> int | double | bool | string
    @_('INTK', 'DOUBLEK', 'BOOLK', 'STRINGK')
    def Type(self, p):
        return p

    # Rule for ensuring a declared identifier is recognized or flagged as undefined.
    @_('IDENTIFIER')
    def Decl(self, p):
        try:
            return self.IDENTIFIERs[p.IDENTIFIER]
        except LookupError:
            print("Undefined IDENT '%s'" % p.IDENTIFIER)
            return 0

    # Rule for recognizing an identifier within an expression.
    @_('IDENTIFIER')
    def Expr(self, p):
        try:
            return self.IDENTIFIERs[p.IDENTIFIER]
        except LookupError:
            return 0





    # FunctionDecl → Type ident ( Formals ) StmtBlock | nothing ident ( Formals ) StmtBlock
    @_('Type IDENTIFIER "(" Formals ")" StmtBlock')
    def FunctionDecl(self, p):
        print('Found FunctionDecl with return type')

    @_('NOTHING IDENTIFIER "(" Formals ")" StmtBlock')
    def FunctionDecl(self, p):
        print('Found FunctionDecl w  th nothing return type')





    # Formals -> Variable Formals | ε
    # This method handles the case where the function has one or more formal parameters. The method concatenates the current parameter with the rest of the parameters
    @_('Variable Formals')
    def Formals(self, p):
        print("Found formal parameter(s)")
        return [p.Variable] + p.Formals  # Accumulating the variables in a list

    # This method handles the base case for the 'Formals' rule where there are no formal parameters.
    @_('')
    def Formals(self, p):
        print("Found no formal parameters")
        return []  # The empty list for the base case

    # StmtBlock → "{" VariableDecl* Stmt* "}"
    # This method handles the declaration of a statement block which is delimited by curly braces.
    @_(' "{" StmtBlockContent "}" ')
    def StmtBlock(self, p):
        print("Found statement block")
        return p

    # This method  accumulates a list of statements and variable declarations within a block.
    @_('VariableDecl StmtBlockContent', 'Stmt StmtBlockContent')
    def StmtBlockContent(self, p):
        return p

    # This method handles the base case of the 'StmtBlockContent' rule.
    # It matches when there are no more statements or declarations in a statement block.
    @_('')
    def StmtBlockContent(self, p):
        print("Found empty statement block content")
        return p


    #Stmt → <Expr> ; | IfStmt | WhileStmt | ForStmt | BreakStmt | ReturnStmt | OutputStmt | StmtBlock
    # This method handles a simple statement that is an expression ending in a semicolon.
    @_('Expr ";"')
    def Stmt(self, p):
        print("Found expression statement")
        return p



    # This method handles the case of an empty statement, which is just a semicolon.
    @_('";"')
    def Stmt(self, p):
        print("Found empty statement")
        return p
    @_('IfStmt', 'WhileStmt', 'ForStmt', 'BreakStmt', 'ReturnStmt', 'OutputStmt', 'StmtBlock')
    def Stmt(self, p):
        return p

    #IfStmt → if ( Expr ) Stmt <else Stmt>
    # This method handles an if statement
    @_('IF "(" Expr ")" Stmt ELSE Stmt')
    def IfStmt(self, p):
        print("Found if-else statement")
        return p

    #WhileStmt → while ( Expr ) Stmt
    # This method handles a while loop with a condition and a body.
    @_('WHILE "(" Expr ")" Stmt')
    def WhileStmt(self, p):
        print("Found while loop")
        return p


    #ForStmt → for ( <Expr> ; Expr ; <Expr> ) Stmt
    @_('FOR "(" Expr ";" Expr ";" Expr ")" Stmt')
    def ForStmt(self, p):
        print("Found for loop")
        return p

    #ReturnStmt → return <Expr> ;
    @_('RETURN Expr ";"')
    def ReturnStmt(self, p):
        print("Found return statement")
        return p


    #BreakStmt → break ;
    @_('BREAK ";"')
    def BreakStmt(self, p):
        print("Found break statement")
        return p


    #OutputStmt → Output ( Expr+, ) ;
    @_('OUTPUT "(" Expr Exprs ")" ";"')
    def OutputStmt(self, p):
        print("Found output statement")
        return p


    # This method concatenates the current expression with additional expressions to form a list.
    # It handles the case where multiple expressions are provided as part of the output statement.
    @_('Expr Exprs')
    def Exprs(self, p):
        print('Found expression list')
        return p

    # This method is for the base case when there are no more expressions left to parse.
    # It matches an empty string and signals the end of an expression list.
    @_('')
    def Exprs(self, p):
        print('Found empty expression list')
        return p

    # This method captures the pattern for assignment expressions, which consists of an identifier,
    # an equal sign, and another expression to which the identifier is being assigned.
    @_('IDENTIFIER "=" Expr')
    def Expr(self, p):
        print(f"Found assignment expression: {p.IDENTIFIER} =")
        return p

    # This method handles cases where the parsed token is a constant.
    # Constants include integer, double, boolean, string, and null values.
    @_('Constant')
    def Expr(self, p):
        print("Found constant")
        return p

    # This method captures function call expressions.
    # It matches an identifier followed by a pair of parentheses containing actual arguments.
    @_('Call')
    def Expr(self, p):
        print("Found function call")
        return p

    # This method handles parenthesized expressions.
    # It ensures that expressions enclosed within parentheses are evaluated as a single group.
    @_(' "(" Expr ")" ')
    def Expr(self, p):
        print('Found parenthesized expression')
        return p


    # The following are expressions with a literal operation between them (+, -, %, ...)
    @_('Expr "+" Expr')
    def Expr(self, p):
        print('Found addition expression')
        return p

    @_('Expr "-" Expr')
    def Expr(self, p):
        print('Found subtraction expression')
        return p

    @_('Expr "*" Expr')
    def Expr(self, p):
        print('Found multiplication expression')
        return p

    @_('Expr "/" Expr')
    def Expr(self, p):
        print('Found division expression')
        return p

    @_('Expr "%" Expr')
    def Expr(self, p):
        print('Found modulo expression')
        return p

    @_('"-" Expr %prec UMINUS')
    def Expr(self, p):
        print('Found unary negation expression')
        return p

    @_('Expr "<" Expr')
    def Expr(self, p):
        print('Found less than expression')
        return p

    @_('Expr LE Expr')
    def Expr(self, p):
        print('Found less than or equal to expression')
        return p

    @_('Expr ">" Expr')
    def Expr(self, p):
        print('Found greater than expression')
        return p

    @_('Expr GE Expr')
    def Expr(self, p):
        print('Found greater than or equal to expression')
        return p

    @_('Expr EQ Expr')
    def Expr(self, p):
        print('Found equality expression')
        return p

    @_('Expr NE Expr')
    def Expr(self, p):
        print('Found inequality expression')
        return p

    @_('Expr AND Expr')
    def Expr(self, p):
        print('Found logical AND expression')
        return p

    @_('Expr OR Expr')
    def Expr(self, p):
        print('Found logical OR expression')
        return p

    @_('"!" Expr')
    def Expr(self, p):
        print('Found logical NOT expression')
        return p

    @_('INPUTINT "(" ")"')
    def Expr(self, p):
        print('Found input integer expression')
        return p

    @_('INPUTLINE "(" ")"')
    def Expr(self, p):
        print('Found input string expression')
        return p

    # Handles function call syntax where an identifier is followed by a pair of parentheses enclosing a list of actual arguments (Actuals).
    @_('IDENTIFIER "(" Actuals ")"')
    def Call(self, p):
        print(f"Found function call: {p.IDENTIFIER}()")
        return p

    # Handles the Actuals  in the grammar, which represents a non-empty list of actual parameters used in function calls.
    # It is defined to capture an expression followed by further actuals, allowing for a comma-separated list of expressions.
    @_('Expr ActualsRest')
    def Actuals(self, p):
        print("Found arguments list")
        return p

    # Handles the case of an empty list of actual parameters.
    @_('')
    def Actuals(self, p):
        print("Found empty arguments list")
        return []

    # Matches a comma followed by an expression, then matching any further arguments.
    # It is used to separate individual expressions in the list of actual parameters.
    @_('"," Expr ActualsRest')
    def ActualsRest(self, p):
        print("Found subsequent argument in list")
        return p

    # This rule serves as the base case for the  ActualsRest rule
    @_('')
    def ActualsRest(self, p):
        print("Reached end of arguments list")
        return p

    # Matches constants within expressions. It returns the matched token directly

    @_('INT', 'DOUBLE', 'BOOL', 'STRING', 'NULL')
    def Constant(self, p):
        return p


if __name__ == '__main__':
    if len(sys.argv) == 2:
        lexer = DLangLexer()
        parser = DLangParser()
        with open(sys.argv[1]) as source:
            dlang_code = source.read()
            try:
                parser.parse(lexer.tokenize(dlang_code))
            except EOFError:
                exit(1)
    else:
        print("[DLang]: Source file missing")