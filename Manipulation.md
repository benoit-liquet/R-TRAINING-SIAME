-   [Introduction](#introduction)
    -   [Read data for the tutorial](#read-data-for-the-tutorial)
-   [Names, labels, levels](#names-labels-levels)
    -   [Changing one or several variable
        names](#changing-one-or-several-variable-names)
    -   [Labelling of factor variables](#labelling-of-factor-variables)
    -   [Setting the reference category of a
        factor](#setting-the-reference-category-of-a-factor)
    -   [Merging / combining factor
        levels](#merging-combining-factor-levels)
-   [Creating new variables](#creating-new-variables)
    -   [Calculating the difference between two
        variables](#calculating-the-difference-between-two-variables)
    -   [Calculating the product or ratio between two
        variables](#calculating-the-product-or-ratio-between-two-variables)
    -   [Transforming anthropometric measurements](#org20289c5)
    -   [Calculating the BMI based on weight and
        height](#calculating-the-bmi-based-on-weight-and-height)
    -   [Categorizing age using user defined
        cut-offs](#categorizing-age-using-user-defined-cut-offs)
    -   [Dichotomizing a continuous variable based on a single cut-off
        value](#dichotomizing-a-continuous-variable-based-on-a-single-cut-off-value)
    -   [Categorizing a continuous variable using several data
        independent
        cut-offs](#categorizing-a-continuous-variable-using-several-data-independent-cut-offs)
    -   [Categories based on empirical
        quantiles](#categories-based-on-empirical-quantiles)
    -   [Dichotomizing a character or categorical variable](#org9839d18)
    -   [Log-transformation (basis e)](#log-transformation-basis-e)
    -   [Log10](#log10)
    -   [log2](#log2)
-   [Dates](#dates)
    -   [Create some data in character/string
        format](#create-some-data-in-characterstring-format)
    -   [Date conversion](#date-conversion)
    -   [Computing differences between dates in days or
        years](#computing-differences-between-dates-in-days-or-years)

Introduction
------------

This R-tutorial is a syntax diary for often needed data manipulation
steps. The code is illustrated in the [Diabetes
data](http://192.38.117.59/~tag/Teaching/share/data/Diabetes.html). Use
the table of contents to find code for a specific task.

Typical first tasks of data preparation after reading a data set are

-   Check if variables have the correct format
-   Change variable names to something informative and easy to type
-   Format and label the factor variables
-   Define the reference category for factor variables
-   Calculate derived variables (E.g., BMI)
-   Transform continuous variables (E.g., log-transform or categorize)
-   Format dates
-   Deal with missing values. E.g., remove all subjects with missing
    data in one of the variables used for analysis

### Read data for the tutorial

Read the Diabetes data into R:

#### data.frame

    Diabetes <- read.csv("http://192.38.117.59/~tag/Teaching/share/data/Diabetes.csv")
    head(Diabetes)

    ##     id chol stab.glu hdl ratio glyhb   location age gender height weight
    ## 1 1000  203       82  56   3.6  4.31 Buckingham  46 female     62    121
    ## 2 1001  165       97  24   6.9  4.44 Buckingham  29 female     64    218
    ## 3 1002  228       92  37   6.2  4.64 Buckingham  58 female     61    256
    ## 4 1003   78       93  12   6.5  4.63 Buckingham  67   male     67    119
    ## 5 1005  249       90  28   8.9  7.72 Buckingham  64   male     68    183
    ## 6 1008  248       94  69   3.6  4.81 Buckingham  34   male     71    190
    ##    frame bp.1s bp.1d bp.2s bp.2d waist hip time.ppn
    ## 1 medium   118    59    NA    NA    29  38      720
    ## 2  large   112    68    NA    NA    46  48      360
    ## 3  large   190    92   185    92    49  57      180
    ## 4  large   110    50    NA    NA    33  38      480
    ## 5 medium   138    80    NA    NA    44  41      300
    ## 6  large   132    86    NA    NA    36  42      195

#### data.table

    library(data.table)
    Diabetes <- fread("http://192.38.117.59/~tag/Teaching/share/data/Diabetes.csv")
    Diabetes

    ##         id chol stab.glu hdl ratio glyhb   location age gender height
    ##   1:  1000  203       82  56   3.6  4.31 Buckingham  46 female     62
    ##   2:  1001  165       97  24   6.9  4.44 Buckingham  29 female     64
    ##   3:  1002  228       92  37   6.2  4.64 Buckingham  58 female     61
    ##   4:  1003   78       93  12   6.5  4.63 Buckingham  67   male     67
    ##   5:  1005  249       90  28   8.9  7.72 Buckingham  64   male     68
    ##  ---                                                                 
    ## 399: 41506  296      369  46   6.4 16.11     Louisa  53   male     69
    ## 400: 41507  284       89  54   5.3  4.39     Louisa  51 female     63
    ## 401: 41510  194      269  38   5.1 13.63     Louisa  29 female     69
    ## 402: 41752  199       76  52   3.8  4.49     Louisa  41 female     63
    ## 403: 41756  159       88  79   2.0    NA     Louisa  68 female     64
    ##      weight  frame bp.1s bp.1d bp.2s bp.2d waist hip time.ppn
    ##   1:    121 medium   118    59    NA    NA    29  38      720
    ##   2:    218  large   112    68    NA    NA    46  48      360
    ##   3:    256  large   190    92   185    92    49  57      180
    ##   4:    119  large   110    50    NA    NA    33  38      480
    ##   5:    183 medium   138    80    NA    NA    44  41      300
    ##  ---                                                         
    ## 399:    173 medium   138    94   130    94    35  39      210
    ## 400:    154 medium   140   100   146   102    32  43      180
    ## 401:    167  small   120    70    NA    NA    33  40       20
    ## 402:    197 medium   120    78    NA    NA    41  48      255
    ## 403:    220 medium   100    72    NA    NA    49  58      900

Names, labels, levels
---------------------

### Changing one or several variable names

Task: Change variable names for first and second measurements of
diastolic and systolic blood pressure:

<table>
<thead>
<tr class="header">
<th align="left">Old name</th>
<th align="left">New name</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">bp.1d</td>
<td align="left">DBP1</td>
</tr>
<tr class="even">
<td align="left">bp.2d</td>
<td align="left">DBP2</td>
</tr>
<tr class="odd">
<td align="left">bp.1s</td>
<td align="left">SBP1</td>
</tr>
<tr class="even">
<td align="left">bp.2s</td>
<td align="left">SBP2</td>
</tr>
</tbody>
</table>

#### Syntax for data.frame

    Diabetes <- read.csv("http://192.38.117.59/~tag/Teaching/share/data/Diabetes.csv")
    names(Diabetes) <- sub("bp.1d","DBP1",names(Diabetes))
    names(Diabetes) <- sub("bp.2d","DBP2",names(Diabetes))
    names(Diabetes) <- sub("bp.1s","SBP1",names(Diabetes))
    names(Diabetes) <- sub("bp.2s","SBP2",names(Diabetes))
    names(Diabetes)

    ##  [1] "id"       "chol"     "stab.glu" "hdl"      "ratio"    "glyhb"   
    ##  [7] "location" "age"      "gender"   "height"   "weight"   "frame"   
    ## [13] "SBP1"     "DBP1"     "SBP2"     "DBP2"     "waist"    "hip"     
    ## [19] "time.ppn"

</div>
     [1] "id"       "chol"     "stab.glu" "hdl"      "ratio"    "glyhb"    "location" "age"     
     [9] "gender"   "height"   "weight"   "frame"    "SBP1"     "DBP1"     "SBP2"     "DBP2"    
    [17] "waist"    "hip"      "time.ppn"

#### Syntax data.table

    Diabetes <- fread("http://192.38.117.59/~tag/Teaching/share/data/Diabetes.csv")
    setnames(Diabetes,
         c("bp.1d","bp.2d","bp.1s","bp.2s"),
         c("DBP1","DBP2","SBP1","SBP2"))
    names(Diabetes)

    ##  [1] "id"       "chol"     "stab.glu" "hdl"      "ratio"    "glyhb"   
    ##  [7] "location" "age"      "gender"   "height"   "weight"   "frame"   
    ## [13] "SBP1"     "DBP1"     "SBP2"     "DBP2"     "waist"    "hip"     
    ## [19] "time.ppn"

### Labelling of factor variables

    Diabetes$Location <- factor(Diabetes$location,
                    levels=c("Buckingham","Louisa"),
                    labels=c("BH","L"))
    Diabetes$sex <- factor(Diabetes$gender,
                  levels=c("female","male"),
                  labels=c("Female","Male"))
    Diabetes$Frame <- factor(Diabetes$frame,
                 levels=c("large","medium","small"),
                 labels=c("III","II","I"))
    head(Diabetes[,c("Location","location","gender","sex","frame","Frame")])

    ##    Location   location gender    sex  frame Frame
    ## 1:       BH Buckingham female Female medium    II
    ## 2:       BH Buckingham female Female  large   III
    ## 3:       BH Buckingham female Female  large   III
    ## 4:       BH Buckingham   male   Male  large   III
    ## 5:       BH Buckingham   male   Male medium    II
    ## 6:       BH Buckingham   male   Male  large   III

### Setting the reference category of a factor

#### Before

    levels(Diabetes$Frame)

    ## [1] "III" "II"  "I"

#### Apply change

    Diabetes$Frame <- relevel(Diabetes$Frame,"II")

#### After

    levels(Diabetes$Frame)

    ## [1] "II"  "III" "I"

### Merging / combining factor levels

    Diabetes$Frame2 <- Diabetes$Frame
    levels(Diabetes$Frame2) <- list("I/II"=c("I","II"),"III"="III")
    levels(Diabetes$Frame2)

    ## [1] "I/II" "III"

    table(Diabetes$Frame2,Diabetes$Frame)

    ##       
    ##         II III   I
    ##   I/II 184   0 104
    ##   III    0 103   0

Creating new variables
----------------------

### Calculating the difference between two variables

We calculate the difference for each person between the second and the
first measurements of the systolic blood pressure and save the result in
a new variable which we call "deltaSBP":

#### Syntax for data.frame

    Diabetes <- read.csv("http://192.38.117.59/~tag/Teaching/share/data/Diabetes.csv")
    Diabetes$deltaSBP <- Diabetes$bp.2s-Diabetes$bp.1s
    tail(Diabetes[,c("bp.1s","bp.2s","deltaSBP")])

    ##     bp.1s bp.2s deltaSBP
    ## 398   218   238       20
    ## 399   138   130       -8
    ## 400   140   146        6
    ## 401   120    NA       NA
    ## 402   120    NA       NA
    ## 403   100    NA       NA

#### Syntax for data.table

    library(data.table)
    Diabetes <- fread("http://192.38.117.59/~tag/Teaching/share/data/Diabetes.csv")
    Diabetes[,deltaSBP:=bp.2s-bp.1s]
    tail(Diabetes[,.(bp.1s,bp.2s,deltaSBP)])

    ##    bp.1s bp.2s deltaSBP
    ## 1:   218   238       20
    ## 2:   138   130       -8
    ## 3:   140   146        6
    ## 4:   120    NA       NA
    ## 5:   120    NA       NA
    ## 6:   100    NA       NA

### Calculating the product or ratio between two variables

#### Syntax for data.frame

    Diabetes <- read.csv("http://192.38.117.59/~tag/Teaching/share/data/Diabetes.csv")
    Diabetes$ratioSBP <- Diabetes$bp.2s/Diabetes$bp.1s
    Diabetes$prodSBP <- Diabetes$bp.2s*Diabetes$bp.1s
    tail(Diabetes[,c("bp.1s","bp.2s","ratioSBP","prodSBP")])

    ##     bp.1s bp.2s ratioSBP prodSBP
    ## 398   218   238 1.091743   51884
    ## 399   138   130 0.942029   17940
    ## 400   140   146 1.042857   20440
    ## 401   120    NA       NA      NA
    ## 402   120    NA       NA      NA
    ## 403   100    NA       NA      NA

#### Syntax for data.table

    library(data.table)
    Diabetes <- fread("http://192.38.117.59/~tag/Teaching/share/data/Diabetes.csv")
    Diabetes[,ratioSBP:=bp.2s/bp.1s]
    Diabetes[,prodSBP:=bp.2s*bp.1s]
    tail(Diabetes[,c("bp.1s","bp.2s","ratioSBP","prodSBP"),with=FALSE])

    ##    bp.1s bp.2s ratioSBP prodSBP
    ## 1:   218   238 1.091743   51884
    ## 2:   138   130 0.942029   17940
    ## 3:   140   146 1.042857   20440
    ## 4:   120    NA       NA      NA
    ## 5:   120    NA       NA      NA
    ## 6:   100    NA       NA      NA

### Transforming anthropometric measurements

In the Diabetes data set, the person "weight" is given in pounds and the
person "height" in inches. We calculate the weight in kilogram and the
height in meters and save the results as new variables of the Diabetes
data set which we call "weight.kg" and "height.m", respectively:

<div class="org-src-container">


    Diabetes <- read.csv("http://192.38.117.59/~tag/Teaching/share/data/Diabetes.csv")
    Diabetes$height.m = Diabetes$height*0.0254
    Diabetes$weight.kg = Diabetes$weight* 0.4535929
    tail(Diabetes[,c("height","height.m","weight","weight.kg")])

    ##     height height.m weight weight.kg
    ## 398     61   1.5494    115  52.16318
    ## 399     69   1.7526    173  78.47157
    ## 400     63   1.6002    154  69.85331
    ## 401     69   1.7526    167  75.75001
    ## 402     63   1.6002    197  89.35780
    ## 403     64   1.6256    220  99.79044

### Calculating the BMI based on weight and height

We calculate the BMI in kg/m<sup>2</sup> and save the result as a new
variable to the Diabetes data set. The new is called "BMI":

    Diabetes$BMI = Diabetes$weight.kg/(Diabetes$height.m^2)
    tail(Diabetes[,c("height","height.m","weight","weight.kg","BMI")])

    ##     height height.m weight weight.kg      BMI
    ## 398     61   1.5494    115  52.16318 21.72886
    ## 399     69   1.7526    173  78.47157 25.54740
    ## 400     63   1.6002    154  69.85331 27.27963
    ## 401     69   1.7526    167  75.75001 24.66136
    ## 402     63   1.6002    197  89.35780 34.89667
    ## 403     64   1.6256    220  99.79044 37.76257

        height height.m weight weight.kg      BMI
    398     61   1.5494    115  52.16318 21.72886
    399     69   1.7526    173  78.47157 25.54740
    400     63   1.6002    154  69.85331 27.27963
    401     69   1.7526    167  75.75001 24.66136
    402     63   1.6002    197  89.35780 34.89667
    403     64   1.6256    220  99.79044 37.76257

### Categorizing age using user defined cut-offs

    Diabetes$ageGroup <- cut(Diabetes$age,
                 breaks=c(0,30,50,75,Inf),
                 labels=c("<30","30-50","50-75",">75"))
    table(Diabetes$ageGroup)

    ## 
    ##   <30 30-50 50-75   >75 
    ##    75   167   140    21

### Dichotomizing a continuous variable based on a single cut-off value

We calculate a new variable which takes the value "not present" when the
first systolic blood pressure measurement is below 140 and the value
"present" otherwise and save the result in a new variable which we call
hypertension.1:

    #Diabetes <- read.csv("http://192.38.117.59/~tag/Teaching/share/data/Diabetes.csv")
    Diabetes$hypertension.1 <- factor(Diabetes$bp.1s>140,labels=c("not present","present"))
    # alternative: 
    Diabetes$hypertension.1a <- cut(Diabetes$bp.1s,c(0,140,1000),labels=c("not present","present"))
    table(Diabetes$hypertension.1)

    ## 
    ## not present     present 
    ##         267         131

### Categorizing a continuous variable using several data independent cut-offs

We categorize the BMI into three groups based on the cut-off values 25
and 30, label the groups "normal", "overweight", "obese" and save the
result as a new variable which we call "BMIcat":

    Diabetes$BMIcat = cut(Diabetes$BMI,c(0,25,30,100),labels=c("normal","overweight","obese"))
    table(Diabetes$BMIcat)

    ## 
    ##     normal overweight      obese 
    ##        122        123        152

Note: With this code the exact value "25" belongs to normal and the
exact value "30" belongs to obese. If instead you want that "25" belongs
to "overweight" and "30" to "obsese" just change the value of the
argument "right" to "FALSE" (by default right is set to "TRUE"):

    Diabetes$BMIcat = cut(Diabetes$BMI,c(0,25,30,100),labels=c("normal","overweight","obese"),right=FALSE)

### Categories based on empirical quantiles

We categorize the age into 4 groups defined by the quantiles of the age
distribution and save the result as a new variable which we call
"agecat":

    Diabetes$agecat = cut(Diabetes$age,quantile(Diabetes$age),include.lowest=TRUE)
    table(Diabetes$agecat)

    ## 
    ## [19,34] (34,45] (45,60] (60,92] 
    ##     102     107     102      92

IMPORTANT: Note, the value "TRUE" of the argument "include.lowest" makes
sure that the person who has the smallest age in the data set is
included in the lowest age group. Otherwise this person would have a
missing value for the variable agecat.

We can introduce nicer labels and save the result in a new variable
which we call "AgeCat" (note the difference in case between agecat and
AgeCat, R is case sensitiv).

    Diabetes$AgeCat = cut(Diabetes$age,
                  quantile(Diabetes$age),
                  include.lowest=TRUE,
                  labels=c("<34","35-45","46-60",">60"))
    table(Diabetes$AgeCat)

    ## 
    ##   <34 35-45 46-60   >60 
    ##   102   107   102    92

### Dichotomizing a character or categorical variable

#### Creating a 0/1 variable based on a categorical variable

The variable `location` has two values "Buckingham" and "Louisa". Here
we aim to transform the variable into a numeric variable such that
`1=Buckingham` and `0=Louisa`. The following statements both do this in
a `data.frame`

    Diabetes <- data.frame(Diabetes)
    Diabetes$loc01 <- as.numeric(Diabetes$location=="Buckingham")
    Diabetes$loc01 <- 1*(Diabetes$location=="Buckingham")
    set.seed(47)
    Diabetes[sample(1:NROW(Diabetes),size=5),c("loc01","location")]

    ##     loc01   location
    ## 394     0     Louisa
    ## 151     1 Buckingham
    ## 306     0     Louisa
    ## 329     1 Buckingham
    ## 229     1 Buckingham

and here are the corresponing statements in `data.table`

    library(data.table)
    Diabetes <- setDT(Diabetes)
    Diabetes[,loc01:=as.numeric(location=="Buckingham")]
    Diabetes[,loc01:=1*(location=="Buckingham")]
    set.seed(47)
    Diabetes[sample(1:NROW(Diabetes),size=5),.(loc01,location)]

    ##    loc01   location
    ## 1:     0     Louisa
    ## 2:     1 Buckingham
    ## 3:     0     Louisa
    ## 4:     1 Buckingham
    ## 5:     1 Buckingham

### Log-transformation (basis e)

We compute the logarithm naturalis of the variable hdl and add the
result as a new variable to the data set. The variable is called
R<sub>SRC</sub>{log.hdl}:

    Diabetes$log.hdl <- log(Diabetes$hdl)
    head(Diabetes[,c("hdl","log.hdl")])

    ##    hdl  log.hdl
    ## 1:  56 4.025352
    ## 2:  24 3.178054
    ## 3:  37 3.610918
    ## 4:  12 2.484907
    ## 5:  28 3.332205
    ## 6:  69 4.234107

The basis of the logarithm is the number e:

    exp(1)

    ## [1] 2.718282

### Log10

    Diabetes$log10.hdl <- log(Diabetes$hdl,base=10)
    head(Diabetes[,c("hdl","log10.hdl")])

    ##    hdl log10.hdl
    ## 1:  56  1.748188
    ## 2:  24  1.380211
    ## 3:  37  1.568202
    ## 4:  12  1.079181
    ## 5:  28  1.447158
    ## 6:  69  1.838849

### log2

    Diabetes$log2.hdl <- log(Diabetes$hdl,base=2)
    head(Diabetes[,c("hdl","log2.hdl")])

    ##    hdl log2.hdl
    ## 1:  56 5.807355
    ## 2:  24 4.584963
    ## 3:  37 5.209453
    ## 4:  12 3.584963
    ## 5:  28 4.807355
    ## 6:  69 6.108524

Dates
-----

### Create some data in character/string format

Create a data frame called `dd` which contains three variables
`birthday` (date of birth) `diagdate` (date of diagnosis) and
`lastcontact`.

    dd <- data.frame(birthday=c("1978-08-23","1917-01-15","1929-09-05","1931-03-22"),
             diagdate=c("2001-10-27","2003-11-08","2004-09-01","1997-09-28"),
             lastcontact=c("03/08/2011","26/11/2003","03/09/2006","19/12/2001"))
    str(dd)

    ## 'data.frame':    4 obs. of  3 variables:
    ##  $ birthday   : Factor w/ 4 levels "1917-01-15","1929-09-05",..: 4 1 2 3
    ##  $ diagdate   : Factor w/ 4 levels "1997-09-28","2001-10-27",..: 2 3 4 1
    ##  $ lastcontact: Factor w/ 4 levels "03/08/2011","03/09/2006",..: 1 4 2 3

### Date conversion

Convert the variables `diagdate` (date of diagnosis) and `lastcontact`
(date of last contact) to date format and then compute the difference
(number of days).

Since data are currently in factor format (see result of `str(dd)`
above), we first convert to character and then to date format.

    dd$birthday <- as.Date(as.character(dd$birthday),format="%Y-%m-%d")
    dd$diagdate <- as.Date(as.character(dd$diagdate),format="%Y-%m-%d")
    dd$lastcontact <- as.Date(as.character(dd$lastcontact),format="%d/%m/%Y")
    str(dd)

    ## 'data.frame':    4 obs. of  3 variables:
    ##  $ birthday   : Date, format: "1978-08-23" "1917-01-15" ...
    ##  $ diagdate   : Date, format: "2001-10-27" "2003-11-08" ...
    ##  $ lastcontact: Date, format: "2011-08-03" "2003-11-26" ...

-   NOTE: If the dates were stored in a format which involves names of
    the months, for example, "11/aug/01" the format argument would be
    "%d/%b/%y" as in `as.Date("11/aug/01","%d/%b/%y")` but the result
    would depend on the language of the computer (see `help(as.Date)`).

### Computing differences between dates in days or years

    dd$age.days <- dd$diagdate-dd$birthday
    dd$age <- dd$age.days/365.25
    dd$futime <- dd$lastcontact-dd$diagdate
    dd$time <- as.numeric(dd$lastcontact-dd$diagdate)
    head(dd)

    ##     birthday   diagdate lastcontact   age.days           age    futime
    ## 1 1978-08-23 2001-10-27  2011-08-03  8466 days 23.17864 days 3567 days
    ## 2 1917-01-15 2003-11-08  2003-11-26 31708 days 86.81177 days   18 days
    ## 3 1929-09-05 2004-09-01  2006-09-03 27390 days 74.98973 days  732 days
    ## 4 1931-03-22 1997-09-28  2001-12-19 24297 days 66.52156 days 1543 days
    ##   time
    ## 1 3567
    ## 2   18
    ## 3  732
    ## 4 1543
