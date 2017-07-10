-   [1. Importing data](#orgheadline3)
    -   [1.1. Download data for the tutorial](#orgheadline1)
    -   [1.2. Read the data into R](#orgheadline2)
-   [2. Check if data are imported correctly](#orgheadline4)
-   [3. Preparing the data for analysis](#orgheadline5)
-   [4. Exporting/saving data](#orgheadline8)
    -   [4.1. text csv format](#orgheadline6)
    -   [4.2. R data format](#orgheadline7)

### 1 Importing data

This tutorial explains how a text format data file (comma separated
values) can be read into R. Before you start note the following:

-   The R-code shown in the boxes below should be copied to your
    R-script.
-   R-studio: There is a click interface (Tools -&gt; Import Dataset) to
    importing a text file. It is fine to use this, if afterwards the
    resulting R-code shown in the console, e.g., *mydata &lt;-
    read.csv(…)*, is saved in your R-script. The command *View(mydata)*
    should not be saved.
-   R-studio: To see the raw data go to the files menu (Ctrl-5) and
    double-click on the file you want to import.
-   If your computer opens the downloaded file in Excel then you should
    use the menu: *save-as* and choose *text csv*.

### 1.1 Download data for the tutorial

Save the [Diabetes
data](http://192.38.117.59/~tag/Teaching/share/data/Diabetes.html) in
the current [R working directory](./R-working-directory.html).

### 1.2 Read the data into R

By running the R-code:

    Diabetes <- read.csv2("Diabetes.csv")
    # or
    Diabetes <- read.csv("Diabetes.csv")

Notes:

-   use `read.csv2` if the data are stored as semicolon separated values
    with Danish format for decimals
-   use `read.csv` if the data are stored as comma separated values with
    American format for decimals
-   To see which format the data are stored open the data file in
    R-studio

2 Check if data are imported correctly
--------------------------------------

Experience shows that reading data is a difficult task and that there
are too many different possible problems to describe them all. Thus,
here is only a short list of often seen issues and some suggestions to
explain and resolve these. The first thing to check is the Console which
in case of problems will often show an Error message (always a problem)
or a Warning (maybe a problem). If the console shows no errors you
should use the R-functions `View` and `str` to visualize the data and to
see the interpreted structure of the data set:

    View(Diabetes)
    str(Diabetes)

</div>
<table>
<thead>
<tr class="header">
<th align="left">Problem</th>
<th align="left">Symptom</th>
<th align="left">Suggestion</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">Data are not found</td>
<td align="left">Console: Error message</td>
<td align="left">Check if the data file is available in the current working directory.</td>
</tr>
<tr class="even">
<td align="left">Data are not read</td>
<td align="left">Console: Error message</td>
<td align="left">Check that the data file-name is typed correctly including lower/upper case.</td>
</tr>
<tr class="odd">
<td align="left">Only 1 variable but should be more</td>
<td align="left">'data.frame': 403 obs. of 1 variable:</td>
<td align="left">Change from read.csv to read.csv2</td>
</tr>
<tr class="even">
<td align="left">A numeric variable is coded as Factor or Character</td>
<td align="left">the result of str(mydata) shows the wrong code</td>
<td align="left">Explictely control the decimal character, e.g., read.csv(mydata,dec=&quot;,&quot;) versus read.csv(mydata,dec=&quot;.&quot;)</td>
</tr>
</tbody>
</table>

3 Preparing the data for analysis
---------------------------------

Once the data are read properly into R, a natural next step is to
prepare them for analysis. Some common data preparation steps are
described in the tutorial [Data manipulation](./Data-manipulation.html).

4 Exporting/saving data
-----------------------

Suppose you have performed several data preparation steps and achieved a
version of the data set which is worth saving. You can choose between
many formats. For most purposes the best format is text csv format.

### 4.1 text csv format

    write.csv2(Diabetes,file="Diabetes-prepared.csv")

    Diabetes <- read.csv2(file="Diabetes-prepared.csv")

### 4.2 R data format

<div id="text-4-2" class="outline-text-3">

For the specific purpose of quickly reading the data again into R the
you can use R data format.

    save(Diabetes,file="Diabetes-prepared.rda")

The result can be reloaded with the command:

    Diabetes <- get(load(file="Diabetes-prepared.rda"))
