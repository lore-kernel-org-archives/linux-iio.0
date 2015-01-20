Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:46872 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbbATBeK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jan 2015 20:34:10 -0500
From: Marek Vasut <marex@denx.de>
To: Kristina =?utf-8?q?Mart=C5=A1enko?= <kristina.martsenko@gmail.com>
Subject: Re: [PATCH 1/4] iio: mxs-lradc: separate touchscreen and buffer virtual channels
Date: Tue, 20 Jan 2015 02:29:43 +0100
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"Lars-Peter Clausen" <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Juergen Beisert <jbe@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
References: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com> <201501180119.04510.marex@denx.de> <54BD54AB.7020802@gmail.com>
In-Reply-To: <54BD54AB.7020802@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201501200229.43495.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Monday, January 19, 2015 at 08:02:03 PM, Kristina Martšenko wrote:
> On 18/01/15 02:19, Marek Vasut wrote:
> > On Saturday, January 17, 2015 at 01:22:08 AM, Kristina Martšenko wrote:
> > 
> > Hi!
> 
> Hi!

Hi!

> > Good stuff, thank you! Just minor nitpicks below.
> > 
> > [...]
> > 
> >> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> >> b/drivers/staging/iio/adc/mxs-lradc.c index e0e91836eec1..fc65cd311be9
> >> 100644
> >> --- a/drivers/staging/iio/adc/mxs-lradc.c
> >> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> >> @@ -214,11 +214,14 @@ struct mxs_lradc {
> >> 
> >>  	unsigned long		is_divided;
> >>  	
> >>  	/*
> >> 
> >> -	 * Touchscreen LRADC channels receives a private slot in the CTRL4
> >> -	 * register, the slot #7. Therefore only 7 slots instead of 8 in the
> >> -	 * CTRL4 register can be mapped to LRADC channels when using the
> >> -	 * touchscreen.
> >> -	 *
> >> +	 * When the touchscreen is enabled, we give it two private virtual
> >> +	 * channels: #6 and #7. This means that only 6 virtual channels
> >> (instead +	 * of 8) will be available for buffered capture.
> >> +	 */
> >> +#define TS_VCH1		7
> >> +#define TS_VCH2		6
> > 
> > Please use a bit more explicit name for the macro, it's really not clear
> > what the macro represents from it's name. Something like
> > TOUCHSCREEN_VCHANNEL1 might work better for example. What do you think ?
> 
> Sure, I tried to keep it short and similar to the TS_CH_YP (etc) macros,
> but clearer is better, so I'll change it to TOUCHSCREEN_VCHANNEL1 in v2.

Thank you!

> >> +
> >> +	/*
> >> 
> >>  	 * Furthermore, certain LRADC channels are shared between touchscreen
> >>  	 * and/or touch-buttons and generic LRADC block. Therefore when using
> >>  	 * either of these, these channels are not available for the regular
> > 
> > [...]
> > 
> > I also have a general question/idea here, it's explicitly not something
> > I'd like to force upon you to implement. I see we have some kind of a
> > hardware, which can sample up-to N inputs in parallel . Each input is
> > muxed between M possible sources . Is such a thing common in the ADC/DAC
> > world ? Would it be worth to implement generic helper to handle this
> > kind of a N:M mapping ? What do you all think please ?
> 
> Hmm, I don't know how other drivers do this, or if there's anything in
> common. The IIO people will probably have a better idea, so I'll wait
> for them to respond.

Yep.

Best regards,
Marek Vasut
