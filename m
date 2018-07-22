Return-Path: <SRS0=+VJK=KG=gmail.com=himanshujha199640@kernel.org>
Date: Mon, 23 Jul 2018 03:51:54 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Daniel Baluta <daniel.baluta@gmail.com>, dfrey@sierrawireless.com
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4] iio: chemical: Add support for Bosch BME680 sensor
Message-ID: <20180722222153.GA10066@himanshu-Vostro-3559>
References: <1532122284-19602-1-git-send-email-himanshujha199640@gmail.com>
 <20180721161934.75066d97@archlinux>
 <20180721153607.GA11127@himanshu-Vostro-3559>
 <CAHp75VegzWr8Q2idzAWpc5Nw3T5n=vWkMvspe0YGRwEQ_h0p+A@mail.gmail.com>
 <CAEnQRZC80FWN9EADvE9geu773=vwRmE0JEwSfy_DMjig0d=qqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEnQRZC80FWN9EADvE9geu773=vwRmE0JEwSfy_DMjig0d=qqw@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jul 21, 2018 at 08:45:34PM +0300, Daniel Baluta wrote:
> On Sat, Jul 21, 2018 at 6:43 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Jul 21, 2018 at 6:36 PM, Himanshu Jha
> > <himanshujha199640@gmail.com> wrote:
> >
> >>> > +   /* Look up table 1 for the possible gas range values */
> >>> > +   u32 lookupTable1[16] = {2147483647u, 2147483647u, 2147483647u,
> >>> > +                           2147483647u, 2147483647u, 2126008810u,
> >>> > +                           2147483647u, 2130303777u, 2147483647u,
> >>> > +                           2147483647u, 2143188679u, 2136746228u,
> >>> > +                           2147483647u, 2126008810u, 2147483647u,
> >>> > +                           2147483647u};
> >
> > This one needs perhaps a bit of though, but...
> >
> >>> > +   /* Look up table 2 for the possible gas range values */
> >>> > +   u32 lookupTable2[16] = {4096000000u, 2048000000u, 1024000000u,
> >>> > +                           512000000u, 255744255u, 127110228u, 64000000u,
> >>> > +                           32258064u, 16016016u, 8000000u, 4000000u,
> >>> > +                           2000000u, 1000000u, 500000u, 250000u, 125000u};
> >
> > ...this one obviously just a not needed one. You may replace it with a
> > one constant and simple calculation to get either value (index from
> > value, or value from index).
> 
> Indeed this can be reduce to:
> 
> 125.000 << (15 - idx).
> 
> The real question here is if we approximate 255.744.255u to 256.00.00u how
> much different is the result. Being a gas sensor I think it is very
> hard to appreciate.
> 
> We can go with this formula + adding a comment with the table with the
> exact coefficients.

So, I have planned to use this 125000 << (15 - idx) equation with
approximating the array members.

About the difference in results we would get after approximating isn't
much of a problem IMHO because gas sensor is primarily used for IAQ, and
IAQ is relative to the resistance reading.

For eg: 

Resistance(ohm)			IAQ
value < 30K			Very bad
30k < value < 50k		worse
50k < value < 70k		bad
... 
..			
so on..

So, what I simply imply is the scale will be adjusted and nothing else
changes, unlike if it had been pressure, temperature, humidity.

The IAQ implementation is userspace application suggesting
good/bad/ugly air quality.

And since we know David Frey is planning to use this sensor in his
product mangOH board.

So, David, how are you planning to use the gas sensing part in your
product ? RGB leds, buzzer, alarm ?

Thanks Andy for the suggestion :)
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
