Return-Path: <SRS0=PgMb=KF=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180721153607.GA11127@himanshu-Vostro-3559>
References: <1532122284-19602-1-git-send-email-himanshujha199640@gmail.com>
 <20180721161934.75066d97@archlinux> <20180721153607.GA11127@himanshu-Vostro-3559>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 21 Jul 2018 18:43:51 +0300
Message-ID: <CAHp75VegzWr8Q2idzAWpc5Nw3T5n=vWkMvspe0YGRwEQ_h0p+A@mail.gmail.com>
Subject: Re: [PATCH v4] iio: chemical: Add support for Bosch BME680 sensor
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-iio <linux-iio@vger.kernel.org>,
	Daniel Baluta <daniel.baluta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jul 21, 2018 at 6:36 PM, Himanshu Jha
<himanshujha199640@gmail.com> wrote:

>> > +   /* Look up table 1 for the possible gas range values */
>> > +   u32 lookupTable1[16] = {2147483647u, 2147483647u, 2147483647u,
>> > +                           2147483647u, 2147483647u, 2126008810u,
>> > +                           2147483647u, 2130303777u, 2147483647u,
>> > +                           2147483647u, 2143188679u, 2136746228u,
>> > +                           2147483647u, 2126008810u, 2147483647u,
>> > +                           2147483647u};

This one needs perhaps a bit of though, but...

>> > +   /* Look up table 2 for the possible gas range values */
>> > +   u32 lookupTable2[16] = {4096000000u, 2048000000u, 1024000000u,
>> > +                           512000000u, 255744255u, 127110228u, 64000000u,
>> > +                           32258064u, 16016016u, 8000000u, 4000000u,
>> > +                           2000000u, 1000000u, 500000u, 250000u, 125000u};

...this one obviously just a not needed one. You may replace it with a
one constant and simple calculation to get either value (index from
value, or value from index).

-- 
With Best Regards,
Andy Shevchenko
