Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: "Lars-Peter Clausen" <lars@metafoo.de>
Subject: Re: [PATCH 2/3 V2] IIO: Add basic MXS LRADC driver
Date: Sun, 12 Aug 2012 01:11:51 +0200
Cc: linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Jonathan Cameron <jic23@kernel.org>,
 Juergen Beisert <jbe@pengutronix.de>,
 Shawn Guo <shawn.guo@linaro.org>,
 Wolfgang Denk <wd@denx.de>
References: <1344007721-11595-1-git-send-email-marex@denx.de> <1344007721-11595-3-git-send-email-marex@denx.de> <501F8509.1030903@metafoo.de>
In-Reply-To: <501F8509.1030903@metafoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201208120111.51639.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Lars-Peter Clausen,

> On 08/03/2012 05:28 PM, Marek Vasut wrote:
> > This driver is very basic. It supports userland trigger, buffer and
> > raw access to channels. The support for delay channels is missing
> > altogether.
> 
> Looks mostly good to me. Some comments inline.
> 
> I think you need to provide a documentation for the devicetree binding,
> even though it's a rather simple binding.

Definitelly, will add it.

> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Juergen Beisert <jbe@pengutronix.de>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Wolfgang Denk <wd@denx.de>
> > ---
> > 
> >  drivers/staging/iio/adc/Kconfig     |   12 +
> >  drivers/staging/iio/adc/Makefile    |    1 +
> >  drivers/staging/iio/adc/mxs-lradc.c |  591
> >  +++++++++++++++++++++++++++++++++++ 3 files changed, 604 insertions(+)
> >  create mode 100644 drivers/staging/iio/adc/mxs-lradc.c
> > 
> > V2: Use delay channel 0 in case of buffered sampling so the samples are
> > deployed
> > 
> >     continuously.
> >     Disallow RAW sampling while buffered mode is enabled to simplify
> >     code.
> > 
> > diff --git a/drivers/staging/iio/adc/Kconfig
> > b/drivers/staging/iio/adc/Kconfig index 67711b7..97ca697 100644
> > --- a/drivers/staging/iio/adc/Kconfig
> > +++ b/drivers/staging/iio/adc/Kconfig
> 
> [...]
> 
> > + */
> > +static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
> > +			const struct iio_chan_spec *chan,
> > +			int *val, int *val2, long m)
> > +{
> > [...]
> > +
> > +	init_completion(&lradc->completion);
> 
> This should rather be INIT_COMPLETION. init_completion should only called
> once in probe, since it will reinitialize the spinlock which opens up race
> conditions.
> 
> > [...]
> > +
> > +	/* Wait for completion on the channel, 1 second max. */
> > +	ret = wait_for_completion_killable_timeout(&lradc->completion,
> > +						msecs_to_jiffies(1000));
> 
> msecs_to_jiffies(1000) = HZ, but I guess both is OK.

Even on NOHZ kernel?

> > [...]
> > +}
> 
> [...]
> 
> > +
> > +static int __devinit mxs_lradc_probe(struct platform_device *pdev)
> > +{
> > [...]
> > +
> > +	/* Grab all IRQ sources */
> > +	for (i = 0; i < 13; i++) {
> > +		lradc->irq[i] = platform_get_irq(pdev, i);
> > +		if (lradc->irq[i] < 0) {
> > +			ret = -EINVAL;
> > +			goto err_addr;
> > +		}
> > +
> > +		ret = devm_request_irq(dev, lradc->irq[i],
> > +					mxs_lradc_handle_irq, 0,
> > +					mxs_lradc_irq_name[i], iio);
> 
> devm_request_irq is a bit dangerous as long we do not have a
> devm_iio_device_alloc. The IRQ will only be freed after the memory for the
> IIO device has been freed, which means there is a slight window where the
> IRQ could fire although the memory has already been freed.

The IRQ is disabled, see mxs_lradc_hw_stop(), so it should be all right.

> > +		if (ret)
> > +			goto err_addr;
> > +	}
> > +
> > +	dev_set_drvdata(&pdev->dev, iio);
> 
> platform_set_drvdata
> 
> > +
> > +	init_completion(&lradc->completion);
> > +	mutex_init(&lradc->lock);
> > +
> 
> [...]
