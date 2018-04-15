Return-Path: <SRS0=ncea=HE=perches.com=joe@kernel.org>
Message-ID: <d59b997761d752877a9942e6be664d2ae1d25637.camel@perches.com>
Subject: Re: [PATCH v2 13/14] Move ad7746 out of staging
From: Joe Perches <joe@perches.com>
To: Jonathan Cameron <jic23@kernel.org>, =?ISO-8859-1?Q?Hern=E1n?= Gonzalez
	 <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 15 Apr 2018 11:46:09 -0700
In-Reply-To: <20180415180451.4d538830@archlinux>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	 <1523637411-8531-14-git-send-email-hernan@vanguardiasur.com.ar>
	 <20180415180451.4d538830@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sun, 2018-04-15 at 18:04 +0100, Jonathan Cameron wrote:
> On Fri, 13 Apr 2018 13:36:50 -0300
> Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:
> 
> > Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
> 
> A few comments inline.

And a trivial typo and other bits

> > diff --git a/drivers/iio/cdc/Makefile b/drivers/iio/cdc/Makefile
[]
> > @@ -0,0 +1,5 @@
> > +#
> > +#Makeefile for industrial I/O CDC drivers

Makefile

> > diff --git a/drivers/iio/cdc/ad7746.c b/drivers/iio/cdc/ad7746.c
[]
> > @@ -0,0 +1,855 @@

Perhaps use the SPDX tags

> > +/*
> > + * AD7746 capacitive sensor driver supporting AD7745, AD7746 and AD7747
> > + *
> > + * Copyright 2011 Analog Devices Inc.
> > + *
> > + * Licensed under the GPL-2.
> > + */

[]

> > +static const struct iio_chan_spec ad7746_channels[] = {
> > +	[VIN] = {
> > +		.type = IIO_VOLTAGE,
> > +		.indexed = 1,
> > +		.channel = 0,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> > +			BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +		.address = AD7746_REG_VT_DATA_HIGH << 8 |
> > +			AD7746_VTSETUP_VTMD_EXT_VIN,
> 
> Hmm. I never like to see a single location used to hold two different things.
> I would suggest perhaps having address be an enum then have have a lookup
> into an array of structures that have the two elements separately.
> (use the ad7746_chan enum again for this?)

And perhaps it's nicer to align the multiple
BIT(identifier) uses like

		.info_mask_shared_by_type = (BIT(IIO_CHAN_INFO_SCALE) |
 					     BIT(IIO_CHAN_INFO_SAMP_FREQ)),

The extra unnecessary parentheses allow at least emacs
to align the BIT uses properly.

[]

> > +	[CIN1] = {
> > +		.type = IIO_CAPACITANCE,
> > +		.indexed = 1,
> > +		.channel = 0,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
> > +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +		.address = AD7746_REG_CAP_DATA_HIGH << 8,
> > +	},

So this one could be:

		.info_mask_shared_by_type = (BIT(IIO_CHAN_INFO_CALIBBIAS) |
					     BIT(IIO_CHAN_INFO_SCALE) |
					     BIT(IIO_CHAN_INFO_SAMP_FREQ)),

etc...
