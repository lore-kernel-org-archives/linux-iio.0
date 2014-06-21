Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41144 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758051AbaFUHza (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jun 2014 03:55:30 -0400
Date: Sat, 21 Jun 2014 09:55:22 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Kristina =?utf-8?Q?Mart=C5=A1enko?=
	<kristina.martsenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: IIO drivers left in drivers/staging/
Message-ID: <20140621075522.GY19375@piout.net>
References: <20140611013007.GA32756@kroah.com>
 <f0db211a-bf69-4a3e-beda-2101af74ae25@email.android.com>
 <53998D43.9020209@gmail.com>
 <53A1895A.4090209@gmail.com>
 <alpine.DEB.2.01.1406181445290.28014@pmeerw.net>
 <20140618174717.GC11977@kroah.com>
 <20140619125416.GT19375@piout.net>
 <20140620204248.GF16973@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140620204248.GF16973@kroah.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/06/2014 at 13:42:48 -0700, Greg KH wrote :
> > 
> > I would say that the latest addition to the TODO file is quite valid ;)
> > We have been looking at moving the mxs-lradc out of staging for a while
> > now. It still has a few contributions coming from time to time and can
> > definitely be improved. The main thing to do would be to create an MFD.
> > 
> > I understand this may be a considerable amount of work but it has the
> > advantage of allowing to have a look at at least 3 different subsystems.
> > 
> > I am willing to review and test patches.
> > 
> > I would suggest that board:
> > http://www.crystalfontz.com/product/CFA921TS
> > 
> > It may not be the cheapeast one but it has good mainline support and I
> > know it well.
> 
> What sensors does it have on it that are iio drivers that need fixing
> up?
> 

It is i.mx28 based so it has the mxs LRADC which is currently supported
through drivers/staging/iio/adc/mxs-lradc.c.
It is also a touchscreen controller, a temperature sensor and a battery
voltage monitor so it would make sense to create an mfd and move the
touchscreen part in the input subsystem and add a driver for the voltage
monitor in the power subsystem.

You can also have a look at that thread:
http://www.spinics.net/lists/linux-iio/msg11004.html

> It's not that expensive, my budget for Linux devices can cover it...
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
