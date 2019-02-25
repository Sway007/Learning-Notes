## doc structure
- \section
- \subsection
- \subsubsection
- \paragraph
- \subparagraph

# LaTex Beginner's Guide

## notes

- Commands may have arguments, given in curly braces or in square brackets.
  ```tex
  \command
  \command{arg}
  \command[optional arg]{arg}
  ``` 

- spaces separate words, empty lines separate paragraphs
- font commands
  | command | declaration | meaning |
  | -- | -- | -- |
  | \textrm{...} | \rmfamily | roman family |
  | \textsf{...} | \sffamily | sans-serif family |
  | \texttt{...} | \ttfamily | typewriter family |
  | \textbf{...} | \bfseries | bold-face |
  | \textmd{...} | \mdseries | medium |

- environments
  ```tex
  \begin{name}
    ...
  \end{name}
  ``` 
  > mandatory arguments are written in curly braces and optional arguments in
square brackets.
  ```tex
  \begin{name}[optional argument]{argument}
    ...
  \end{name}
  ```
# TODO
- Breaking lines, p.50