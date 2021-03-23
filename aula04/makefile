default: slides

slides:
	pandoc -f markdown+lhs --lua-filter ../tikz.lua --mathjax -t revealjs -s -o ./slides/slides.html ./app/Main.lhs -V theme=white -V revealjs-url=../../revealjs -V slidenum=true

pdf:
	pandoc -f markdown+lhs --mathjax -t beamer -s -o ./slides/slides.pdf ./app/Main.lhs
