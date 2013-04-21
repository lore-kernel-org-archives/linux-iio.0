Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50745 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab3DUHEw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Apr 2013 03:04:52 -0400
Date: Sun, 21 Apr 2013 09:04:47 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Denis Darwish <darwish.d.d@gmail.com>, linux-iio@vger.kernel.org,
	Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v2] iio: basic ADC support for Freescale i.MX25
Message-ID: <20130421070447.GE32299@pengutronix.de>
References: <516FCEBC.7080000@gmail.com>
 <5172CCDA.2020304@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5172CCDA.2020304@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I don't have the original patch to reply on, so some comments here.

On Sat, Apr 20, 2013 at 07:14:02PM +0200, Lars-Peter Clausen wrote:
> > +void tsc_self_reset(struct imx_adc_state *st)

static.

> > +{
> > +	unsigned long reg;
> > +
> > +	reg = readl_relaxed(st->reg_base + IMX_ADC_TGCR);
> > +	reg |= IMX_ADC_TGCR_TSC_RST;
> > +	writel_relaxed(reg, st->reg_base + IMX_ADC_TGCR);
> > +
> > +	while (readl_relaxed(st->reg_base + IMX_ADC_TGCR) &
> > +		IMX_ADC_TGCR_TSC_RST)
> > +		continue;
> 
> Needs a timeout in case for the unlikely event the hardware malfunctions.
> 
> > +}
> [...]
> 
> > +void imx_adc_read_general(unsigned short *result, struct imx_adc_state *st)

ditto. More functions which should be static follow.

> > +
> > +	/* Reset */
> > +	tsc_self_reset(st);
> > +
> > +	st->reg = regulator_get(&pdev->dev, "ext-vref");

Use devm_regulator_get

> > +	if (!IS_ERR_OR_NULL(st->reg)) {

Don't use IS_ERR_OR_NULL. regulator_get will always return an error
pointer, so IS_ERR() is correct here. Also, please use positive logic
which is easier to read.

> > +	/* Set power mode */
> > +	adc_set_power_mode(st);
> > +
> > +	/* Set queue */
> > +	adc_set_queue(st);

Remove those comments, they contain no information.

Better even, remove all these functions manipulating this single
register and replace it with a simple:

	tgcr = IMX_ADC_TGCR_IPG_CLK_EN |
		IMX_ADC_TGCR_POWER_ON |
		31 << IMX_ADC_TGCR_ADCCLKCFG_SHIFT;

	if (IS_ERR(regulator))
		tgcr |= IMX_ADC_TGCR_INTREFEN;

	writel_relaxed(tgcr, st->reg_base + IMX_ADC_TGCR);

> > +	ret = iio_device_register(iodev);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "Couldn't register the device.\n");

Such messages become much more useful when the error code is printed
aswell.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
