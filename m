Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:38161 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756126Ab3C1OUV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Mar 2013 10:20:21 -0400
From: Marek Vasut <marex@denx.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] iio: mxs-lradc: Do hardware initialization earlier
Date: Thu, 28 Mar 2013 12:59:12 +0100
Cc: Fabio Estevam <fabio.estevam@freescale.com>,
	brian@crystalfontz.com, linux-iio@vger.kernel.org, jimwall@q.com,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Cameron <jic23@kernel.org>
References: <1364465583-19835-1-git-send-email-alexandre.belloni@free-electrons.com> <201303281222.21285.marex@denx.de> <51542ED5.4090200@free-electrons.com>
In-Reply-To: <51542ED5.4090200@free-electrons.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201303281259.12674.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Alexandre Belloni,

> On 28/03/2013 12:22, Marek Vasut wrote:
> > Dear Alexandre Belloni,
> > 
> >> We need to initialize hardware before registering the touchscreen. Else,
> >> we end up setting registers in mxs_lradc_ts_open(), getting called just
> >> after registering the touchscreen with input_register_device() and by
> >> the end of mxs_lradc_probe(), we reset the LRADC block hence losing the
> >> correct configuration.
> >> 
> >> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> >> Cc: Jonathan Cameron <jic23@kernel.org>
> >> Cc: Marek Vasut <marex@denx.de>
> >> ---
> >> 
> >>  drivers/staging/iio/adc/mxs-lradc.c |    6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> >> b/drivers/staging/iio/adc/mxs-lradc.c index 55a459b..e927e3f 100644
> >> --- a/drivers/staging/iio/adc/mxs-lradc.c
> >> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> >> @@ -933,6 +933,9 @@ static int mxs_lradc_probe(struct platform_device
> >> *pdev)
> >> 
> >>  	INIT_WORK(&lradc->ts_work, mxs_lradc_ts_work);
> >> 
> >> +	/* Configure the hardware. */
> >> +	mxs_lradc_hw_init(lradc);
> >> +
> >> 
> >>  	/* Check if touchscreen is enabled in DT. */
> >>  	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
> > 
> > Isn't this too early? At least lradc->use_touchscreen is configured only
> > after you call mxs_lradc_hw_init() in this case, while
> > mxs_lradc_hw_init() uses it's value.
> > 
> > I think mxs_lradc_hw_init() shall be called just before
> > mxs_lradc_ts_register().
> 
> That's right, this would break 5 wires touchscreens. I'll fix that.

Thanks!

Best regards,
Marek Vasut
