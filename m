Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:45507 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733Ab1JXIVg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2011 04:21:36 -0400
Message-ID: <4EA52005.1010208@free-electrons.com>
Date: Mon, 24 Oct 2011 10:21:25 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 2/3] ARM: AT91: IIO: Add AT91 ADC driver.
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com> <1319041134-19712-3-git-send-email-maxime.ripard@free-electrons.com> <20111023090813.GI2638@game.jcrosoft.org>
In-Reply-To: <20111023090813.GI2638@game.jcrosoft.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 23/10/2011 11:08, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 18:18 Wed 19 Oct     , Maxime Ripard wrote:
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> please keep me in CC
ACK.

>> +
>> +static int at91adc_channel_init(struct at91adc_state *st)
>> +{
>> +	int ret = 0, i;
>> +	st->channels = kzalloc(sizeof(struct iio_chan_spec) * st->nb_chan,
>> +			       GFP_KERNEL);
>> +	if (st->channels == NULL)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < st->nb_chan; i++) {
>> +		struct iio_chan_spec *chan = st->channels + i;
>> +		chan->type = IIO_VOLTAGE;
>> +		chan->indexed = 1;
>> +		chan->channel = i;
>> +		++ret;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int at91adc_read_raw(struct iio_dev *idev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int *val, int *val2, long mask)
>> +{
>> +	struct at91adc_state *st = iio_priv(idev);
>> +
>> +	switch (mask) {
>> +	case 0:
>> +		mutex_lock(&st->lock);
>> +
>> +		at91adc_reg_write(st->reg_base, AT91_ADC_CHER,
>> +				  AT91_ADC_CH(chan->channel));
>> +		at91adc_reg_write(st->reg_base, AT91_ADC_IER,
>> +				  AT91_ADC_EOC(chan->channel));
>> +		at91adc_reg_write(st->reg_base, AT91_ADC_CR, AT91_ADC_START);
>> +
>> +		wait_event_interruptible(st->wq_data_avail, st->done);
>> +		*val = st->lcdr;
>> +
>> +		at91adc_reg_write(st->reg_base, AT91_ADC_CHDR,
>> +				  AT91_ADC_CH(chan->channel));
>> +		at91adc_reg_write(st->reg_base, AT91_ADC_IDR,
>> +				  AT91_ADC_EOC(chan->channel));
>> +
>> +		st->lcdr = 0;
>> +		st->done = false;
>> +		mutex_unlock(&st->lock);
>> +		return IIO_VAL_INT;
>> +	default:
>> +		break;
>> +	}
>> +	return -EINVAL;
>> +}
>> +
>> +static const struct iio_info at91adc_info = {
>> +	.driver_module = THIS_MODULE,
>> +	.read_raw = &at91adc_read_raw,
>> +};
>> +
>> +static int __devinit at91adc_probe(struct platform_device *pdev)
>> +{
>> +	unsigned int prsc, mstrclk, ticks;
>> +	int ret;
>> +	struct iio_dev *idev;
>> +	struct at91adc_state *st;
>> +	struct resource *res;
>> +	struct at91_adc_data *pdata = pdev->dev.platform_data;
> 	do not refence it copy need for the DT

Ok

>> +
>> +	dev_dbg(&pdev->dev, "AT91ADC probed\n");
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(&pdev->dev, "No resource defined\n");
>> +		ret = -ENXIO;
>> +		goto error_ret;
>> +	}
>> +
>> +	idev = iio_allocate_device(sizeof(*st));
>> +	if (idev == NULL) {
>> +		dev_err(&pdev->dev, "Failed to allocate memory.\n");
>> +		ret = -ENOMEM;
>> +		goto error_ret;
>> +	}
>> +	platform_set_drvdata(pdev, idev);
>> +
>> +	idev->dev.parent = &pdev->dev;
>> +	idev->name = platform_get_device_id(pdev)->name;
>> +	idev->modes = INDIO_DIRECT_MODE;
>> +	idev->info = &at91adc_info;
>> +
>> +	st = iio_priv(idev);
>> +	st->irq = platform_get_irq(pdev, 0);
>> +	if (st->irq < 0) {
>> +		dev_err(&pdev->dev, "No IRQ ID is designated\n");
>> +		ret = -ENODEV;
>> +		goto error_free_device;
>> +	}
>> +
>> +	if (!request_mem_region(res->start, resource_size(res),
>> +				"AT91 adc registers")) {
>> +		dev_err(&pdev->dev, "Resources are unavailable.\n");
>> +		ret = -EBUSY;
>> +		goto error_free_device;
>> +	}
>> +
>> +	st->reg_base = ioremap(res->start, resource_size(res));
>> +	if (!st->reg_base) {
>> +		dev_err(&pdev->dev, "Failed to map registers.\n");
>> +		ret = -ENOMEM;
>> +		goto error_release_mem;
>> +	}
>> +
>> +	/*
>> +	 * Disable all IRQs before setting up the handler
>> +	 */
>> +	at91adc_reg_write(st->reg_base, AT91_ADC_CR, AT91_ADC_SWRST);
>> +	at91adc_reg_write(st->reg_base, AT91_ADC_IDR, 0xFFFFFFFF);
>> +	ret = request_irq(st->irq,
>> +			  at91adc_eoc_trigger, 0, pdev->dev.driver->name, st);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Failed to allocate IRQ.\n");
>> +		goto error_unmap_reg;
>> +	}
>> +
>> +	st->clk = clk_get(&pdev->dev, "adc_clk");
>> +	if (IS_ERR(st->clk)) {
>> +		dev_err(&pdev->dev, "Failed to get the clock.\n");
>> +		ret = PTR_ERR(st->clk);
>> +		goto error_free_irq;
>> +	}
>> +
>> +	clk_enable(st->clk);
>> +	mstrclk = clk_get_rate(st->clk);
>> +
>> +	if (!pdata) {
>> +		dev_err(&pdev->dev, "No platform data available.\n");
>> +		ret = -EINVAL;
>> +		goto error_free_clk;
>> +	}
>> +
>> +	if (!pdata->adc_clock) {
>> +		dev_err(&pdev->dev, "No ADCClock available.\n");
>> +		ret = -EINVAL;
>> +		goto error_free_clk;
>> +	}
> where is the platform data struct?

In the first patch.

Regards,

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
