Return-Path: <dmitry.torokhov@gmail.com>
Date: Thu, 10 Jan 2013 09:46:30 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/3 V2] iio: mxs: Implement support for touchscreen
Message-ID: <20130110174630.GB2797@core.coreip.homeip.net>
References: <1355449598-15980-1-git-send-email-marex@denx.de>
 <201212191801.31920.marex@denx.de>
 <20130110005748.GA947@core.coreip.homeip.net>
 <201301101048.38036.marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201301101048.38036.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jan 10, 2013 at 10:48:37AM +0100, Marek Vasut wrote:
> Dear Dmitry Torokhov,
> 
> [...]
> > > > +	enum mxs_lradc_ts	use_touchscreen;
> > > > +	unsigned int		stop_touchscreen:1;
> > > > +	unsigned int		use_touchbutton:1;
> > 
> > Can we make them bools instead of bit fields?
> 
> Sure.
> [...]
> 
> > > > +static void mxs_lradc_ts_close(struct input_dev *dev)
> > > > +{
> > > > +	struct mxs_lradc *lradc = input_get_drvdata(dev);
> > > > +
> > > > +	/* Indicate the touchscreen is stopping. */
> > > > +	lradc->stop_touchscreen = 1;
> > > > +
> > > > +	/* Disable touchscreen touch-detect IRQ. */
> > > > +	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
> > > > +		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
> > > > +
> > > > +	/* Power-down touchscreen touch-detect circuitry. */
> > > > +	writel(LRADC_CTRL0_TOUCH_DETECT_ENABLE,
> > > > +		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
> > 
> > These 2 writes are racing with writes in mxs_lradc_ts_work(). I think
> > you need to:
> > 
> > 	lradc->stop_touchscreen = true;
> > 	mb();
> 
> Nice catch, do we need the memory barrier here though, is it not enough to 
> reorder the cancel_work_sync() just before the register writes?

You really need to make sure that setting lradc->stop_touchscreen =
true; is not reordered, because otherwise you may cancel the work,
interrupt happens and reschedules it, and then you set up the flag.

Thanks.

-- 
Dmitry
