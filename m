Return-Path: <gregor.boirie@parrot.com>
Message-ID: <572224EA.2040303@parrot.com>
Date: Thu, 28 Apr 2016 16:57:46 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen
	<lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Denis Ciocca
	<denis.ciocca@st.com>, Giuseppe Barba <giuseppe.barba@st.com>
Subject: Re: [RFC PATCH v1 0/9] iio:st_sensors: fixes and lps22hb pressure
 sensor
References: <cover.1461056711.git.gregor.boirie@parrot.com>	<CACRpkdZxE4Z6f_0uVV0sD5EUxEigzbMvWRD+MTDWNZbuauVweg@mail.gmail.com>	<CACRpkdZ=DSEKi6dOBuxA23ivsQYsoigvG_cC11HR-66aN_BUpQ@mail.gmail.com>	<5720B9DA.1000409@parrot.com> <CACRpkdY08X6O=OukhngMR_EKp-gsy=_H7dp1ifm9P7yFto4PLw@mail.gmail.com>
In-Reply-To: <CACRpkdY08X6O=OukhngMR_EKp-gsy=_H7dp1ifm9P7yFto4PLw@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------020500070906030904080705"
List-ID: <linux-iio@vger.kernel.org>

--------------020500070906030904080705
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 04/28/2016 09:47 AM, Linus Walleij wrote:
> On Wed, Apr 27, 2016 at 3:08 PM, Gregor Boirie <gregor.boirie@parrot.com> wrote:
>
>> Many thanks for taking time to test this. ~95 kPa seems rather a small value
>> to me.
>>
>> For reference, it seems 950 hPa at sea level would be found under a...
>> hurricane !
>> (may vary with location)
>>
>> Does it match with your local weather forecast / report ?
> Hmmmm no :)
>
> Checking with local weather site it should be ~1006 hPa.
>
> Do you think the sensor is just badly calibrated?

Amongst significant error sources, we regularly struggle against:
* soldering (mechanical, overheat)
* pcb bending and vibrations
* bad device lots, bad storage (esd, wrong calibration, nearby mechanical vibration sources like ultra-sound...)
* electrical noise (power supply, ground...)
* light intensity if not protected by a cover
* temperature, air flow
* probably others we are not aware of yet

All comes with various effects in terms of constant offset, noise and drift. Some are destructive, some are not.
Welcome to world of MEMS :)

> I tested now with another sensor on the Snowball board.
> It gives (after scaling):
>
> 101.4
> 28.8
> 101.9
> 28.8
> 101.9
> 29.5
>
> This sensor seems more accurate wrt pressure.
> However here instead the temperature seems bananas,
> this is a Swedish office, we don't have ~30degrees here...
> And it's not the board is just turned on so I don't think it's
> that warm.
For pressure, LPS001WP may sample with typical absolute error up to 
+/-25 mBar and resolution of
one 16th mBar : not consistent with your first results of ~95 kPa, but 
should comply with pressure
sampling gain modified in patch 4.
No typical accuracy is given for temperature, and resolution is one 64th 
of degree Celsius. I suppose
temperature gain applied in patch 4 is also compliant with all your results.
As a reference for comparison, temperature accuracy for LPS22HB, which 
is much more precise, is +/-1.5
degree Celsius...

So I simply suggest your erroneous results are not induced by wrong 
software sampling gains, which was
my primary fear. No more no less. Maybe Denis may be of any help once he 
has some time to review the
whole patch series.

>   One sensor gives believeable pressure, the other
> gives believeable temperature...
>
> The data sheet says this sensor is calibrated for two
> pressure+temperature combinations at manufacturing.
> I wonder if there are "secret registers" in the device that
> can update the calibration...
As this device is deprecated I suppose we won't get much support from 
ST... Maybe Denis may help if
this really worth the pain :)
>
> Anyways, the measures are not totally off scale so
> I guess they are in the right ballpark. And these patches
> makes it work better for sure.
>
> Yours,
> Linus Walleij
I do greatly appreciate your feedback. Many thanks.
Regards,
greg

--------------020500070906030904080705
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    On 04/28/2016 09:47 AM, Linus Walleij wrote:<br>
    <blockquote
cite="mid:CACRpkdY08X6O=OukhngMR_EKp-gsy=_H7dp1ifm9P7yFto4PLw@mail.gmail.com"
      type="cite">
      <pre wrap="">On Wed, Apr 27, 2016 at 3:08 PM, Gregor Boirie <a class="moz-txt-link-rfc2396E" href="mailto:gregor.boirie@parrot.com">&lt;gregor.boirie@parrot.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="">Many thanks for taking time to test this. ~95 kPa seems rather a small value
to me.

For reference, it seems 950 hPa at sea level would be found under a...
hurricane !
(may vary with location)

Does it match with your local weather forecast / report ?
</pre>
      </blockquote>
      <pre wrap="">
Hmmmm no :)

Checking with local weather site it should be ~1006 hPa.

Do you think the sensor is just badly calibrated?</pre>
    </blockquote>
    <br>
    <pre wrap="">Amongst significant error sources, we regularly struggle against:
* soldering (mechanical, overheat)
* pcb bending and vibrations
* bad device lots, bad storage (esd, wrong calibration, nearby mechanical vibration sources like ultra-sound...)
* electrical noise (power supply, ground...)
* light intensity if not protected by a cover
* temperature, air flow
* probably others we are not aware of yet

All comes with various effects in terms of constant offset, noise and drift. Some are destructive, some are not.
Welcome to world of MEMS :)
</pre>
    <blockquote
cite="mid:CACRpkdY08X6O=OukhngMR_EKp-gsy=_H7dp1ifm9P7yFto4PLw@mail.gmail.com"
      type="cite">
      <pre wrap="">I tested now with another sensor on the Snowball board.
It gives (after scaling):

101.4
28.8
101.9
28.8
101.9
29.5

This sensor seems more accurate wrt pressure.
However here instead the temperature seems bananas,
this is a Swedish office, we don't have ~30degrees here...
And it's not the board is just turned on so I don't think it's
that warm.</pre>
    </blockquote>
    <tt>For pressure, </tt><tt>LPS001WP may sample with typical
      absolute error up to +/-25 mBar and resolution of<br>
      one 16th mBar : not consistent with your first results of ~95 kPa,
      but should comply with pressure<br>
      sampling gain modified in patch 4.<br>
      No typical accuracy is given for temperature, and resolution is
      one 64th of degree Celsius. I suppose<br>
      temperature gain applied in patch 4 is also compliant with all
      your results.<br>
      As a reference for comparison, temperature accuracy for LPS22HB,
      which is much more precise, is +/-1.5<br>
      degree Celsius...<br>
      <br>
      So I simply suggest your erroneous results are not induced by
      wrong software sampling gains, which was<br>
      my primary fear. No more no less. Maybe Denis may be of any help
      once he has some time to review the<br>
      whole patch series.<br>
    </tt><br>
    <blockquote
cite="mid:CACRpkdY08X6O=OukhngMR_EKp-gsy=_H7dp1ifm9P7yFto4PLw@mail.gmail.com"
      type="cite">
      <pre wrap=""> One sensor gives believeable pressure, the other
gives believeable temperature...

The data sheet says this sensor is calibrated for two
pressure+temperature combinations at manufacturing.
I wonder if there are "secret registers" in the device that
can update the calibration...</pre>
    </blockquote>
    <tt>As this device is deprecated I suppose we won't get much support
      from ST... Maybe Denis may help if<br>
      this really worth the pain :)<br>
    </tt>
    <blockquote
cite="mid:CACRpkdY08X6O=OukhngMR_EKp-gsy=_H7dp1ifm9P7yFto4PLw@mail.gmail.com"
      type="cite">
      <pre wrap="">

Anyways, the measures are not totally off scale so
I guess they are in the right ballpark. And these patches
makes it work better for sure.

Yours,
Linus Walleij
</pre>
    </blockquote>
    <tt>I do greatly appreciate your feedback. Many th</tt><tt>anks.</tt><tt><br>
    </tt><tt>Regards,</tt><tt><br>
    </tt><tt>greg</tt><font face="Times New Roman, Times, serif"><br>
    </font>
  </body>
</html>

--------------020500070906030904080705--
