from sly import Lexer


class Winter2024Lexer(Lexer):
    # define names of tokens
    tokens = { LE, GE, EQ, NE, AND, OR, NOT, NOTHING,IDENTIFIER, INTK, DOUBLE, BOOLEAN, STRING, CLASS, INTERFACE, NULL, THIS, EXTENDS, IMPLEMENTS, FOR, WHILE, IF, ELSE, RETURN, BREAK, NEW, ARRAYINSTANCE, OUTPUT, INPUTINT, INPUTLINE, LEFTPAR, RIGHTPAR, SEMICOLON, ASSIGN, INTEGER}

    literals = {'+', '-', '*', '/'}

    # Multi-character tokens
    LE = r'<='
    GE = r'>='
    EQ = r'=='
    NE = r'!='
    AND = r'&&'
    OR = r'\|\|'
    NOT = r'!'

    # specify items to ignore
    ignore = ' \t'  # ignore white space
    ignore_newline = r'\n+'  # ignore newlines
    ignore_comment1 = r'\/\/.*'  # single line comments
    ignore_comment2 = r'\/\*(.|[\r\n])*?\*\/' # multiline comments

    # speficy REs for each token (token group)

    # String
    STRING = r'\"(?:[^\"\n]|\\\")*\"'  # Regex for matching double-quoted strings, capturing sequences within quotes while handling escaped quotes (\") and excluding newlines.


    # Special symbols
    LEFTPAR = r'\('
    RIGHTPAR = r'\)'
    SEMICOLON = r';'
    ASSIGN = r'='

    # Numbers
    DOUBLE = r'(?:\d+\.\d+|\d+\.\d*)(?:E[+-]?\d+)?' # one re more digit followed by a decimal followed by more digits, OR  a case where there is no following digits like "123."
                                                    # Match of letter E followed by an optional  + or -, with more digits.
    INTEGER = r'[0-9]+'

    # Identifiers
    BOOLEAN = r'\b(?:True|False)\b'
    IDENTIFIER = r'[a-zA-Z_][a-zA-Z0-9_]{0,49}' # Regex for matching identifiers: starts with a letter or underscore, followed by up to 49 letters, digits, or underscores, limiting length to 50 characters.

    # specisal case for keywords
    IDENTIFIER['nothing'] = NOTHING
    IDENTIFIER['int'] = INTK
    IDENTIFIER['class'] = CLASS
    IDENTIFIER['interface'] = INTERFACE
    IDENTIFIER['null'] = NULL
    IDENTIFIER['this'] = THIS
    IDENTIFIER['extends'] = EXTENDS
    IDENTIFIER['implements'] = IMPLEMENTS
    IDENTIFIER['for'] = FOR
    IDENTIFIER['while'] = WHILE
    IDENTIFIER['if'] = IF
    IDENTIFIER['else'] = ELSE
    IDENTIFIER['return'] = RETURN
    IDENTIFIER['break'] = BREAK
    IDENTIFIER['new'] = NEW
    IDENTIFIER['arrayinstance'] = ARRAYINSTANCE
    IDENTIFIER['output'] = OUTPUT
    IDENTIFIER['inputint'] = INPUTINT
    IDENTIFIER['inputline'] = INPUTLINE




    # Have error handling
    def error(self, t):
        print('Invalid character/token: ', t.value[0])
        self.index += 1


if __name__ == '__main__':
    myscanner = Winter2024Lexer()
    print("Enter text to tokenize. Type 'exit' to quit the shell.")

    while True:
        stream = input('Winter2024Lexer$ ')

        # Check if the user wants to exit the shell
        if stream.lower() == 'exit':
            print("Exiting Winter2024Lexer shell.")
            break

        for token in myscanner.tokenize(stream):
            print('type=%r , value=%r' % (token.type, token.value))
