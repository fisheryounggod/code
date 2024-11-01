{smcl}
{* 2024年11月1日}
{hline}
{cmd:help gituse}{right: }
{hline}

{title:标题}

{phang}
{bf:gituse} {hline 2} 调用我的数据仓库gitdata里面的数据集。{p_end}

{title:语法}

{p 8 18 2}
{cmdab:gituse} {cmd: filename} {cmd:,} [{cmd:{opt c:lear}} {cmd:{opt w:eb}} {cmd:{opt s:avetosystem}}]

{p 8 18 2}
{cmdab:db} {cmd: gituse}


{title:描述}
{pstd}{space 3}{cmd: filename}: 需要使用的数据集的名字。{p_end}
{pstd}{space 3}{cmd: db gituse}: 可以打开一个对话框操作（这个只能调用我自己的数据集）。{p_end}
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
{stata `"db gituse"'}
{p_end}
{phang}
{stata `"gituse station, c"'}
{p_end}
{phang}
{stata `"gituse population, c w"'}
{p_end}
{phang}
{stata `"gituse huaihe, c w s"'}
{p_end}

{title:作者}

{pstd}yxf{p_end}
{pstd}西南财经大学{p_end}
{pstd}四川成都{p_end}
{pstd}{browse "https://fisheryounggod.github.io/projects/README.md":项目网站}{p_end}
{pstd}{browse "https://fisheryounggod.github.io":个人网站}{p_end}

{title:Also see}
{phang}
{stata `"help gituselist"'}
{p_end}
