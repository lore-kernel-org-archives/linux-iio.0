Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43581 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512AbaFKIGR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jun 2014 04:06:17 -0400
In-Reply-To: <20140611013007.GA32756@kroah.com>
References: <20140611013007.GA32756@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: IIO drivers left in drivers/staging/
From: Jonathan Cameron <jic23@kernel.org>
Date: Wed, 11 Jun 2014 09:05:58 +0100
To: Greg KH <gregkh@linuxfoundation.org>
CC: =?UTF-8?Q?Kristina_Mart=C5=A1enko?= <kristina.martsenko@gmail.com>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <f0db211a-bf69-4a3e-beda-2101af74ae25@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On June 11, 2014 2:30:07 AM GMT+01:00, Greg KH <gregkh@linuxfoundation.org> wrote:
>Hi Jonathan,
Hi Kristina/Greg.
>
>I'd really like to figure out what is left to do with all of the
>remaining IIO staging drivers, and see if we can get them all moved out
>soon.
There is a lot of each driver having its own peculiar set of little and sometimes big
 issues! We have also kind of gotten into the habbit of treating staging graduations as if
 they were initial driver submissions so proposed moves get quite a bit of review and
 that often extends the list of things to fix or improve rather a lot. Of course any help is
 welcome.

I'll reply in more detail about this later. 

For now I have cc'd Lars as he has inherited
 responsibility for a lot of AD drivers that have been around from the early days when
 things were a little loose.

If Christina is raring to get started, my notes say the lpc32xx_ADC driver needs some
 prefixes on #define constants and that is all I picked up for that driver when reviewing it
 for a staging graduation.

If not, Lars, what about looking at the resolver drivers or perhaps the CDC drivers?
 If I recall they are pretty clean and straight forward. Probably some ABI in need of
 documentation (sysfs attribute naming). If not do you have any short term suggestions?

>
>As part of the OPW intern program, Kristina has agreed to help out with
>staging kernel drivers and I thought that doing this type of work would
>be a great task.  There seems to be a number of different types of
>IIO drivers here, so that should keep her from being bored with just
>one
>specific type of sensor.  There are also some "dummy" IIO drivers,
>which
>I don't really understand what they are for (as well as why they remain
>in staging.)
Ah. There is only really one dummy driver, be it with a software interrupt driver to fake
 hardware threshold interrupts etc.

This device is basically a fake. The intent was to allow those with no hardware to hand
 to work at or understand the core of iio.
It has come in very handy as a test tool!

The other intended purpose is to act as an example of best practice and provide
 documentation of a sort.

As for why it is still in staging... It comes down to the dubious hack that provides fake event interrupts. We do it much nicer in the sysfs trigger and would like to either use that approach or find something more generic.
>
>The drivers/staging/TODO file seems pretty old, being dated back in
>2009
>and not really done much with the exception of adding one entry.

Oops
>
>So, any thoughts about what to do here?  Any pointers to devices that
>she can aquire if that needs to happen, or APIs that need to be
>standardized across types?
Most ABI bits are now to do with new stuff.
Having said that the resolver and CDC
 drivers use some ABI that is probably documented but that documentation is also
 a candidate for cleaning up and moving out of staging.

Busy day (pesky customer demo) so will get back with more concrete stuff later.
>
>thanks,
>
>greg k-h
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
