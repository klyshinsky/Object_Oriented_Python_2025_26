grammar seminar;

@members {
values = []
}

html: ('<' TAG2 atributes '>')? '<html' atributes '>' html2 '</html' atributes '>' ;//{self.values = ('html', [$html2::res])};
html2 locals [res=[]]: '<head' atributes '>' inner_head '</head>' {$html2::res=('head', [$inner_head.text])} '<body' atributes '>' inner_body '</body>';
inner_head: .+?;
atributes: .*?;
inner_body: (balanced_tag | non_balanced_tag | inner_text)*?;
balanced_tag locals [res=[]]: '<' TAG atributes '>' inner_body '</' TAG '>' {$balanced_tag::res=($2.text, $inner_body::res)};
non_balanced_tag: '<' TAG atributes '>' | '<' TAG atributes '/>';
inner_text: .+?;

// Lexer rules after.
INT: [0-9]+;
TAG: [a-zA-Z][a-zA-Z0-9]*;
TAG2: '!'[a-zA-Z][a-zA-Z0-9]*;
WS: [ \r\t\n]+ -> skip;
OB: [<];