{smcl}
{* *! version 0.1 07Nov2021}{...}
{cmd:help panelview}
{hline}

{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{hi:panelview} {hline 2}}Visualizing Panel Data {p_end}
{p2colreset}{...}

{title:Syntax}

{p 8 18 2}
{cmdab:panelview} {it:{help varname:Y D}} {it:{help varlist:X}}
{ifin} 
{cmd:,} {opt i(varname)} {opt t(varname numeric)} {opt type(string)}
[{it:options}]

{synoptset 23 tabbed}{...}
{synopthdr}
{synoptline}

{syntab:Main}
{synopt:{opt Y D X}}{it:{help varlist}} of outcome variable, treatment variable, and covariates, respectively. Including covariates may change the look of the plot due to missing values in these covariates{p_end}
{synopt:{opt i(varname)}}Specify the unit (group) indicator{p_end}
{synopt:{opt t(varname numeric)}}Specify the time indicator{p_end}
{synopt:{opt type(string)}}Can be {cmd:treat}, {cmd:outcome}, {cmd:{ul:bivar}iate}, and {cmd:{ul:miss}ing}{p_end}

{p 6 6 2}{cmd:type(treat)} plots treatment assignment using a heatmap; {cmd:type(outcome)} plots a variable in a time-series fashion;{p_end}
{p 6 6 2}{cmd:type(bivariate)} plots the outcome and treatment against time in the same graph; {cmd:type(missing)} plots the missing data status of a variable. {p_end}
{p 6 6 2}Variables appearing in the {cmd:if}/{cmd:in} clause should be included in varlist. {p_end}

{syntab:Advanced}
{synopt:{opt continuoustreat}}D is presented in a continuous fashion in a {cmd: type(outcome)} plot{p_end}
{synopt:{opt discreteoutcome}}When a variable is discrete, make sure {cmd: panelview} respects its discreteness in {cmd: type(outcome)} plots{p_end}
{synopt:{opt bytiming}}sort units by when they first receive the treatment; if the timing is the same, then by the total number of periods exposed to the treatment{p_end}
{synopt:{opt ignoretreat}}Omit the treatment indicator, that is, any variables after {cmd: Y} will be interpreted as covariates; useful in a {cmd:type(outcome)} plot{p_end}
{synopt:{opt mycol:or(string)}}change the color schemes; click {it:{help colorpalette:here}} for sequential colors (3-9 colors){p_end} 
{synopt:{opt pre:post}}distinguish the pre- and post-treatment periods for treated units{p_end}
{synopt:{opt xlabdist(integer)}}Change the gap between labels on the x-axis; default is {cmd: 1}{p_end}
{synopt:{opt ylabdist(integer)}}Change the gap between labels on the y-axis; default is {cmd: 1}{p_end}
{synopt:{opt bygroup}}Put each unit into different treatment groups, then plot them separately when {cmd: type(outcome)} is invoked{p_end}
{synopt:{opt style()}}The first and second entries define the style of the outcome and treatment, respectively. {cmd:connected} or {cmd:c} for connected lines, {cmd:line} or {cmd:l} for lines, and {cmd:bar} or {cmd:b} for bars{p_end}
{synopt:{opt byunit}}Plot the outcome and treatment variables against time by each unit when {cmd: type(bivariate)} is invoked{p_end}
{synopt:{opt theme(bw)}}Use the black and white theme (default when specified {cmd:type(bivar)}){p_end}
{synopt:{opt lwd()}}Set the line width in {cmd:type(bivar)}. Default is {cmd:medium}{p_end}
{synopt:{opt *}}Common graph options, such as {cmd:title}, {cmd:ytitle}, {cmd:xtitle}, {cmd:xlabel}, {cmd:ylabel}, and {cmd:legend}, can be applied in {cmd:panelview} as well{p_end}

{p 6 6 2}For more examples to illustrate, click {browse "https://github.com/xuyiqing/panelview_stata"}.

{synoptline}
{p2colreset}{...}
{p 4 6 2}
  {p_end}

{title:Description}

{pstd}
{opt panelview} has three main functionalities: {p_end}
{pstd}
(1) it visualizes the treatment and missing-value statuses of each observation in a panel dataset; {p_end}
{pstd}
(2) it plots the outcome variable (either continuous or discrete) in a time-series fashion; {p_end}
{pstd}
(3) it visualizes the relationships between the outcome and treatment variable individually or in an aggregate fashion. {p_end}
{pstd}

{title:Examples}

{pstd}Load example data (the turnout dataset){p_end}
{p 4 8 2}{stata "sysuse turnout, clear":. sysuse turnout, clear}{p_end}

{pstd}Basic syntax{p_end}
{p 4 8 2}{stata "panelview turnout policy_edr policy_mail_in policy_motor, i(abb) t(year) type(treat)":. panelview turnout policy_edr policy_mail_in policy_motor, i(abb) t(year) type(treat)}{p_end}

{p 6 6 2} In this plot, {cmd: turnout} is the outcome, {cmd: policy_edr} is the treatment, {cmd: policy_mail_in} and {cmd: policy_motor} are covariates.{p_end}
{p 6 6 2} For DID-type panel data with a dichotomous treatment indicator, we can distinguish the pre- and post-treatment periods for treated units by specifying {cmd:prepost}:
{p_end}

{p 4 8 2}{stata "panelview turnout policy_edr policy_mail_in policy_motor, i(abb) t(year) type(treat) prepost":. panelview turnout policy_edr policy_mail_in policy_motor, i(abb) t(year) type(treat) prepost}{p_end}


{p 4 8 2}{stata "panelview turnout policy_edr policy_mail_in policy_motor, i(abb) t(year) type(treat) bytiming":. panelview turnout policy_edr policy_mail_in policy_motor, i(abb) t(year) type(treat) bytiming}{p_end}

{p 6 6 2}use the {cmd:bytiming} option to sort units by the timing of receiving the treatment. {p_end}


{pstd}Change the color schemes for the controls and treated using the {cmd:mycolor} option. For example, {cmd:PuBu} indicates light purple to blue{p_end}

{p 4 8 2}{stata "panelview turnout policy_edr policy_mail_in policy_motor, i(abb) t(year) type(treat) mycolor(PuBu) bytiming":. panelview turnout policy_edr policy_mail_in policy_motor, i(abb) t(year) type(treat) mycolor(PuBu) bytiming}{p_end}


{pstd}Treatment: missing & switch on and off{p_end}

{pstd}Load example data (the state capacity dataset){p_end}
{p 4 8 2}{stata "sysuse capacity, clear":. sysuse capacity, clear}{p_end}
{p 4 8 2}{stata "panelview lnpop demo lngdp , i(country) t(year) type(treat) mycolor(Reds) xlabdist(3) ylabdist(10)":. panelview lnpop demo lngdp , i(country) t(year) type(treat) mycolor(Reds) xlabdist(3) ylabdist(10)}  {p_end}

{p 6 6 2}{cmd: demo} is a binary indicator of regime type. Use the {cmd:xlabdist} and {cmd:ylabdist} options to change the gaps between labels on the x- and y-axes. {p_end}


{pstd}Ignoring the Treatment Indicator{p_end}

{p 6 6 2}When we omit the treatment variable, the plot will show missing (the white area) and non-missing values only. This is essentially a plot for missing data. {p_end}

{p 4 8 2}{stata "panelview demo, i(ccode) t(year) type(treat) mycolor(Reds) xlabel(none) ylabel(none) ignoretreat":. panelview demo, i(ccode) t(year) type(treat) mycolor(Reds) xlabel(none) ylabel(none) ignoretreat}{p_end}

{p 6 6 2}Another way to achieve this goal is to set {cmd:type({ul:miss}ing)}: {p_end}

{p 4 8 2}{stata "panelview demo, i(ccode) t(year) type(missing) mycolor(Reds) xlabel(none) ylabel(none)":. panelview demo, i(ccode) t(year) type(missing) mycolor(Reds) xlabel(none) ylabel(none)}{p_end}


{pstd}More than Two Treatment Conditions{p_end}

{pstd}{cmd:panelview} supports panel data with more than 2 treatment levels. For example, we create a measure of regime type with three treatment levels: {p_end}

{p 4 8 2}{stata "gen demo2 = 0":. gen demo2 = 0}{p_end}
{p 4 8 2}{stata "replace demo2 = -1 if polity2 < -0.5":. replace demo2 = -1 if polity2 < -0.5}{p_end}
{p 4 8 2}{stata "replace demo2 = 1 if polity2 > 0.5":. replace demo2 = 1 if polity2 > 0.5}{p_end}
{p 4 8 2}{stata "panelview Capacity demo2 lngdp, i(ccode) t(year) type(treat) xlabdist(3) ylabdist(11)":. panelview Capacity demo2 lngdp, i(ccode) t(year) type(treat) xlabdist(3) ylabdist(11)}{p_end}

{p 6 6 2}If the number of treatment levels is greater than 5, then the treatment indicator will be regarded as a continuous variable. {p_end}
{p 6 6 2}We can plot the continuous treatment variable by specifying {cmd:continuoustreat}. {p_end}


{pstd}Plotting Outcomes{p_end}

{pstd}Continuous Outcomes{p_end}
{p 4 8 2}{stata "sysuse turnout, clear":. sysuse turnout, clear}{p_end}
{p 4 8 2}{stata "panelview turnout policy_edr, i(abb) t(year) type(outcome) prepost ylabel(0 (25) 100)":. panelview turnout policy_edr, i(abb) t(year) type(outcome) prepost ylabel(0 (25) 100)}{p_end}

{p 6 6 2}The three different colors represent the pure control units, treated units in the pre-treatment periods, and treated units in the post-treatment period. {p_end}
{p 6 6 2}Different from a treatment status plot, an outcome plot does not allow {cmd:xlabdist} and {cmd:ylabdist}. Instead, {cmd:xlabel} and {cmd:ylabel} can be used to adjust looks of axis labels. {p_end}

{p 4 8 2}{stata "panelview turnout policy_edr , i(abb) t(year) type(outcome) bygroup prepost xlabel(1920 (20) 2000) ":. panelview turnout policy_edr, i(abb) t(year) type(outcome) bygroup prepost xlabel(1920 (20) 2000)}{p_end}

{p 6 6 2}Due to options {cmd:bygroup} and {cmd: prepost}, {cmd: panelview} will analyze the data and automatically put each unit into different groups{p_end}
{p 6 6 2} e.g. (1) units always being treated, (2) units always under control, (3) units whose treatment status has changed. {p_end}

{pstd}Discrete Outcomes{p_end}
{p 4 8 2}{stata "sysuse simdata, clear":. sysuse simdata, clear}{p_end}
{p 4 8 2}{stata "panelview Y D, type(outcome) i(id) t(time) discreteoutcome xlabel(8 (2) 15) ylabel(0 (1) 2)":. panelview Y D, type(outcome) i(id) t(time) discreteoutcome xlabel(8 (2) 15) ylabel(0 (1) 2)}{p_end}

{p 6 6 2}Accommodate discrete variables by setting {cmd:discreteoutcome}. {p_end}


{pstd}Plotting any variable in a panel dataset{p_end}

{p 4 8 2}{stata "sysuse turnout, clear":. sysuse turnout, clear}{p_end}
{p 4 8 2}{stata "panelview turnout policy_edr, i(abb) t(year) type(outcome) ylabel(0 (25) 100) ignoretreat":. panelview turnout policy_edr, i(abb) t(year) type(outcome) ylabel(0 (25) 100) ignoretreat}{p_end}

{p 6 6 2}When we ignore the treatment status and apply {cmd:type(outcome)}, {cmd: panelview} can plot an outcome variable or an arbitrary variable in a panel dataset.{p_end}


{pstd}Plotting Y and D against time in the same graph{p_end}

{pstd}Plot average time series for all units{p_end}
{p 4 8 2}{stata "panelview turnout policy_edr, i(abb) t(year) xlabdist(7) type(bivariate) msize(*0.5) style(c b)":. panelview turnout policy_edr, i(abb) t(year) xlabdist(7) type(bivariate) msize(*0.5) style(c b)}{p_end}

{p 6 6 2}Visualize time series of the average outcome and average treatment status in the same figure by specifying {cmd:type(bivariate)}. {p_end}
{p 6 6 2}{cmd:style(c b)} means that, for the continuous outcome, we use a connected line plot; for the discrete treatment, we use a bar plot. The left y axis indicates outcome label; the right y axis indicates treatment label. {p_end}

{pstd}Plot by each unit{p_end}
{p 4 8 2}{stata "panelview turnout policy_edr if abb >= 1 & abb <= 12, i(abb) t(year) xlabdist(10) type(bivar) byunit":. panelview turnout policy_edr if abb >= 1 & abb <= 12, i(abb) t(year) xlabdist(10) type(bivar) byunit}{p_end}

{p 6 6 2}Plot D and Y for each unit against time in the same graph. {p_end}

{pstd}Use a line plot to represent (discrete) treatment status{p_end}
{p 4 8 2}{stata "panelview turnout policy_edr if abb >= 1 & abb <= 12, i(abb) t(year) xlabdist(10) style(line) type(bivar) byunit":. panelview turnout policy_edr if abb >= 1 & abb <= 12, i(abb) t(year) xlabdist(10) style(line) type(bivar) byunit}{p_end}

{p 6 6 2}To better visualize a discrete treatment whose value is sometimes zero, we use {cmd:style(line)} to invoke line plots instead of bar plots.{p_end} 


{title:Authors}

      Hongyu Mou (Maintainer), hongyumou5@gmail.com
      Peking University
      
      Yiqing Xu, yiqingxu@stanford.edu
      Stanford University
  
      Please do not hesitate to send your comments or suggestions to the maintainer. 
      
      
{title:Citation}

      Mou, Hongyu & Yiqing Xu. "panelview for visualizing panel data: a Stata package." Available at Statistical Software Components (SSC) archive. 
