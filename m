Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727813AbeGURWp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Jul 2018 13:22:45 -0400
Date: Sat, 21 Jul 2018 17:29:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v4] iio: chemical: Add support for Bosch BME680 sensor
Message-ID: <20180721172924.53619e6a@archlinux>
In-Reply-To: <20180721155230.GB11127@himanshu-Vostro-3559>
References: <1532122284-19602-1-git-send-email-himanshujha199640@gmail.com>
        <20180721161934.75066d97@archlinux>
        <20180721153607.GA11127@himanshu-Vostro-3559>
        <CAHp75VegzWr8Q2idzAWpc5Nw3T5n=vWkMvspe0YGRwEQ_h0p+A@mail.gmail.com>
        <20180721155230.GB11127@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 21 Jul 2018 21:22:30 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Sat, Jul 21, 2018 at 06:43:51PM +0300, Andy Shevchenko wrote:
> > On Sat, Jul 21, 2018 at 6:36 PM, Himanshu Jha
> > <himanshujha199640@gmail.com> wrote:
> >   
> > >> > +   /* Look up table 1 for the possible gas range values */
> > >> > +   u32 lookupTable1[16] = {2147483647u, 2147483647u, 2147483647u,
> > >> > +                           2147483647u, 2147483647u, 2126008810u,
> > >> > +                           2147483647u, 2130303777u, 2147483647u,
> > >> > +                           2147483647u, 2143188679u, 2136746228u,
> > >> > +                           2147483647u, 2126008810u, 2147483647u,
> > >> > +                           2147483647u};  
> > 
> > This one needs perhaps a bit of though, but...
> >   
> > >> > +   /* Look up table 2 for the possible gas range values */
> > >> > +   u32 lookupTable2[16] = {4096000000u, 2048000000u, 1024000000u,
> > >> > +                           512000000u, 255744255u, 127110228u, 64000000u,
> > >> > +                           32258064u, 16016016u, 8000000u, 4000000u,
> > >> > +                           2000000u, 1000000u, 500000u, 250000u, 125000u};  
> > 
> > ...this one obviously just a not needed one. You may replace it with a
> > one constant and simple calculation to get either value (index from
> > value, or value from index).  
> 
> Not sure to understand your opinion!?
> 
> Anything related to increase to .ro segment ?
> 
> I think adding is better to let compiler optimise the code a bit
> further.

No, I missed this as didn't look too closely at those numbers.
They are almost by not quite simple power's of 2 * 125000.
Question is whether the very very small difference from that matter or not...

Andy is suggesting replacing this block of data with an equation that is
'near enough'.
> 
> > -- 
> > With Best Regards,
> > Andy Shevchenko  
> 

