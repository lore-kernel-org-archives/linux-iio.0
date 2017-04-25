Return-Path: <SRS0=0oUH=4B=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1493119630.24567.192.camel@linux.intel.com>
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Sascha Weisenberger
 <sascha.weisenberger@siemens.com>
Date: Tue, 25 Apr 2017 14:27:10 +0300
In-Reply-To: <08d40bf0-4e68-d763-af99-be1f60e369fc@siemens.com>
References: <6e0f0b52-27a1-0ce5-c217-3aa941babe63@siemens.com>
	 <1493064330.24567.180.camel@linux.intel.com>
	 <dcba0513-e3c2-33f2-6cc9-c23d05a7e6ba@siemens.com>
	 <CAHp75VfzH922Z5FfGQ7gS-+FLR7H_Q3mKm_58xmchZn5KEjiqQ@mail.gmail.com>
	 <38f562f3-69d2-67d0-ecc2-4b44d67286e2@siemens.com>
	 <CAHp75Vf517+vfe7GiTH2Gb0WBDdqi4fcR5Z1O6ideJMpbDhysw@mail.gmail.com>
	 <08d40bf0-4e68-d763-af99-be1f60e369fc@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Tue, 2017-04-25 at 12:53 +0200, Jan Kiszka wrote:
> On 2017-04-25 11:42, Andy Shevchenko wrote:


> > > Where is a good example? Sorry,
> > > I still don't see how to make code out of your comments.
> > 
> > Mostly remove those ugly hacks and start over.
> 
> Still not a constructive answer.

You just didn't get.

Provide a driver without that ugly code and then we may think how to
make it work on existing boards without too much intrusion here or
there.

> > CS is a property of the host controller, not the slave devices.
> > 
> > Once I pointed to Mika's work for Galileo, perhaps you forgot. The
> > below is an example how to fix ACPI table using
> > 
> > https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acpi-ta
> > bles/samples/galileo/spi.asl
> > 
> > It's done for SPI1, but you easily can convert it to SPI0 and
> > corresponding properties.
> 
> So that information would be picked up by the existing SPI host
> controller driver, and we don't need anything beyond basic ACPI
> support
> in this driver?

Correct!

>  That is indeed appealing. Maybe we can make the board
> patch private then, until a firmware update is available. I'll split
> that part off.

Yes, that is what I meant.

> > Btw, we welcome any contribution to meta-acpi repository!
> 
> Shipping own DSDTs is no long-term path: we would be forced to provide
> separate images due to a single parameter being different in the DSDTs
> of the 2020 and 2040. And you cannot provide any overlay to adjust the
> table after boot, i.e. once we know on which board we are.
> 
> The dependency on meta-intel is also suboptimal (we will switch to a
> long-term supported kernel source soon), but that would probably be
> fixable.

Mika, do you have anything to comment on the above?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
