default: slides

slides:
	rm *.svg
	pandoc --lua-filter ../tikz.lua -f markdown+lhs --mathjax -t revealjs -s -o slides.html slides.md -V theme=white -V revealjs-url=../revealjs -V slidenum=true

pdf:
	rm *.svg
	pandoc --lua-filter ../tikz.lua -f markdown+lhs --mathjax -t beamer -s -o slides.pdf slides.md
