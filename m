Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728476AbeIVVGF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Sep 2018 17:06:05 -0400
Date: Sat, 22 Sep 2018 16:12:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: Song Qiang <songqiang1304521@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, andriy.shevchenko@linux.intel.com,
        matt.ranostay@konsulko.com, tglx@linutronix.de, ak@it-klinger.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] iio: proximity: Add driver support for ST's
 VL53L0X ToF ranging sensor.
Message-ID: <20180922161205.63d3f4cf@archlinux>
In-Reply-To: <20180922145658.GA4443@himanshu-Vostro-3559>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
        <20180922154658.752f2fbf@archlinux>
        <20180922145658.GA4443@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 22 Sep 2018 20:26:58 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Sat, Sep 22, 2018 at 03:46:58PM +0100, Jonathan Cameron wrote:
> > On Tue, 18 Sep 2018 16:24:21 +0800
> > Song Qiang <songqiang1304521@gmail.com> wrote:
> >   
> > > This driver was originally written by ST in 2016 as a misc input device
> > > driver, and hasn't been maintained for a long time. I grabbed some code
> > > from it's API and reformed it into an iio proximity device driver.
> > > This version of driver uses i2c bus to talk to the sensor and
> > > polling for measuring completes, so no irq line is needed.
> > > It can be tested with reading from
> > > /sys/bus/iio/devices/iio:deviceX/in_distance_input
> > > 
> > > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>  
> > There are a few bits and bobs in here, but as they are all minor and
> > one at least was me giving you wrong advise, I've fixed it up.
> > 
> > Please check I haven't made a mess of it! 
> > 
> > Applied with changes to the togreg branch of iio.git and pushed out
> > as testing (where it should be visible now) for the autobuilders to
> > play with it.  
> 
> The SPDX license identifier is inconsistent!
> 
> > +// SPDX-License-Identifier: GPL-2.0+  
> 
> > +MODULE_LICENSE("GPL v2");  
> 
> 216         For 'GNU General Public License (GPL) version 2 only' use:
> 217           SPDX-License-Identifier: GPL-2.0
> 218         For 'GNU General Public License (GPL) version 2 or any later version' use:
> 219           SPDX-License-Identifier: GPL-2.0+
> 
> 
Good spot.

I'll fix that up as well.

I'll assume the MODULE_LICENCE is right for now as it seems likely to have come
from the original ST code.

Jonathan
