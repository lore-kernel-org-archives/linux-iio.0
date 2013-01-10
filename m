Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:49507 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab3AJKJh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jan 2013 05:09:37 -0500
From: Marek Vasut <marex@denx.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3 V2] iio: mxs: Implement support for touchscreen
Date: Thu, 10 Jan 2013 10:48:37 +0100
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Shawn Guo <shawn.guo@linaro.org>
References: <1355449598-15980-1-git-send-email-marex@denx.de> <201212191801.31920.marex@denx.de> <20130110005748.GA947@core.coreip.homeip.net>
In-Reply-To: <20130110005748.GA947@core.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201301101048.38036.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Dmitry Torokhov,

[...]
> > > +	enum mxs_lradc_ts	use_touchscreen;
> > > +	unsigned int		stop_touchscreen:1;
> > > +	unsigned int		use_touchbutton:1;
> 
> Can we make them bools instead of bit fields?

Sure.
[...]

> > > +static void mxs_lradc_ts_close(struct input_dev *dev)
> > > +{
> > > +	struct mxs_lradc *lradc = input_get_drvdata(dev);
> > > +
> > > +	/* Indicate the touchscreen is stopping. */
> > > +	lradc->stop_touchscreen = 1;
> > > +
> > > +	/* Disable touchscreen touch-detect IRQ. */
> > > +	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
> > > +		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
> > > +
> > > +	/* Power-down touchscreen touch-detect circuitry. */
> > > +	writel(LRADC_CTRL0_TOUCH_DETECT_ENABLE,
> > > +		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
> 
> These 2 writes are racing with writes in mxs_lradc_ts_work(). I think
> you need to:
> 
> 	lradc->stop_touchscreen = true;
> 	mb();

Nice catch, do we need the memory barrier here though, is it not enough to 
reorder the cancel_work_sync() just before the register writes?

> 	cancel_work_sync(&lradc->ts_work);
> 	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
> 		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
> 	...

[...]

> > > +	lradc->ts_input = input;
> > > +	input_set_drvdata(input, lradc);
> > > +	ret = input_register_device(input);
> > > +	if (ret)
> > > +		input_free_device(lradc->ts_input);
> > > +
> > > +	return ret;
> 
> So why is allocation failure is not fatal bur registration is? I'd make
> both fatal.

Since it's still possible to operate the block even if touchscreen fails to 
probe. If that happens, certainly something is already weird. I'd say both 
should be fatal.

> > > +}
> > > +
> > > +static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
> > > +{
> > > +	if (!lradc->use_touchscreen)
> > > +		return;
> > > +
> > > +	if (!lradc->ts_input)
> > > +		return;
> 
> Do we really need to check both conditions?

Better safe than sorry, but lradc->ts_input should be non-NULL in case lradc-
>use_touchscreen is set, so I'll remove it.

[...]

