Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:48236 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173Ab3AJSof (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jan 2013 13:44:35 -0500
Received: by mail-pa0-f49.google.com with SMTP id bi1so520030pad.36
        for <linux-iio@vger.kernel.org>; Thu, 10 Jan 2013 10:44:34 -0800 (PST)
Date: Thu, 10 Jan 2013 10:44:31 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/3 V2] iio: mxs: Implement support for touchscreen
Message-ID: <20130110184431.GD2797@core.coreip.homeip.net>
References: <1355449598-15980-1-git-send-email-marex@denx.de>
 <201212191801.31920.marex@denx.de>
 <20130110005748.GA947@core.coreip.homeip.net>
 <201301101048.38036.marex@denx.de>
 <20130110174630.GB2797@core.coreip.homeip.net>
 <50EF0636.6090903@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50EF0636.6090903@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jan 10, 2013 at 07:19:34PM +0100, Lars-Peter Clausen wrote:
> On 01/10/2013 06:46 PM, Dmitry Torokhov wrote:
> > On Thu, Jan 10, 2013 at 10:48:37AM +0100, Marek Vasut wrote:
> >> Dear Dmitry Torokhov,
> >>
> >> [...]
> >>>>> +	enum mxs_lradc_ts	use_touchscreen;
> >>>>> +	unsigned int		stop_touchscreen:1;
> >>>>> +	unsigned int		use_touchbutton:1;
> >>>
> >>> Can we make them bools instead of bit fields?
> >>
> >> Sure.
> >> [...]
> >>
> >>>>> +static void mxs_lradc_ts_close(struct input_dev *dev)
> >>>>> +{
> >>>>> +	struct mxs_lradc *lradc = input_get_drvdata(dev);
> >>>>> +
> >>>>> +	/* Indicate the touchscreen is stopping. */
> >>>>> +	lradc->stop_touchscreen = 1;
> >>>>> +
> >>>>> +	/* Disable touchscreen touch-detect IRQ. */
> >>>>> +	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
> >>>>> +		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
> >>>>> +
> >>>>> +	/* Power-down touchscreen touch-detect circuitry. */
> >>>>> +	writel(LRADC_CTRL0_TOUCH_DETECT_ENABLE,
> >>>>> +		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
> >>>
> >>> These 2 writes are racing with writes in mxs_lradc_ts_work(). I think
> >>> you need to:
> >>>
> >>> 	lradc->stop_touchscreen = true;
> >>> 	mb();
> >>
> >> Nice catch, do we need the memory barrier here though, is it not enough to 
> >> reorder the cancel_work_sync() just before the register writes?
> > 
> > You really need to make sure that setting lradc->stop_touchscreen =
> > true; is not reordered, because otherwise you may cancel the work,
> > interrupt happens and reschedules it, and then you set up the flag.
> 
> Does it really matter? If it is rescheduled you get one event more reported
> after the device has been closed, but input core should ignore it anyway, or
> doesn't it?

But the problem is that if work runs again it will enable the interrupt.
It is better to have all ducks in a row.

Thanks.

-- 
Dmitry
