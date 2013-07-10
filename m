Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:38344 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353Ab3GJLtd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jul 2013 07:49:33 -0400
From: Marek Vasut <marex@denx.de>
To: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH 1/4] iio: mxs-lradc: change the realbits to 12
Date: Wed, 10 Jul 2013 13:49:26 +0200
Cc: "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"jic23@kernel.org" <jic23@kernel.org>
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <201307051510.29011.marex@denx.de> <51DD3BA5.6000402@digi.com>
In-Reply-To: <51DD3BA5.6000402@digi.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307101349.26318.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Hector,

> Hello,
> 
> On 07/05/2013 03:10 PM, Marek Vasut wrote:
> > Dear Hector Palacios,
> > 
> >> Dear Marek,
> >> 
> >> On 07/05/2013 01:37 PM, Marek Vasut wrote:
> >>> Dear Hector Palacios,
> >>> 
> >>>> The LRADC virtual channels have an 18 bit field to store the sum of up
> >>>> to 2^5 accumulated samples. The read_raw function however only
> >>>> operates over a single sample (12 bit resolution).
> >>>> In order to use this field for scaling operations, we need it to be
> >>>> the exact resolution value of the LRADC.
> >>> 
> >>> How would this work once the accumulation is supported?
> >> 
> >> As I see it, when you read a channel the driver should give you the
> >> 12-bit value either of one single sample or of N samples.
> > 
> > The hardware will always give you 18 bit value, let's call it A of N
> > accumulated samples, each 12 bit long. N is in range of 1 to 32 .
> > 
> > The driver currently supports N = 1.
> > 
> > Do I understand it correctly that if we want to support N > 1, we have to
> > do the division of A / N in the driver and therefore we will again
> > report only a 12-bit value to the userland ?
> > 
> > If so,
> > 
> > Acked-by: Marek Vasut <marex@denx.de>
> 
> Coming back to this patch, I just noticed that it is not enough to just
> change the realbits from 18 to 12. When using this driver as touchscreen
> for Yocto's SATO graphic rootfs I noticed that the driver is using
> LRADC_CH_VALUE_MASK for reporting the coordinates.
> 
> 	input_set_abs_params(input, ABS_X, 0, LRADC_CH_VALUE_MASK, 0, 0);
> 	input_set_abs_params(input, ABS_Y, 0, LRADC_CH_VALUE_MASK, 0, 0);
> 	input_set_abs_params(input, ABS_PRESSURE, 0, LRADC_CH_VALUE_MASK, 0, 0);
> 
> which is defined as an 18bit mask:
> 
> 	#define	LRADC_CH_VALUE_MASK			0x3ffff
> 
> The result is that the touch calibration range in Xorg is expecting values
> between 0 and 262143 (0x3ffff), which causes trouble (at least I had
> problems to calibrate it).

What kind of trouble does it cause?

[...]

> Notice that I leave the existing LRADC_CH_VALUE_MASK 18bit mask in the rest
> of the driver, to support accumulated samples.
> Curiously, ts_lib works fine without this (maybe the calibration fixes
> this?), but nevertheless the information passed by the driver is
> incorrect, I guess. Is anybody out there working with the touch? Under
> which graphic system?

Both QtE and Sato work for me, that's why I'm curious about your issues.

Best regards,
Marek Vasut
