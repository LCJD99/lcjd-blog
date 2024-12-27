---
date:
    created: 2024-12-11
catalogues:
    - 技术记录
tags:
    - vim
slug:
    OSC52 for system clipboard
---

# 01-vim 脚本入门

要想让vim更趁手不可避免要写一些自己的脚本，本文记录vim脚本入门

<!-- more -->

## 一些规则

来源: https://vim.fandom.com/wiki/Write_your_own_Vim_function 

函数名必须首字母大写

参数使用方法：

```vim
fu! Hex2dec(var1, var2)
  let str=a:var1
  let str2=a:var2
```
可以看到使用需要加前缀 `a:`

- 无类型
- 不要 `;`
- 可递归

## 变量属性

``` 
|buffer-variable|    b:	  Local to the current buffer.
|window-variable|    w:	  Local to the current window.
|tabpage-variable|   t:	  Local to the current tab page.
|global-variable|    g:	  Global.
|local-variable|     l:	  Local to a function (only in a legacy function)
|script-variable|    s:	  Local to a |:source|'ed Vim script.
|function-argument|  a:	  Function argument (only in a legacy function).
|vim-variable|       v:	  Global, predefined by Vim.
```
