Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38390 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbcFOSs6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2016 14:48:58 -0400
Date: Wed, 15 Jun 2016 11:48:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Matt Ranostay <mranostay@gmail.com>, linux-hwmon@vger.kernel.org,
	david.frey@sensirion.com, Alison Schofield <amsfield22@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 0/2] iio: humidity: sht31: add Sensirion SHT31 support
Message-ID: <20160615184855.GA18198@roeck-us.net>
References: <1465708397-19649-1-git-send-email-mranostay@gmail.com>
 <20160613222502.GA4376@d830.WORKGROUP>
 <CAKzfze_=URjXxePW4+P_Y8OUrgoMiC90Nzr=3ey+G=ZHKsRxCA@mail.gmail.com>
 <f26e218318cd07bdb857f67b1357f36e@jic23.retrosnub.co.uk>
 <CAKzfze_LfWnorv-SagS8+0HbUiTprDFfXdAWCcTzC61TeFriYw@mail.gmail.com>
 <5760D6FD.7050604@roeck-us.net>
 <EC8BB308-9B34-4F50-9FD5-923229BE81D8@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EC8BB308-9B34-4F50-9FD5-923229BE81D8@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jun 15, 2016 at 05:31:10PM +0100, Jonathan Cameron wrote:
> 
> 
> On 15 June 2016 05:18:05 BST, Guenter Roeck <linux@roeck-us.net> wrote:
> >On 06/14/2016 12:01 PM, Matt Ranostay wrote:
> >> Hello Guenter et al,
> >>
> >> So seems I wrote an iio driver for the SHT31 chipset about the same
> >> David Frey had his merged into hwmon tree. So was wondering per
> >> Jonathan's comments what your input on this would be.
> >>
> >>>From what I can see the additional functionality of the hrtimer
> >> trigger + rather fast update/integration time that a case could be
> >> made because of the triggered buffer.
> >>
> >> Now there is some functionality missing from my iio driver than
> >exists
> >> in the hwmon.. like the thermal and humidity trip points (but that
> >can
> >> be handled in a userspace HAL anyway), and the non-clock skewing
> >> read/write functionality (this can be easily added).
> >>
> >
> >I am quite sure that we had this discussion about this very driver
> >before.
> >One of the key reasons for going with hwmon was limit register support.
> >
> >Guess you claim that is no longer relevant since it can be handled in
> >user space ?
> >If so, I would disagree; it seems to be difficult to generate an alert
> >signal
> >from user space.
> Agreed
> >
> >I don't mind if you folks want drivers for chips like like this (ie
> >chips supporting
> >limits, or in other words typical hardware monitoring chips) in iio,
> >but I would
> >kindly ask to enhance the iio subsystem to support limits.
> 
> It has done since day one via event chardev. Limitations are :
> * One per channel per type per direction. (Didn't seem necessary at the time)
> This obviously matters for hwmon chips.
> * No in kernel interface yet so not pushed on to iio-hwmon bridge.
> * Intended for interrupt type limits which do not always correspond to how all 
> devices do it... there are ways around it but only indirectly.
> 
> All fixable and not actually directly relevant for this part (possibly the inkern
>  interface is...)

Sure, all is fixable. Not that it will help here.

If you plan to accept this driver, please let me and David know, and I'll drop
the hwmon driver. It means we'll both have wasted our time, but it does not make
sense to keep two drivers for this chip around.

On another side note, I don't really believe that it makes much sense to add all
this functionality to iio to start with. I'd rather fix the hwmon registration
API and create a hwmon->iio bridge.

Guenter
