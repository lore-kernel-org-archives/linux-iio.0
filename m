Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:51617 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759005Ab1CDLJv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Mar 2011 06:09:51 -0500
Message-ID: <4D70C8AA.4090300@cam.ac.uk>
Date: Fri, 04 Mar 2011 11:10:34 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Marten Svanfeldt <marten.svanfeldt@gmail.com>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: High frequency software trigger
References: <4D709432.90003@gmail.com> <544AC56F16B56944AEC3BD4E3D59177133FA70B26C@LIMKCMBX1.ad.analog.com> <4D70BFCD.40605@gmail.com>
In-Reply-To: <4D70BFCD.40605@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Marten,
>> I recently submitted a trigger source driver that utilizes Blackfin hardware timer.
>>
>> http://wiki.analog.com/software/linux/docs/iio/iio-trig-bfin-timer
> 
> Thank you, this had passed me by. Looking at the source, it seems
> that a hrtimer based trigger would be something similar, except not
> tied to any specific platform.
Agreed.  The rtc trigger is a silly historical relic from the pxa platform I use
which does do higher frequency periodic rtc tics.  I also have a driver for that
which effectively does the same as Michaels blackfin one, but via the rtc
interface (gives me 7 additional rtcs).

A generic hrtimer approach is something I've thought about from time to time
but never gotten round to actually writing!  Hence I'd certainly be interested
in your generic driver.
>>
>> Not sure what your platform is, but there might be similar peripherals,
>> that can generate sub second cyclic interrupts.
> The platform in question is an TI OMAP3 (3530) based system, but my
> goal would be to utilize hrtimers as they are not tied to a specific
> platform. They are supposed to work on our target platform, but I
> haven't had time to test them extensively yet.
The advantage of using specific timers originally was the simplicity of setting them
up. They look very much like an interrupt coming off the sensor hence can be set up
then left alone.
>
>> I successfully used it on a fast Blackfin processor at frequencies of 10kHz and above,
>> with this simple demo application.
>>
>> http://wiki.analog.com/software/linux/docs/iio/iio_netscope
> 10kHz sounds reassuring, in my case it is about 250Hz max, but some
> 13 or so channels. Did you get any idea where the limitations lies in
> terms of system load etc? Of course this depends on the exact setup,
> just trying to find all possible sides of moving our code over to be
> IIO-based.
I'm quite happily doing 4 channels off the periodic rtc at 1Khz on a pxa271.
Things got a bit choppy in timing when we went to 2Khz but it works well enough.
The uneven timing had definite spikes so I suspect other things were hogging
the processor from time to time.  I should probably revisit these tests and see
if I can pin down exactly what is causing the issue (that was about 2 years ago
so it may well have gone away!)  

I'm only superficially familiar with the abilities of hrtimers.
Perhaps you could post your current code as an RFC so we can get an idea of exactly
how this would work?

Thanks,

Jonathan


