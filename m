Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:56981 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753845Ab1JWJnP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2011 05:43:15 -0400
Received: from mail34.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 41E1110146BA
	for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2011 11:35:12 +0200 (CEST)
Date: Sun, 23 Oct 2011 11:08:13 +0200
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 2/3] ARM: AT91: IIO: Add AT91 ADC driver.
Message-ID: <20111023090813.GI2638@game.jcrosoft.org>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
 <1319041134-19712-3-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319041134-19712-3-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18:18 Wed 19 Oct     , Maxime Ripard wrote:
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
please keep me in CC
> +
> +static int at91adc_channel_init(struct at91adc_state *st)
> +{
> +	int ret = 0, i;
> +	st->channels = kzalloc(sizeof(struct iio_chan_spec) * st->nb_chan,
> +			       GFP_KERNEL);
> +	if (st->channels == NULL)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < st->nb_chan; i++) {
> +		struct iio_chan_spec *chan = st->channels + i;
> +		chan->type = IIO_VOLTAGE;
> +		chan->indexed = 1;
> +		chan->channel = i;
> +		++ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int at91adc_read_raw(struct iio_dev *idev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct at91adc_state *st = iio_priv(idev);
> +
> +	switch (mask) {
> +	case 0:
> +		mutex_lock(&st->lock);
> +
> +		at91adc_reg_write(st->reg_base, AT91_ADC_CHER,
> +				  AT91_ADC_CH(chan->channel));
> +		at91adc_reg_write(st->reg_base, AT91_ADC_IER,
> +				  AT91_ADC_EOC(chan->channel));
> +		at91adc_reg_write(st->reg_base, AT91_ADC_CR, AT91_ADC_START);
> +
> +		wait_event_interruptible(st->wq_data_avail, st->done);
> +		*val = st->lcdr;
> +
> +		at91adc_reg_write(st->reg_base, AT91_ADC_CHDR,
> +				  AT91_ADC_CH(chan->channel));
> +		at91adc_reg_write(st->reg_base, AT91_ADC_IDR,
> +				  AT91_ADC_EOC(chan->channel));
> +
> +		st->lcdr = 0;
> +		st->done = false;
> +		mutex_unlock(&st->lock);
> +		return IIO_VAL_INT;
> +	default:
> +		break;
> +	}
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info at91adc_info = {
> +	.driver_module = THIS_MODULE,
> +	.read_raw = &at91adc_read_raw,
> +};
> +
> +static int __devinit at91adc_probe(struct platform_device *pdev)
> +{
> +	unsigned int prsc, mstrclk, ticks;
> +	int ret;
> +	struct iio_dev *idev;
> +	struct at91adc_state *st;
> +	struct resource *res;
> +	struct at91_adc_data *pdata = pdev->dev.platform_data;
	do not refence it copy need for the DT
> +
> +	dev_dbg(&pdev->dev, "AT91ADC probed\n");
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "No resource defined\n");
> +		ret = -ENXIO;
> +		goto error_ret;
> +	}
> +
> +	idev = iio_allocate_device(sizeof(*st));
> +	if (idev == NULL) {
> +		dev_err(&pdev->dev, "Failed to allocate memory.\n");
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +	platform_set_drvdata(pdev, idev);
> +
> +	idev->dev.parent = &pdev->dev;
> +	idev->name = platform_get_device_id(pdev)->name;
> +	idev->modes = INDIO_DIRECT_MODE;
> +	idev->info = &at91adc_info;
> +
> +	st = iio_priv(idev);
> +	st->irq = platform_get_irq(pdev, 0);
> +	if (st->irq < 0) {
> +		dev_err(&pdev->dev, "No IRQ ID is designated\n");
> +		ret = -ENODEV;
> +		goto error_free_device;
> +	}
> +
> +	if (!request_mem_region(res->start, resource_size(res),
> +				"AT91 adc registers")) {
> +		dev_err(&pdev->dev, "Resources are unavailable.\n");
> +		ret = -EBUSY;
> +		goto error_free_device;
> +	}
> +
> +	st->reg_base = ioremap(res->start, resource_size(res));
> +	if (!st->reg_base) {
> +		dev_err(&pdev->dev, "Failed to map registers.\n");
> +		ret = -ENOMEM;
> +		goto error_release_mem;
> +	}
> +
> +	/*
> +	 * Disable all IRQs before setting up the handler
> +	 */
> +	at91adc_reg_write(st->reg_base, AT91_ADC_CR, AT91_ADC_SWRST);
> +	at91adc_reg_write(st->reg_base, AT91_ADC_IDR, 0xFFFFFFFF);
> +	ret = request_irq(st->irq,
> +			  at91adc_eoc_trigger, 0, pdev->dev.driver->name, st);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to allocate IRQ.\n");
> +		goto error_unmap_reg;
> +	}
> +
> +	st->clk = clk_get(&pdev->dev, "adc_clk");
> +	if (IS_ERR(st->clk)) {
> +		dev_err(&pdev->dev, "Failed to get the clock.\n");
> +		ret = PTR_ERR(st->clk);
> +		goto error_free_irq;
> +	}
> +
> +	clk_enable(st->clk);
> +	mstrclk = clk_get_rate(st->clk);
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "No platform data available.\n");
> +		ret = -EINVAL;
> +		goto error_free_clk;
> +	}
> +
> +	if (!pdata->adc_clock) {
> +		dev_err(&pdev->dev, "No ADCClock available.\n");
> +		ret = -EINVAL;
> +		goto error_free_clk;
> +	}
where is the platform data struct?

Best Regards,
J.
