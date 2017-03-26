Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:55355 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdCZKuj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Mar 2017 06:50:39 -0400
Date: Sun, 26 Mar 2017 12:50:32 +0200
From: jacopo <jacopo@jmondi.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        wsa+renesas@sang-engineering.com, lars@metafoo.de,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: adc: Add Maxim max9611 ADC driver
Message-ID: <20170326105032.GG5981@w540>
References: <1490369323-13866-1-git-send-email-jacopo+renesas@jmondi.org>
 <1490369323-13866-4-git-send-email-jacopo+renesas@jmondi.org>
 <a911f5d1-e019-772f-0889-849cf42e6827@kernel.org>
 <alpine.DEB.2.20.1703251706420.25208@vps.pmeerw.net>
 <20170326100843.GC5981@w540>
 <512601ce-ef2d-c249-6e59-0bf489145a64@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <512601ce-ef2d-c249-6e59-0bf489145a64@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

[snip]

On Sun, Mar 26, 2017 at 11:24:54AM +0100, Jonathan Cameron wrote:
> >>>> +static struct iio_chan_spec max9611_channels[] = {
> >>
> >> const
> >>
> >>>> +	{
> >>>> +	  .type			= IIO_TEMP,
> >>>> +	  .info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
> >>>> +				  BIT(IIO_CHAN_INFO_SCALE),
> >>>> +	  .address		= MAX9611_CHAN_TEMPERATURE,
> >>>> +	},
> >>>> +	{
> >>>> +	  .type			= IIO_VOLTAGE,
> >>>> +	  .info_mask_separate	= BIT(IIO_CHAN_INFO_RAW)   |
> >>>> +				  BIT(IIO_CHAN_INFO_SCALE) |
> >>>> +				  BIT(IIO_CHAN_INFO_OFFSET),
> >>>> +	  .address		= MAX9611_CHAN_VOLTAGE_INPUT,
> >>>> +	  .indexed		= 1,
> >>>> +	  .channel		= 1,
> >>
> >> why is this indexed?
> >> should be the only raw voltage channel
> >>
> >>
> >>>> +	},
> >>>> +	{
> >>>> +	  .type			= IIO_VOLTAGE,
> >>>> +	  .info_mask_separate	= BIT(IIO_CHAN_INFO_PROCESSED),
> >>>> +	  .address		= MAX9611_CHAN_VOLTAGE_SENSE,
> >>>> +	  .indexed		= 1,
> >>>> +	  .channel		= 0,
> >>> Unusual to have the channels in here other than in channel order...
> >>
> >> why is this indexed?
> >> should be the only processed voltage channel
> >>
> > 
> > Jonathan already replied on this, but I would add that with no
> > indexing this would appear in userspace as:
> > 
> > in_voltage_raw
> > in_voltage_scale
> > in_voltage_offset
> > in_offset_processed
> > 
> > which is confusing at best.
> I hope that last one is in_voltage_processed!

Sure it is, I just confused channel name and mask name when writing it
down here :)

