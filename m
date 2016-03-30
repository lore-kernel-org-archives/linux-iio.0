Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:44409 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758514AbcC3HsG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 30 Mar 2016 03:48:06 -0400
Date: Wed, 30 Mar 2016 09:48:01 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Linus Walleij <linus.walleij@linaro.org>
cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] iio: light: new driver for the ROHM BH1780
In-Reply-To: <CACRpkdYQ1tZdfQew456Q1iFT=MO_2PB_fBPaE_wd5XqKO8cs-w@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1603300946280.14313@pmeerw.net>
References: <1459261653-13070-1-git-send-email-linus.walleij@linaro.org> <alpine.DEB.2.02.1603291632370.16868@pmeerw.net> <CACRpkdYQ1tZdfQew456Q1iFT=MO_2PB_fBPaE_wd5XqKO8cs-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> >> +     case IIO_CHAN_INFO_SCALE:
> >> +             /* Returns raw lux value */
> >> +             *val = 1;
> >
> > not needed to scale by 1.0
> >
> >> +             *val2 = 0;
> >> +             return IIO_VAL_INT;
> 
> How do you mean?
> If I don't implement this (just let this function return negative)
> this happens:
> 
> iio:device1 ls
> dev                              of_node
> in_illuminance_integration_time  power
> in_illuminance_raw               subsystem
> in_illuminance_scale             uevent
> 
> iio:device1 cat in_illuminance_scale
> cat: read error: Invalid argument
> 
> Do you mean all userspace programs should assume scale by 1x
> if they get an error when they try to read the scale file, or is there
> a bug in IIO such that this file should return "1" if the callback asking for
> IIO_CHAN_INFO_SCALE returns negative?

IIO_CHAN_INFO_SCALE is optional, if it is not given 1.0 is to be assumed

you do not give _OFFSET as well and assume that offset is 0.0 when 
interpreting _RAW

p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
