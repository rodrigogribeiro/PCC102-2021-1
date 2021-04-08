default: slides

slides:
	rm *.svg
	pandoc -f markdown+lhs --lua-filter ../tikz.lua --mathjax -t revealjs -s -o slides.html slides.md -V theme=white -V revealjs-url=../revealjs -V slidenum=true

pdf:
	pandoc -f markdown+lhs --mathjax -t beamer -s -o slides.pdf slides.md
