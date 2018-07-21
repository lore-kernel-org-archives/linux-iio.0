Return-Path: <SRS0=33t+=KF=gmail.com=daniel.baluta@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHp75VegzWr8Q2idzAWpc5Nw3T5n=vWkMvspe0YGRwEQ_h0p+A@mail.gmail.com>
References: <1532122284-19602-1-git-send-email-himanshujha199640@gmail.com>
 <20180721161934.75066d97@archlinux> <20180721153607.GA11127@himanshu-Vostro-3559>
 <CAHp75VegzWr8Q2idzAWpc5Nw3T5n=vWkMvspe0YGRwEQ_h0p+A@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Sat, 21 Jul 2018 20:45:34 +0300
Message-ID: <CAEnQRZC80FWN9EADvE9geu773=vwRmE0JEwSfy_DMjig0d=qqw@mail.gmail.com>
Subject: Re: [PATCH v4] iio: chemical: Add support for Bosch BME680 sensor
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Himanshu Jha <himanshujha199640@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jul 21, 2018 at 6:43 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Jul 21, 2018 at 6:36 PM, Himanshu Jha
> <himanshujha199640@gmail.com> wrote:
>
>>> > +   /* Look up table 1 for the possible gas range values */
>>> > +   u32 lookupTable1[16] = {2147483647u, 2147483647u, 2147483647u,
>>> > +                           2147483647u, 2147483647u, 2126008810u,
>>> > +                           2147483647u, 2130303777u, 2147483647u,
>>> > +                           2147483647u, 2143188679u, 2136746228u,
>>> > +                           2147483647u, 2126008810u, 2147483647u,
>>> > +                           2147483647u};
>
> This one needs perhaps a bit of though, but...
>
>>> > +   /* Look up table 2 for the possible gas range values */
>>> > +   u32 lookupTable2[16] = {4096000000u, 2048000000u, 1024000000u,
>>> > +                           512000000u, 255744255u, 127110228u, 64000000u,
>>> > +                           32258064u, 16016016u, 8000000u, 4000000u,
>>> > +                           2000000u, 1000000u, 500000u, 250000u, 125000u};
>
> ...this one obviously just a not needed one. You may replace it with a
> one constant and simple calculation to get either value (index from
> value, or value from index).

Indeed this can be reduce to:

125.000 << (15 - idx).

The real question here is if we approximate 255.744.255u to 256.00.00u how
much different is the result. Being a gas sensor I think it is very
hard to appreciate.

We can go with this formula + adding a comment with the table with the
exact coefficients.

thanks,
Daniel.
