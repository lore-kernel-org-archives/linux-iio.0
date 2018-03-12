Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:42824 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751320AbeCLQz4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Mar 2018 12:55:56 -0400
Date: Mon, 12 Mar 2018 16:55:39 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: John Syne <john3909@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Michael Hennerich" <michael.hennerich@analog.com>
Subject: Re: Removal of iio (staging) meter/ade7753, ade7754, ade7758,
 ade7759 and ade7854
Message-ID: <20180312175539.00001e4d@huawei.com>
In-Reply-To: <ADF8B8A0-EE33-4E1D-8902-894D35801EE3@gmail.com>
References: <20180307211912.68752ce0@archlinux>
        <ADF8B8A0-EE33-4E1D-8902-894D35801EE3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 7 Mar 2018 16:27:29 -0800
John Syne <john3909@gmail.com> wrote:

> Hi Jonathan,
Hi John
> 
> I’m using the ADE7878 and I made several changes that I did not send
> to mainline. If someone is willing to clean these drivers up as
> proposed, I am willing to test the drivers with hardware (I have both
> ADE7878 EVAL and ADE9000 EVAL boards) and send through any required
> changes. These changes were made about a year ago, so my patches will
> probably need some work for the current driver. 
Great.
> 
> For the most part, there was a problem with checking the return value
> from I2C communications (return is either negative or the number of
> bytes read/write), the read32 requires 4 bytes not 3. Other than
> that, I renamed the registers to match the data sheet and added many
> of the missing registers. 
Cool - seems to me that whoever wants to take this one should email
you and get those patches.  The first job then becomes bringing those
up to date.

> 
> I am currently looking at updating our hardware to ADE9000 and the
> ADE7758 looks like a good template for me to follow with core, ring
> and trigger functionality. I’m also looking to add DMA support to
> stream waveforms. I’m not sure if Analog Devices is looking to
> develop a driver for ADE9000. 
DMA support would be interesting.  Obviously good to have such
a driver whether you are Analog writes it.  I wouldn't take the
current ade7758 as a template though.  I haven't looked at it for
a while, but IIRC it's quite some way from where we want to be
in terms of userspace ABI.

> 
> One thing I don’t like is the mixing of register definitions in
> meter.h. Each data sheet uses different naming conventions for
> registers that have similar functionality, which means the common
> name used in meter.h does not match the data sheet and that is very
> confusing. There is also inconsistencies when naming the attributes;
> sometimes they follow the register name like avrms or cwgain, and
> sometimes they are given functional names like “volt_a" or
> “active_power_c_gain". I propose that each part have its own include
> file and that the naming convention follow the data sheet and listed
> in the same order as the data sheet. 
Meter.h is going to go away in any cleanup of this driver.
We changed a lot of how we do things since those early days of IIO.
All of this ABI needs proper consideration and may well end up
entirely different from what it is now.  Basically the driver need
wrenching into the modern world ;)

I just took a very brief look and it's better than some of the
other meter drivers but still a lot of work to do.

Anyhow, short term upshot is I won't drop this one from staging
next cycle, but we'll keep it under review dependent on whether it
looks like anyone is interested in working on it or not!

Thanks for your kind offer to test - that gets us half the way.

Jonathan
> 
> Regards,
> John
> 
> 
> 
> 
> 
> > On Mar 7, 2018, at 1:19 PM, Jonathan Cameron <jic23@kernel.org>
> > wrote:
> > 
> > Hi All,
> > 
> > All of these parts are apparently marked as not being for new
> > designs and we have no known access to hardware suitable for
> > testing the major changes needed for these drivers to graduate from
> > staging.
> > 
> > Given this, unless someone expresses an interest (and has hardware
> > for testing) I propose to drop these drivers from staging next
> > kernel cycle (so in around 3 months time).
> > 
> > Of course I hope that someone can help us keep support for these
> > parts and we won't end up dropping them, but they are old and
> > several generations behind the current Analog Devices offerings.
> > 
> > Please share this with anyone you happen to know who is using any
> > of these energy meters.
> > 
> > Thanks,
> > 	
> > Jonathan
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-iio" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

