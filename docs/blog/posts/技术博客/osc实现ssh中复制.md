---
date:
    created: 2024-12-11
catalogues:
    - 技术记录
tags:
    - shell
slug:
    OSC52 for system clipboard
---

# OSC52 实现在 ssh 时 vim 复制系统剪贴板

在 ssh 到服务器使用vim时总会遇到需要将代码复制到本地的情况，本文将探索其解决方案

<!-- more -->

## OSC52 是什么

ANSI escape code 是一个控制终端行为的标准，其控制终端的光标位置，颜色等信息。其序列的bytes都是以escape和bracket字符组成，现在的终端模拟器大多为该控制码做了适配。

OSC52 就是其中一个控制码，其告诉终端需要把字符串复制到系统剪贴板，其特点是本地无关性，即终端并不会关注其发出位置，即使其来自于ssh，这就为实现提供可能性。

