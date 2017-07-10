<div id="content">

<div id="table-of-contents">

Table of Contents
-----------------

<div id="text-table-of-contents">

-   [1. Importing data](#orgheadline3)
    -   [1.1. Download data for the tutorial](#orgheadline1)
    -   [1.2. Read the data into R](#orgheadline2)
-   [2. Check if data are imported correctly](#orgheadline4)
-   [3. Preparing the data for analysis](#orgheadline5)
-   [4. Exporting/saving data](#orgheadline8)
    -   [4.1. text csv format](#orgheadline6)
    -   [4.2. R data format](#orgheadline7)

</div>

</div>

<div id="outline-container-orgheadline3" class="outline-2">

[1]{.section-number-2} Importing data {#orgheadline3}
-------------------------------------

<div id="text-1" class="outline-text-2">

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

</div>

<div id="outline-container-orgheadline1" class="outline-3">

### [1.1]{.section-number-3} Download data for the tutorial {#orgheadline1}

<div id="text-1-1" class="outline-text-3">

Save the [Diabetes
data](http://192.38.117.59/~tag/Teaching/share/data/Diabetes.html) in
the current [R working directory](./R-working-directory.html).

</div>

</div>

<div id="outline-container-orgheadline2" class="outline-3">

### [1.2]{.section-number-3} Read the data into R {#orgheadline2}

<div id="text-1-2" class="outline-text-3">

By running the R-code:

<div class="org-src-container">

``` {.src .src-R}
Diabetes <- read.csv2("Diabetes.csv")
# or
Diabetes <- read.csv("Diabetes.csv")
```

</div>

Notes:

-   use `read.csv2` if the data are stored as semicolon separated values
    with Danish format for decimals
-   use `read.csv` if the data are stored as comma separated values with
    American format for decimals
-   To see which format the data are stored open the data file in
    R-studio

</div>

</div>

</div>

<div id="outline-container-orgheadline4" class="outline-2">

[2]{.section-number-2} Check if data are imported correctly {#orgheadline4}
-----------------------------------------------------------

<div id="text-2" class="outline-text-2">

Experience shows that reading data is a difficult task and that there
are too many different possible problems to describe them all. Thus,
here is only a short list of often seen issues and some suggestions to
explain and resolve these. The first thing to check is the Console which
in case of problems will often show an Error message (always a problem)
or a Warning (maybe a problem). If the console shows no errors you
should use the R-functions `View` and `str` to visualize the data and to
see the interpreted structure of the data set:

<div class="org-src-container">

``` {.src .src-R}
View(Diabetes)
str(Diabetes)
```

</div>

  Problem                                              Symptom                                          Suggestion
  ---------------------------------------------------- ------------------------------------------------ ----------------------------------------------------------------------------------------------------------
  Data are not found                                   Console: Error message                           Check if the data file is available in the current working directory.
  Data are not read                                    Console: Error message                           Check that the data file-name is typed correctly including lower/upper case.
  Only 1 variable but should be more                   'data.frame': 403 obs. of 1 variable:            Change from read.csv to read.csv2
  A numeric variable is coded as Factor or Character   the result of str(mydata) shows the wrong code   Explictely control the decimal character, e.g., read.csv(mydata,dec=",") versus read.csv(mydata,dec=".")

</div>

</div>

<div id="outline-container-orgheadline5" class="outline-2">

[3]{.section-number-2} Preparing the data for analysis {#orgheadline5}
------------------------------------------------------

<div id="text-3" class="outline-text-2">

Once the data are read properly into R, a natural next step is to
prepare them for analysis. Some common data preparation steps are
described in the tutorial [Data manipulation](./Data-manipulation.html).

</div>

</div>

<div id="outline-container-orgheadline8" class="outline-2">

[4]{.section-number-2} Exporting/saving data {#orgheadline8}
--------------------------------------------

<div id="text-4" class="outline-text-2">

Suppose you have performed several data preparation steps and achieved a
version of the data set which is worth saving. You can choose between
many formats. For most purposes the best format is text csv format.

</div>

<div id="outline-container-orgheadline6" class="outline-3">

### [4.1]{.section-number-3} text csv format {#orgheadline6}

<div id="text-4-1" class="outline-text-3">

<div class="org-src-container">

``` {.src .src-R}
write.csv2(Diabetes,file="Diabetes-prepared.csv")
```

</div>

The result can be reloaded with the command:

<div class="org-src-container">

``` {.src .src-R}
Diabetes <- read.csv2(file="Diabetes-prepared.csv")
```

</div>

</div>

</div>

<div id="outline-container-orgheadline7" class="outline-3">

### [4.2]{.section-number-3} R data format {#orgheadline7}

<div id="text-4-2" class="outline-text-3">

For the specific purpose of quickly reading the data again into R the
you can use R data format.

<div class="org-src-container">

``` {.src .src-R}
save(Diabetes,file="Diabetes-prepared.rda")
```

</div>

The result can be reloaded with the command:

<div class="org-src-container">

``` {.src .src-R}
Diabetes <- get(load(file="Diabetes-prepared.rda"))
```

</div>

</div>

</div>

</div>

</div>

<div id="postamble" class="status">

Last update: 20 Oct 2015 by Thomas Alexander Gerds.

</div>
