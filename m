Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:41164 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab1KNJ7z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Nov 2011 04:59:55 -0500
Message-ID: <4EC0E692.70005@free-electrons.com>
Date: Mon, 14 Nov 2011 10:59:46 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 2/3] ARM: AT91: IIO: Add AT91 ADC driver.
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com> <1320833976-32689-1-git-send-email-maxime.ripard@free-electrons.com> <1320833976-32689-3-git-send-email-maxime.ripard@free-electrons.com> <4EBC0B4D.1030809@kernel.org> <4EBD163B.7020307@kernel.org>
In-Reply-To: <4EBD163B.7020307@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/11/2011 13:34, Jonathan Cameron wrote:
> On 11/10/2011 05:35 PM, Jonathan Cameron wrote:
>> On 11/09/2011 10:19 AM, Maxime Ripard wrote:
>>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>>> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
>>> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>>
>> One little comment / query inline.  I'm happy with this either way
>> though.  Beware as you are dependent on a series under review though
>> and it's always possible little things in there might change!
>>
>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>>
>>> ---
>>>  drivers/iio/adc/Kconfig   |    6 +
>>>  drivers/iio/adc/Makefile  |    4 +-
>>>  drivers/iio/adc/at91adc.c |  326 +++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 335 insertions(+), 1 deletions(-)
>>>  create mode 100644 drivers/iio/adc/at91adc.c
>>>
>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>> index 3d97b21..74f4d9f 100644
>>> --- a/drivers/iio/adc/Kconfig
>>> +++ b/drivers/iio/adc/Kconfig
>>> @@ -14,6 +14,12 @@ config IIO_AD799X
>>>  	  i2c analog to digital convertors (ADC). Provides direct access
>>>  	  via sysfs.
>>>  
>>> +config IIO_AT91ADC
>>> +	tristate "Atmel AT91 ADC"
>>> +	depends on SYSFS && ARCH_AT91
>>> +	help
>>> +	  Say yes here to build support for Atmel AT91 ADC.
>>> +
>>>  config IIO_MAX1363
>>>  	tristate "Maxim max1363 ADC driver"
>>>  	depends on I2C
>>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>>> index c197334..776b56f 100644
>>> --- a/drivers/iio/adc/Makefile
>>> +++ b/drivers/iio/adc/Makefile
>>> @@ -6,4 +6,6 @@ iio_ad799x-y := ad799x_core.o
>>>  obj-$(CONFIG_IIO_AD799X) += iio_ad799x.o
>>>  
>>>  iio_max1363-y := max1363_core.o
>>> -obj-$(CONFIG_IIO_MAX1363) += iio_max1363.o
>>> \ No newline at end of file
>>> +obj-$(CONFIG_IIO_MAX1363) += iio_max1363.o
>>> +
>>> +obj-$(CONFIG_IIO_AT91ADC) += at91adc.o
>>> diff --git a/drivers/iio/adc/at91adc.c b/drivers/iio/adc/at91adc.c
>>> new file mode 100644
>>> index 0000000..6aef5d6
>>> --- /dev/null
>>> +++ b/drivers/iio/adc/at91adc.c
>>> @@ -0,0 +1,326 @@
>>> +/*
>>> + * Driver for the ADC present in the Atmel AT91 evaluation boards.
>>> + *
>>> + * Copyright 2011 Free Electrons
>>> + *
>>> + * Licensed under the GPLv2 or later.
>>> + */
>>> +
>>> +#include <linux/bitmap.h>
>>> +#include <linux/bitops.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/err.h>
>>> +#include <linux/io.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/jiffies.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/wait.h>
>>> +
>>> +#include <linux/iio/iio.h>
>>> +
>>> +#include <mach/at91_adc.h>
>>> +#include <mach/board.h>
>>> +
>>> +struct at91adc_state {
>>> +	struct clk *clk;
>>> +	bool done;
>>> +	struct mutex lock;
>>> +	int irq;
>>> +	wait_queue_head_t wq_data_avail;
>>> +	u16 last_value;
>>> +	void __iomem *reg_base;
>>> +	unsigned int vref_mv;
>>> +};
>>> +
>>> +static inline u32 at91adc_reg_read(struct at91adc_state *st, u8 reg)
>>> +{
>>> +	return readl_relaxed(st->reg_base + reg);
>>> +}
>>> +
>>> +static inline void at91adc_reg_write(struct at91adc_state *st, u8 reg, u32 val)
>>> +{
>>> +	writel_relaxed(val, st->reg_base + reg);
>>> +}
>>> +
>>> +static irqreturn_t at91adc_eoc_trigger(int irq, void *private)
>>> +{
>>> +	int chan;
>>> +	struct iio_dev *idev = private;
>>> +	struct at91adc_state *st = iio_priv(idev);
>>> +	unsigned int status = at91adc_reg_read(st, AT91_ADC_SR);
>>> +
>>> +	if (!(status & AT91_ADC_DRDY))
>>> +		return IRQ_HANDLED;
>>> +
>>> +	for (chan = 0; chan < idev->num_channels; chan++)
>> Given we know only one bit should be set, it really feels like there
>> should be
>> a cleaner way of doing this. Could it use find_first_bit(&status,
>> idev->num_channels)?
>> It kind of bypasses the defines though so it's far from clean in that sense.
>>> +		if (status & AT91_ADC_EOC(chan)) {
>>
>> The logic in here very much assumes that only one channel is being converted
>> and the interrupt indicates that one of the channels has finished.
>> Hence logically this st->done doesn't need to be in the loop.
>>
> Having had a look at the datasheet, could you just check against the
> whole mask and use the lastdata converted register?  Should under
> current conditions always give you the right thing I think?

You're right, It will be more consistent and avoid to loop over each
channels. I send a new version of the patchset.

>>> +			st->done = true;
>>> +			st->last_value = at91adc_reg_read(st,
>>> +							  AT91_ADC_CHR(chan));
>>> +		}
>>> +
>>> +	wake_up_interruptible(&st->wq_data_avail);
>>> +
>>> +	return IRQ_HANDLED;
>>> +}
>>> +
>>> +static int at91adc_channel_init(struct iio_dev *idev,
>>> +				struct at91_adc_data *pdata)
>>> +{
>>> +	struct iio_chan_spec *chan_array;
>>> +	int bit, idx = 0;
>>> +
>>> +	idev->num_channels = bitmap_weight(&(pdata->channels_used),
>>> +					   pdata->num_channels);
>>> +	chan_array = kcalloc(idev->num_channels, sizeof(struct iio_chan_spec),
>>> +			     GFP_KERNEL);
>>> +
>>> +	if (chan_array == NULL)
>>> +		return -ENOMEM;
>>> +
>>> +	for_each_set_bit(bit, &(pdata->channels_used), pdata->num_channels) {
>>> +		struct iio_chan_spec *chan = chan_array + idx;
>>> +		chan->type = IIO_VOLTAGE;
>>> +		chan->indexed = 1;
>>> +		chan->channel = bit;
>>> +		chan->scan_type.sign = 'u';
>>> +		chan->scan_type.realbits = 10;
>>> +		chan->info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT;
>>> +		++idx;
>>> +	}
>>> +
>>> +	idev->channels = chan_array;
>>> +	return idev->num_channels;
>>> +}
>>> +
>>> +static void at91adc_channel_remove(struct iio_dev *idev)
>>> +{
>>> +	kfree(idev->channels);
>>> +}
>>> +
>>> +static int at91adc_read_raw(struct iio_dev *idev,
>>> +			    struct iio_chan_spec const *chan,
>>> +			    int *val, int *val2, long mask)
>>> +{
>>> +	struct at91adc_state *st = iio_priv(idev);
>>> +	unsigned int scale_uv;
>>> +	short ret;
>>> +
>>> +	switch (mask) {
>>> +	case 0:
>>> +		mutex_lock(&st->lock);
>>> +
>>> +		at91adc_reg_write(st, AT91_ADC_CHER,
>>> +				  AT91_ADC_CH(chan->channel));
>>> +		at91adc_reg_write(st, AT91_ADC_IER,
>>> +				  AT91_ADC_EOC(chan->channel));
>>> +		at91adc_reg_write(st, AT91_ADC_CR, AT91_ADC_START);
>>> +
>>> +		ret = wait_event_interruptible_timeout(st->wq_data_avail,
>>> +						       st->done,
>>> +						       msecs_to_jiffies(1000));
>>> +		if (ret == -ERESTARTSYS)
>>> +			break;
>>> +
>>> +		*val = st->last_value;
>>> +
>>> +		at91adc_reg_write(st, AT91_ADC_CHDR,
>>> +				  AT91_ADC_CH(chan->channel));
>>> +		at91adc_reg_write(st, AT91_ADC_IDR,
>>> +				  AT91_ADC_EOC(chan->channel));
>>> +
>>> +		st->last_value = 0;
>>> +		st->done = false;
>>> +		mutex_unlock(&st->lock);
>>> +		return IIO_VAL_INT;
>>> +
>>> +	case IIO_CHAN_INFO_SCALE:
>>> +		scale_uv = (st->vref_mv * 1000) >> chan->scan_type.realbits;
>>> +		*val = scale_uv / 1000;
>>> +		*val2 = (scale_uv % 1000) * 1000;
>>> +		return IIO_VAL_INT_PLUS_MICRO;
>>> +	default:
>>> +		break;
>>> +	}
>>> +	return -EINVAL;
>>> +}
>>> +
>>> +static const struct iio_info at91adc_info = {
>>> +	.driver_module = THIS_MODULE,
>>> +	.read_raw = &at91adc_read_raw,
>>> +};
>>> +
>>> +static int __devinit at91adc_probe(struct platform_device *pdev)
>>> +{
>>> +	unsigned int prsc, mstrclk, ticks;
>>> +	int ret;
>>> +	struct iio_dev *idev;
>>> +	struct at91adc_state *st;
>>> +	struct resource *res;
>>> +	struct at91_adc_data *pdata = pdev->dev.platform_data;
>>> +
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	if (!res) {
>>> +		dev_err(&pdev->dev, "No resource defined\n");
>>> +		ret = -ENXIO;
>>> +		goto error_ret;
>>> +	}
>>> +
>>> +	idev = iio_device_allocate(sizeof(struct at91adc_state));
>>> +	if (idev == NULL) {
>>> +		ret = -ENOMEM;
>>> +		goto error_ret;
>>> +	}
>>> +	platform_set_drvdata(pdev, idev);
>>> +
>>> +	idev->dev.parent = &pdev->dev;
>>> +	idev->name = dev_name(&pdev->dev);
>>> +	idev->info = &at91adc_info;
>>> +
>>> +	st = iio_priv(idev);
>>> +	st->irq = platform_get_irq(pdev, 0);
>>> +	if (st->irq < 0) {
>>> +		dev_err(&pdev->dev, "No IRQ ID is designated\n");
>>> +		ret = -ENODEV;
>>> +		goto error_free_device;
>>> +	}
>>> +
>>> +	if (!request_mem_region(res->start, resource_size(res),
>>> +				"AT91 adc registers")) {
>>> +		dev_err(&pdev->dev, "Resources are unavailable.\n");
>>> +		ret = -EBUSY;
>>> +		goto error_free_device;
>>> +	}
>>> +
>>> +	st->reg_base = ioremap(res->start, resource_size(res));
>>> +	if (!st->reg_base) {
>>> +		dev_err(&pdev->dev, "Failed to map registers.\n");
>>> +		ret = -ENOMEM;
>>> +		goto error_release_mem;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Disable all IRQs before setting up the handler
>>> +	 */
>>> +	at91adc_reg_write(st, AT91_ADC_CR, AT91_ADC_SWRST);
>>> +	at91adc_reg_write(st, AT91_ADC_IDR, 0xFFFFFFFF);
>>> +	ret = request_irq(st->irq,
>>> +			  at91adc_eoc_trigger, 0, pdev->dev.driver->name, idev);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev, "Failed to allocate IRQ.\n");
>>> +		goto error_unmap_reg;
>>> +	}
>>> +
>>> +	st->clk = clk_get(&pdev->dev, "adc_clk");
>>> +	if (IS_ERR(st->clk)) {
>>> +		dev_err(&pdev->dev, "Failed to get the clock.\n");
>>> +		ret = PTR_ERR(st->clk);
>>> +		goto error_free_irq;
>>> +	}
>>> +
>>> +	clk_enable(st->clk);
>>> +	mstrclk = clk_get_rate(st->clk);
>>> +
>>> +	if (!pdata) {
>>> +		dev_err(&pdev->dev, "No platform data available.\n");
>>> +		ret = -EINVAL;
>>> +		goto error_free_clk;
>>> +	}
>>> +
>>> +	if (!pdata->adc_clock) {
>>> +		dev_err(&pdev->dev, "No ADCClock available.\n");
>>> +		ret = -EINVAL;
>>> +		goto error_free_clk;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Prescaler rate computation using the formula from the Atmel's
>>> +	 * datasheet : ADC Clock = MCK / ((Prescaler + 1) * 2), ADC Clock being
>>> +	 * specified by the electrical characteristics of the board.
>>> +	 */
>>> +	prsc = (mstrclk / (2 * pdata->adc_clock)) - 1;
>>> +
>>> +	if (!pdata->startup_time) {
>>> +		dev_err(&pdev->dev, "No startup time available.\n");
>>> +		ret = -EINVAL;
>>> +		goto error_free_clk;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Number of ticks needed to cover the startup time of the ADC as
>>> +	 * defined in the electrical characteristics of the board, divided by 8.
>>> +	 * The formula thus is : Startup Time = (ticks + 1) * 8 / ADC Clock
>>> +	 */
>>> +	ticks = round_up((pdata->startup_time * pdata->adc_clock /
>>> +			  1000000) - 1, 8) / 8;
>>> +	at91adc_reg_write(st, AT91_ADC_MR,
>>> +			  (AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL) |
>>> +			  (AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP));
>>> +
>>> +	/* Setup the ADC channels available on the board */
>>> +	ret = at91adc_channel_init(idev, pdata);
>>> +	if (ret < 0)
>>> +		goto error_free_clk;
>>> +
>>> +	init_waitqueue_head(&st->wq_data_avail);
>>> +	mutex_init(&st->lock);
>>> +
>>> +	st->vref_mv = pdata->vref;
>>> +
>>> +	ret = iio_device_register(idev);
>>> +	if (ret < 0)
>>> +		goto error_free_channels;
>>> +
>>> +	return 0;
>>> +
>>> +error_free_channels:
>>> +	at91adc_channel_remove(idev);
>>> +error_free_clk:
>>> +	clk_disable(st->clk);
>>> +	clk_put(st->clk);
>>> +error_free_irq:
>>> +	free_irq(st->irq, st);
>>> +error_unmap_reg:
>>> +	iounmap(st->reg_base);
>>> +error_release_mem:
>>> +	release_mem_region(res->start, resource_size(res));
>>> +error_free_device:
>>> +	iio_device_free(idev);
>>> +error_ret:
>>> +	return ret;
>>> +}
>>> +
>>> +static int __devexit at91adc_remove(struct platform_device *pdev)
>>> +{
>>> +	struct iio_dev *idev = platform_get_drvdata(pdev);
>>> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	struct at91adc_state *st = iio_priv(idev);
>>> +
>>> +	iio_device_unregister(idev);
>>> +	at91adc_channel_remove(idev);
>>> +	clk_disable(st->clk);
>>> +	clk_put(st->clk);
>>> +	free_irq(st->irq, idev);
>>> +	iounmap(st->reg_base);
>>> +	release_mem_region(res->start, resource_size(res));
>>> +	iio_device_free(idev);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static struct platform_driver at91adc_driver = {
>>> +	.probe = at91adc_probe,
>>> +	.remove = __devexit_p(at91adc_remove),
>>> +	.driver = {
>>> +		   .name = "at91adc",
>>> +	},
>>> +};
>>> +
>>> +module_platform_driver(at91adc_driver);
>>> +
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_DESCRIPTION("Atmel AT91 ADC Driver");
>>> +MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
