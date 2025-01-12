# keepalived-syntax.vim

syntax highlighting for [Keepalived](http://www.keepalived.org/) config files.

syntax off

![](http://blog.glidenote.com/images/2012/04/keepalived0.png)

syntax on

![](http://blog.glidenote.com/images/2012/04/keepalived1.png)

## Install

By hand, copy syntax and ftdetect contents to your vim directory.

If you use [Vundle](https://github.com/gmarik/vundle), add the following lines
to your `~/.vimrc`:

```vim
Plugin 'shadowwa/keepalived-syntax'
```

Then run inside Vim:

```vim
:so ~/.vimrc
:PluginInstall
```

If you use [Pathogen](https://github.com/tpope/vim-pathogen), do this:

```sh
cd ~/.vim/bundle
git clone https://github.com/shadowwa/keepalived-syntax.git
```

For [vim-plug](https://github.com/junegunn/vim-plug) users:

```vim
Plug 'shadowwa/keepalived-syntax'
```

in your `.vimrc` or `init.vim`, then restart Vim and run `:PlugInstall`.

## License

License: Same terms as Vim itself (see [license](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license))
