Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-092.synserver.de ([212.40.185.92]:1134 "EHLO
	smtp-out-087.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752679Ab1JTHIt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2011 03:08:49 -0400
Message-ID: <4E9FC916.2070800@metafoo.de>
Date: Thu, 20 Oct 2011 09:09:10 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>
Subject: Re: [PATCH 2/3] ARM: AT91: IIO: Add AT91 ADC driver.
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com> <1319041134-19712-3-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1319041134-19712-3-git-send-email-maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/19/2011 06:18 PM, Maxime Ripard wrote:
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  [...]
> +
> +#define at91adc_reg_read(base, reg)        __raw_readl((base) + (reg))
> +#define at91adc_reg_write(base, reg, val)  __raw_writel((val), (base) + (reg))

Shouldn't this rather be {readl,writel}_relaxed?

> +
> +struct at91adc_state {
> +	struct clk *clk;
> +	bool done;
> +	struct mutex lock;
> +	struct iio_chan_spec *channels;
> +	int nb_chan;
> +	int irq;
> +	wait_queue_head_t wq_data_avail;
> +	u16 lcdr;
> +	void __iomem *reg_base;
> +
> +};
> +
> +static irqreturn_t at91adc_eoc_trigger(int irq, void *private)
> +{
> +	int chan;
> +	struct at91adc_state *st = private;
> +	struct iio_dev *idev = iio_priv_to_dev(st);
> +	unsigned int status = at91adc_reg_read(st->reg_base, AT91_ADC_SR);
> +
> +	if (!(status & AT91_ADC_DRDY))
> +		return IRQ_HANDLED;
> +
> +	for (chan = 0; chan < st->nb_chan; chan++) {
> +		if (status & AT91_ADC_EOC(chan)) {
> +			st->done = true;
> +			st->lcdr = at91adc_reg_read(st->reg_base,
> +						    AT91_ADC_CHR(chan));
> +		}
> +	}
> +	wake_up_interruptible(&st->wq_data_avail);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int at91adc_channel_init(struct at91adc_state *st)
> +{
> +	int ret = 0, i;
> +	st->channels = kzalloc(sizeof(struct iio_chan_spec) * st->nb_chan,
> +			       GFP_KERNEL);

kcalloc

> +	if (st->channels == NULL)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < st->nb_chan; i++) {
> +		struct iio_chan_spec *chan = st->channels + i;
> +		chan->type = IIO_VOLTAGE;
> +		chan->indexed = 1;
> +		chan->channel = i;


It probably makes sense to initialize scan_type as well.

> +		++ret;
> +	}
> +
> +	return ret;

Why do you need ret? Shouldn't this be just st->nb_chan?

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

Its probably a good idea to add a timeout in case there is a problem with
the hardware.

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

You don't use device ids. This should cause a NULL pointer deref? Maybe use
dev_name(&pdev->dev) instead.

> +	idev->modes = INDIO_DIRECT_MODE;
> +	idev->info = &at91adc_info;
> +
> +[...]
> +}
> +
> +static int __devexit at91adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *idev = platform_get_drvdata(pdev);
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	struct at91adc_state *st = iio_priv(idev);
> +
> +	free_irq(st->irq, st);
> +	iounmap(st->reg_base);
> +	release_mem_region(res->start, resource_size(res));
> +	iio_device_unregister(idev);
> +

The iio API changed a bit recently and uses a two stage unregistration now.
You should call iio_device_unregister before freeing resources and
iio_device_free afterwards.

> +	return 0;
> +}
> +
> [...]
