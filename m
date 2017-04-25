Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:46895 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1946697AbdDYLX6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 25 Apr 2017 07:23:58 -0400
Message-ID: <1493119428.24567.190.camel@linux.intel.com>
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>
Date: Tue, 25 Apr 2017 14:23:48 +0300
In-Reply-To: <bb8ca4d3-c70b-0bc5-640a-8c7fdb49f720@siemens.com>
References: <6e0f0b52-27a1-0ce5-c217-3aa941babe63@siemens.com>
         <alpine.DEB.2.20.1704250906150.7992@vps.pmeerw.net>
         <bb8ca4d3-c70b-0bc5-640a-8c7fdb49f720@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 2017-04-25 at 11:32 +0200, Jan Kiszka wrote:
> On 2017-04-25 09:31, Peter Meerwald-Stadler wrote:

+Cc: Mika.

> > I think board-specific stuff should not go into the driver -> DT?
> 
> Unfortunately, we only have half-baked ACPI on those boards.

That's the main problem and still no excuse for uglifying code.

> > > +
> > > +#include <linux/platform_data/adc1x8s102.h>
> > 
> > who needs platform data these days :)
> 
> Apparently, quite a few devices.

New drivers are not supposed to use platform data.

> But the situation here is:
> - Existing hardware has incomplete ACPI description that needs to be
>   augmented by software.

Yes, and this software is called DSDT table in BIOS. Linux kernel has a
support for properly formed table already for few releases.

> - I'm not aware of a complete DT specification for this device. If
>   there is any somewhere, I can happily include it.

Looking to proposed code there is only one property for it, if there is
an existing binding for the same property you may just simple re-use it.

> > > +
> > > +#define ADC1x8S102_GALILEO2_CS	8
> > 
> > this board-specific detail shouldn't be here
> 
> Where should it go then?

Obviously in (properly formed) ACPI.

> no board specific stuff here please
> 
> Needed to make it work. If there is a better file to keep that, I'll
> move it.

Ideally you need BIOS fixed for that.

Otherwise you may do a separate code which would provide CS GPIO look up
table.

Mika, what do you think about fixing this in the C code for existing
devices?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
