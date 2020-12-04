Stock Price Analysis App
========================================================
author: Mark Kiel
date: "2020-12-04"

Purpose and Requirements
========================================================

Create a relatively simple application that tries to
fulfill these requirements:

- Allows a user to look up a symbol on two of the largest
  American stock exchanges and get the security name.
- Plot a time series of the adjusted closing stock price
  for up to four different stock symbols.
- Choose a specific start date to compare price trends
  over the same time period.
- Lets a user enable and disable a specific plot just
  by checking a box.

Demo: Choosing a Stock Symbol
========================================================

<br />
<span style="font-size:20px;margin-bottom:0px">Symbol lookup</span>
<div style="margin-top:-32px">
    <select id="symbols" onchange="updateCompany()">AAPL</select>
    <input type="radio" name="exchange"><span style="font-size:16px">Nasdaq</span></input>
    <input type="radio" name="exchange"><span style="font-size:16px">NYSE</span></input>
    <br />
    <span id="company" style="font-size:20px;color:blue">ATA Creativity Global - American Depositary Shares, each representing two common shares</span>
<br /><br />
</div>



<script>let arr = [ "AACG", "AACQ", "AACQU", "AACQW", "AAL", "AAME", "AAOI", "AAON", "AAPL", "AAWW", ];let sb = document.getElementById('symbols');for (let i = 1; i <= 10; i++) {
    option = document.createElement('option');
    option.value = i;
    option.text = arr[i-1];
    sb.appendChild(option);
}let companies = [ "ATA Creativity Global - American Depositary Shares, each representing two common shares", "Artius Acquisition Inc. - Class A Common Stock", "Artius Acquisition Inc. - Unit consisting of one ordinary share and one third redeemable warrant", "Artius Acquisition Inc. - Warrant", "American Airlines Group, Inc. - Common Stock", "Atlantic American Corporation - Common Stock", "Applied Optoelectronics, Inc. - Common Stock", "AAON, Inc. - Common Stock", "Apple Inc. - Common Stock", "Atlas Air Worldwide Holdings - Common Stock", ];function updateCompany() {
    let i = document.getElementById('symbols').value;
    document.getElementById('company').innerHTML = companies[i-1];
}</script>

<p><span style="font-size:24px">
Using the drop-down box, choose a ticker symbol and see the company name and
description below the choice. In the application, choosing the exchange type
will populate the drop-down with different choices.</span>
</p>

Demo: Viewing a Time Series Plot
========================================================

<div>
    <p><span style="font-size:24px">The application allows for up to four different
        stock symbol time series to be displayed for comparison. The start date
        is also adjustable.</span>
    </p>
</div>

![plot of chunk unnamed-chunk-1](presentation-figure/unnamed-chunk-1-1.png)

Closing Thoughts
=======================================================
<span style="font-size:24px">Finished application is at Shinyapps.io:<span>
<span style="font-size:24px">[tracermak.shinyapps.io/coursera-project](https://tracermak.shinyapps.io/coursera-project)</span>
<br />
<span style="font-size:24px">Application and presentation source on GitHub:</span>
<span style="font-size:24px">[github.com/TracerMAK/coursera-shiny-app](https://github.com/TracerMAK/coursera-shiny-app)</span>
<br /><br />
<span style="font-size:28px">Goals during application development:</span><br />
(1) Explore the various Shiny Widgets<br />
(2) Incorporate custom html and css within the markdown<br />
(3) Learn the reactive programming environment<br />
(4) Develop something that could be extended further with more features
