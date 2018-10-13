Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:34090 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeJMUJx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Oct 2018 16:09:53 -0400
Date: Sat, 13 Oct 2018 13:32:51 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] Add driver for Texas Instrument DAC7311 It is a
 driver for Texas Instruments 8/10/12-bit 1-channel compatible with DAC6311
 and DAC5311 chips.
Message-ID: <20181013133251.68ea4a85@archlinux>
In-Reply-To: <27950c9e-9899-7b43-ea67-12c0030d06f9@essensium.com>
References: <20181006203108.20439-1-charles-antoine.couret@essensium.com>
        <20181007173630.212baa45@archlinux>
        <27950c9e-9899-7b43-ea67-12c0030d06f9@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 8 Oct 2018 23:34:27 +0200
Couret Charles-Antoine <charles-antoine.couret@essensium.com> wrote:

> Hi,
> Like the previous driver, thank you for the code review, I have some 
> questions before making V2.

Hi Charles-Antoine,

Sorry for the slow responses, it's been a rather busy week!

Anyhow, answers inline.
> 
> Le 07/10/2018 à 18:36, Jonathan Cameron a écrit :
> >> +enum {
> >> +	SINGLE_8BITS = 0,
> >> +	SINGLE_10BITS,
> >> +	SINGLE_12BITS,
> >> +};
> >> +
> >> +enum {
> >> +	POWER_RUNNING = 0,
> >> +	POWER_1KOHM_TO_GND,
> >> +	POWER_100KOHM_TO_GND,
> >> +	POWER_TRI_STATE,
> >> +};
> >> +
> >> +struct ti_dac_spec {
> >> +	u8 num_channels;
> >> +	u8 resolution;
> >> +};
> >> +
> >> +static const struct ti_dac_spec ti_dac_spec[] = {
> >> +	[SINGLE_8BITS]  = { .num_channels = 1, .resolution = 8  },  
> > I think I'd prefer to see the enum as part names.  It is easy
> > to see the number of channels and resolution here anyway.  
> I still don't understand the "part names" thing here.
This got clarified I think in the other thread but in brief

[DAC7311] = { .num_channels = 1, .resolution = 8 },
[DAC6411] - {...}

It's a convention that makes it easier to extend the driver
when we get something that needs another little change...

[SINGLE_8BITS_WITH_POWERDOWN_MAGIC] etc doesn't scale.
Sometimes it's just better to use the number of the part from
the datasheet to index these things.

Note that if you have two compatible parts with different numbers
then you can use the first part that was supported as the enum
name and just make the connection in the device_tables that are
used to get this enum value in the first place.

> >> +}
> >> +
> >> +static const char * const ti_dac_powerdown_modes[] = {
> >> +	"running",  
> > What is running in a power down mode?  
> 
> For me it was the list of power status of the device. And using 
> "running" allow us to set to running state with the right command.
> 
> But I probably misunderstand its purpose. Why we have to put only power 
> down in that structure?

There is a separation in the interface between what we want to do
when we power down and the power down control itself.   Arguably they
could have been combined, but IIRC (and I may have this wrong) the earliest
devices could only power down in one way so we had a boolean flag to do
it.  Later we had devices with lots of options and hence needed to describe
them.  So it's basically a legacy thing.  We could have done it the way
you describe, but we didn't. Now for userspace to know what is happening
we need to stick to it.


Thanks,

Jonathan
> 
> 
> Thank you.
> 
> Regards,
> 
> Charles-Antoine Couret
> 
