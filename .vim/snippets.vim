" ----------------------------------- HTML ----------------------------------- 
au FileType html map <leader>ht a<html></html><Esc>F<i
au FileType html map <leader>hh a<head></head><Esc>F<i
au FileType html map <leader>hb a<body></body><Esc>F<i
au FileType html map <leader>d a<div></div><Esc>F<i

au FileType html map <leader>b a<b></b><Space><Esc>FbT>i
au FileType html map <leader>1 a<h1></h1><Esc>02f<i
au FileType html map <leader>2 a<h2></h2><Esc>02f<i
au FileType html map <leader>3 a<h3></h3><Esc>02f<i
au FileType html map <leader>4 a<h4></h4><Esc>02f<i
au FileType html map <leader>5 a<h5></h5><Esc>02f<i
au FileType html map <leader>6 a<h6></h6><Esc>02f<i
au FileType html map <leader>p a<p></p><Esc>02f<i
au FileType html map <leader>a a<a href=""></a><Esc>0f"a
au FileType html map <leader>im a<img src="" alt=""><Esc>0f"a
au FileType html map <leader>it a<i></i><Esc>0f>a
au FileType html map <leader>ul a<ul><Enter><li></li><Enter></ul><Esc>0k2f<i
au FileType html map <leader>li a<li></li><Esc>F>a
au FileType html map <leader>ol a<ol><Enter><li></li><Enter></ol><Esc>0k2f<i

au FileType html imap <leader>ht <html></html><Esc>F<i
au FileType html imap <leader>hh <head></head><Esc>F<i
au FileType html imap <leader>hb <body></body><Esc>F<i
au FileType html imap <leader>d <div></div><Esc>F<i

au FileType html imap <leader>b <b></b><Space><Esc>FbT>i
au FileType html imap <leader>1 <h1></h1><Esc>02f<i
au FileType html imap <leader>2 <h2></h2><Esc>02f<i
au FileType html imap <leader>3 <h3></h3><Esc>02f<i
au FileType html imap <leader>4 <h4></h4><Esc>02f<i
au FileType html imap <leader>5 <h5></h5><Esc>02f<i
au FileType html imap <leader>6 <h6></h6><Esc>02f<i
au FileType html imap <leader>p <p></p><Esc>02f<i
au FileType html imap <leader>a <a href=""></a><Esc>0f"a
au FileType html imap <leader>im <img src="" alt=""><Esc>0f"a
au FileType html imap <leader>it <i></i><Esc>0f>a
au FileType html imap <leader>ul <ul><Enter><li></li><Enter></ul><Esc>0k2f<i
au FileType html imap <leader>li <li></li><Esc>F>a
au FileType html imap <leader>ol <ol><Enter><li></li><Enter></ol><Esc>0k2f<i

" ------------------------------------ TeX ------------------------------------
"  FIXME tex
au FileType tex,plaintex map <leader>p a^{+}<Esc>
au FileType tex,plaintex map <leader>s a^{*}<Esc>
au FileType tex,plaintex map <leader>m a$$<Esc>
au FileType tex,plaintex map <leader>t a\theorem{}{}<Esc>2h
au FileType tex,plaintex map <leader>r a\rank<Esc>
au FileType tex,plaintex map <leader>k a\ker<Esc>
au FileType tex,plaintex map <leader>d a\dim<Esc>
au FileType tex,plaintex map <leader>b a{()}<Esc>h
au FileType tex,plaintex map <leader>ge a\geqslant<Esc>
au FileType tex,plaintex map <leader>le a\leqslant<Esc>
au FileType tex,plaintex map <leader>ne a\neq<Esc>
au FileType tex,plaintex map <leader>v a\vec{}<Esc>
au FileType tex,plaintex map <leader>h a\hat{}<Esc>
au FileType tex,plaintex map <leader>o a\overline{}<Esc>
au FileType tex,plaintex map <leader>i a\begin{itemize}<Esc>o\item defaul<Esc>o\end{itemize}<Esc>$kb
au FileType tex,plaintex map <leader>x a\times<Esc>

au FileType tex,plaintex imap <leader>p ^{+}<Esc>
au FileType tex,plaintex imap <leader>s ^{*}<Esc>
au FileType tex,plaintex imap <leader>m $$<Esc>
au FileType tex,plaintex imap <leader>t \theorem{}{}<Esc>2h
au FileType tex,plaintex imap <leader>r \rank<Esc>
au FileType tex,plaintex imap <leader>k \ker<Esc>
au FileType tex,plaintex imap <leader>d \dim<Esc>
au FileType tex,plaintex imap <leader>b {()}<Esc>h
au FileType tex,plaintex imap <leader>ge \geqslant<Esc>
au FileType tex,plaintex imap <leader>le \leqslant<Esc>
au FileType tex,plaintex imap <leader>ne \neq<Esc>
au FileType tex,plaintex imap <leader>v \vec{}<Esc>
au FileType tex,plaintex imap <leader>h \hat{}<Esc>
au FileType tex,plaintex imap <leader>o \overline{}<Esc>
au FileType tex,plaintex imap <leader>i \begin{itemize}<Esc>o\item defaul<Esc>o\end{itemize}<Esc>$kb
au FileType tex,plaintex imap <leader>x \times<Esc>

" ----------------------------------- C/C++ -----------------------------------
au FileType c,cpp map <leader>fi afor (int i = 0; i < ; ++i)<Esc>5hi
au FileType c,cpp map <leader>fs afor (size_t i = 0; i < ; ++i)<Esc>5hi
au FileType c,cpp map <leader>i aif ()<Esc>i
au FileType c,cpp map <leader>ei a else if ()<Esc>i
au FileType c,cpp map <leader>ee a else {}<Esc>i
au FileType c,cpp map <leader>b la {}<Esc>i

au FileType c,cpp imap <leader>fi for (int i = 0; i < ; ++i)<Esc>5hi
au FileType c,cpp imap <leader>fs for (size_t i = 0; i < ; ++i)<Esc>5hi
au FileType c,cpp imap <leader>i if ()<Esc>i
au FileType c,cpp imap <leader>ei else if ()<Esc>i
au FileType c,cpp imap <leader>ee else {}<Esc>i
au FileType c,cpp imap <leader>b <Esc>a {}<Esc>i
