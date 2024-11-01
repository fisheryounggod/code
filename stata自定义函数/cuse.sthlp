{smcl}
{* 2018年2月2日}
{hline}
{cmd:help cuse}{right: }
{hline}

{title:标题}

{phang}
{bf:cuse} {hline 2} 调用我的数据仓库里面的数据集。{p_end}

{title:语法}

{p 8 18 2}
{cmdab:cuse} {cmd: filename} {cmd:,} [{cmd:{opt c:lear}} {cmd:{opt w:eb}} {cmd:{opt s:avetosystem}}]

{p 8 18 2}
{cmdab:db} {cmd: cuse}


{title:描述}
{pstd}{space 3}{cmd: filename}: 需要使用的数据集的名字。{p_end}
{pstd}{space 3}{cmd: db cuse}: 可以打开一个对话框操作（这个只能调用我自己的数据集）。{p_end}
{pstd}另外我的数据仓库里面涵盖了陈强《计量经济学及Stata应用》和《高级计量经济学及Stata应用》两本书的数据集。{p_end}
{pstd}可以直接调用，但是需要注意，如果你想调用的数据集的名字里含大写字母，你需要把它调成小写才能调用。{p_end}

{marker options}{...}
{title:选项}

{phang}
{cmd:{opt c:lear}}: 选择是否清空当前数据集。{p_end}

{phang}
{cmd:{opt w:eb}}: 指定调用远端仓库的数据集。默认调用本地仓库的数据集。{p_end}

{phang}
{cmd:{opt s:avetosystem}}: 指定是否需要将该数据集存入系统文件夹中，以方便使用sysuse命令调用。{p_end}

{title:示例}

{phang}
{stata `"db cuse"'}
{p_end}
{phang}
{stata `"cuse station, c"'}
{p_end}
{phang}
{stata `"cuse population, c w"'}
{p_end}
{phang}
{stata `"cuse huaihe, c w s"'}
{p_end}

{title:作者}

{pstd}程振兴{p_end}
{pstd}暨南大学经济学院{p_end}
{pstd}中国广州{p_end}
{pstd}{browse "http://www.czxa.top/cuse/":项目网站}{p_end}
{pstd}{browse "http://czxa.top":个人网站}{p_end}
{pstd}Email {browse "mailto:czx@czxa.top":czx@czxa.top}{p_end}

{title:Also see}
{phang}
{stata `"help cuselist"'}
{p_end}
