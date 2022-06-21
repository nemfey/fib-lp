grammar jsbach;

root: function* EOF;

function: ID (var)* '|:' block ':|';

block: instruction*;

instruction: expression
    | whilecondition
    | ifcondition
    | elsecondition
    | condition
    | assignation
    | callfunction
    | read
    | write
    | reproduce
    | createlist
    | getfromlist
    | addtolist
    | lengthlist
    | removefromlist
    ;

expression:  '(' expression ')'
    |   <assoc=right> expression '^' expression
    |   expression ('*' | '/' | '%') expression
    |   expression ('+' | '-') expression
    |   (getfromlist | lengthlist)
    |   (num | var | note)
    ;

whilecondition: 'while' condition '|:' block ':|';   

ifcondition: 'if' condition '|:' block ':|' (elsecondition)?;

elsecondition: 'else' '|:' block ':|';

condition: expression  ('<' | '<=' | '>' | '>=' | '=' | '/=') expression;

assignation: var '<-' (expression | condition);

callfunction: ID (expression)*;

read: '<?>' var;

write: '<!>' (expression | condition | string | singlelist)*;

reproduce: '<:>' (expression | singlelist);

createlist: var '<-' singlelist;

getfromlist: var '[' expression ']';

addtolist: var '<<' expression;

lengthlist: '#' var;

singlelist: '{' (expression)* '}';

removefromlist: '8<' var '[' expression ']';

note: NOTE;
var:    VAR;
num:    NUM;
string: STRING;

NOTE:   [A-G] [0-8]?;
ID:     [A-Z] [a-zA-Z\u0080-\u00FF0-9_]*;
VAR:    [a-z] [a-zA-Z\u0080-\u00FF0-9]*;
NUM:    '-'? [0-9]+;
STRING: '"' .*? '"';


COMMENT: '~~~' .*? '~~~' -> skip;
WS:     [ \n]+ -> skip; 
