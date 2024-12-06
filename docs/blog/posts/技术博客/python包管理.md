---
date:
    created: 2024-12-06
catalogues:
    - 日志
tags:
    - python
slug:
    python-packaging
---

# python应用的环境隔离问题

解决Blog系统环境隔离的问题

<!-- more -->

过去大家都会直接采用 requirements.txt 作为项目的包管理工具，而这种方法没有考虑的因素很多【补充】

## 安装

### 使用pipx安装poetry

包管理工具采用 [`pipx`](https://github.com/pypa/pipx)，能够为python应用提供隔离的环境。


中途问题：

通过 `pipx` 安装 `poetry` 时发现：

```log
PIP STDERR
----------
ERROR: Could not find a version that satisfies the requirement portry (from versions: none)
ERROR: No matching distribution found for portry
```

推测问题在于python版本太高，没有编译好的版本，尝试降版本。

根据信息可知，pipx版本相关：
```bash
$ pipx -v                                                                                               2 ↵
pipx >(setup:1110): pipx version is 1.7.1
pipx >(setup:1111): Default python interpreter is '/opt/homebrew/opt/python@3.13/libexec/bin/python'
```

[STFW](https://stackoverflow.com/questions/78703690/pipx-using-latest-python-3-12-instead-of-system-default)发现
可以用指定版本的pip装，尝试降到3.11，成功安装。

潜在问题：pipx的版本被固定在 python@3.11

---

一点想法

从解决问题的角度， `pipx` 就是解决这个问题很好的方案，不需要 `poetry`，因为这本身就是用户视角的解决方案。

经过测试后并不可行，因为`pipx`的本质过程描述为[这篇文章](https://pipx.pypa.io/stable/how-pipx-works/)

简而言之，`pipx` 的作用是为python应用构建独立的python环境，而我们的博客系统需要多个插件，并不适合。

---

## poetry 使用指南

Initialising a pre-existing project
```bash
poetry init
```

这里提到可以采用 `pyenv` 配合 `poetry` 管理项目 (感觉这个栈越套越深了, 而且需要配置两个系统，深刻感受到
Docker 的好了, 可惜服务器的内存有限)

### pyenv 工作原理

> At a high level, pyenv intercepts Python commands using shim executables injected into your PATH, determines which Python version has been specified by your application, and passes your commands along to the correct Python installation.

```bash
#查看 指定版本的python路径
pyenv which python3.8
```

Switch between Python versions
To select a Pyenv-installed Python as the version to use, run one of the following commands:

- pyenv shell <version> -- select just for current shell session
- pyenv local <version> -- automatically select whenever you are in the current directory (or its subdirectories)
- pyenv global <version> -- select globally for your user account

E.g. to select the above-mentioned newly-installed Python 3.10.4 as your preferred version to use:

```bash
pyenv global 3.10.4
```
Now whenever you invoke python, pip etc., an executable from the Pyenv-provided 3.10.4 installation will be run instead of the system Python.

找到一位老哥写的[脚本](https://stackoverflow.com/a/72750989/20354068)能将 homebrew 的 python 软链到 pyenv，实现统一管理。不过脚本有点问题，下面也有老哥提到。

这样，整个工具的工作流就基本完成了。

## 工作流组合

1. `pyenv` 管理项目的 python 版本
2. `poetry` 用于项目的包版本管理
3. `shell` 脚本负责拉取和重新构建