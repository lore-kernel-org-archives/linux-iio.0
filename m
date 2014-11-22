Return-Path: <knaack.h@gmx.de>
Message-ID: <546FE3A7.6040308@gmx.de>
Date: Sat, 22 Nov 2014 02:15:19 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
 Andrew Bresticker <abrestic@chromium.org>,
 James Hartley <james.hartley@imgtec.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, Pawel.Moll@arm.com, Mark.Rutland@arm.com,
 ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
 Naidu.Tellapati@imgtec.com, Phani Movva <Phani.Movva@imgtec.com>
Subject: Re: [PATCH v3 1/3] iio: adc: Cosmic Circuits 10001 ADC driver
References: <1415888044-16635-1-git-send-email-ezequiel.garcia@imgtec.com> <1415888044-16635-2-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1415888044-16635-2-git-send-email-ezequiel.garcia@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Ezequiel Garcia schrieb am 13.11.2014 15:13:
> From: Phani Movva <Phani.Movva@imgtec.com>
> 
> This commit adds support for Cosmic Circuits 10001 10-bit ADC device.
A few more issues - some got newly introduced, some have been overseen earlier (and some are just matter of taste ;-)
> 
> Signed-off-by: Phani Movva <Phani.Movva@imgtec.com>
> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> [Ezequiel: code style cleaning]
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> ---
>  drivers/iio/adc/Kconfig       |  11 ++
>  drivers/iio/adc/Makefile      |   1 +
>  drivers/iio/adc/cc10001_adc.c | 425 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 437 insertions(+)
>  create mode 100644 drivers/iio/adc/cc10001_adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 88bdc8f..09e2975 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -127,6 +127,17 @@ config AT91_ADC
>  	help
>  	  Say yes here to build support for Atmel AT91 ADC.
>  
> +config CC10001_ADC
> +	tristate "Cosmic Circuits 10001 ADC driver"
> +	depends on HAS_IOMEM
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to build support for Cosmic Circuits 10001 ADC.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called cc10001_adc.
> +
>  config EXYNOS_ADC
>  	tristate "Exynos ADC driver support"
>  	depends on ARCH_EXYNOS || ARCH_S3C24XX || ARCH_S3C64XX || (OF && COMPILE_TEST)
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index cb88a6a..9286c59 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_AD7793) += ad7793.o
>  obj-$(CONFIG_AD7887) += ad7887.o
>  obj-$(CONFIG_AD799X) += ad799x.o
>  obj-$(CONFIG_AT91_ADC) += at91_adc.o
> +obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
>  obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>  obj-$(CONFIG_MAX1027) += max1027.o
> diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
> new file mode 100644
> index 0000000..0b74838
> --- /dev/null
> +++ b/drivers/iio/adc/cc10001_adc.c
> @@ -0,0 +1,425 @@
> +/*
> + * Copyright (c) 2014 Imagination Technologies Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +/* Registers */
> +#define CC10001_ADC_CONFIG		0x00
> +#define CC10001_ADC_START_CONV		BIT(4)
> +#define CC10001_ADC_MODE_SINGLE_CONV	BIT(5)
> +
> +#define CC10001_ADC_DDATA_OUT		0x04
> +#define CC10001_ADC_EOC			0x08
> +#define CC10001_ADC_EOC_SET		BIT(0)
> +
> +#define CC10001_ADC_CHSEL_SAMPLED	0x0c
> +#define CC10001_ADC_POWER_UP		0x10
> +#define CC10001_ADC_POWER_UP_SET	BIT(0)
> +#define CC10001_ADC_DEBUG		0x14
> +#define CC10001_ADC_DATA_COUNT		0x20
> +
> +#define CC10001_ADC_DATA_MASK		GENMASK(9, 0)
> +#define CC10001_ADC_NUM_CHANNELS	8
> +#define CC10001_ADC_CH_MASK		(CC10001_ADC_NUM_CHANNELS - 1)
Don't define CC10001_ADC_CH_MASK this way, as it implies a simple relation to CC10001_ADC_NUM_CHANNELS, but it actually requires it to be base 2 (which it happens to be in this case). Preferably use GENMASK(2, 0).
> +
> +#define CC10001_INVALID_SAMPLED_OUTPUT	0xFFFF
After changing your hex values to lower case, this one is still left.
> +#define CC10001_MAX_POLL_COUNT		20
> +
> +/*
> + * As per device specification, wait six clock cycles after power-up to
> + * activate START. Since adding two more clock cycles delay does not
> + * impact the performance too much, we are adding two additional cycles delay
> + * intentionally here.
> + */
> +#define	CC10001_WAIT_CYCLES		8
> +
> +struct cc10001_adc_device {
> +	void __iomem *reg_base;
> +	struct iio_dev *indio_dev;
This element is never used.
> +	struct clk *adc_clk;
> +	struct regulator *reg;
> +	u16 *buf;
> +
> +	struct mutex lock;
> +	unsigned long channel_map;
> +	unsigned int start_delay_ns;
> +	unsigned int eoc_delay_ns;
> +};
> +
> +static inline void cc10001_adc_write_reg(struct cc10001_adc_device *adc_dev,
> +					 u32 reg, u32 val)
> +{
> +	writel(val, adc_dev->reg_base + reg);
> +}
> +
> +static inline u32 cc10001_adc_read_reg(struct cc10001_adc_device *adc_dev,
> +				       u32 reg)
> +{
> +	return readl(adc_dev->reg_base + reg);
> +}
> +
> +static void cc10001_adc_start(struct cc10001_adc_device *adc_dev,
> +			      unsigned int channel)
> +{
> +	u32 val;
> +
> +	/* Channel selection and mode of operation */
> +	val = (channel & CC10001_ADC_CH_MASK) | CC10001_ADC_MODE_SINGLE_CONV;
> +	cc10001_adc_write_reg(adc_dev, CC10001_ADC_CONFIG, val);
> +
> +	val = cc10001_adc_read_reg(adc_dev, CC10001_ADC_CONFIG);
> +	val = val | CC10001_ADC_START_CONV;
> +	cc10001_adc_write_reg(adc_dev, CC10001_ADC_CONFIG, val);
> +}
> +
> +static u16 cc10001_adc_poll_done(struct iio_dev *indio_dev,
> +				 unsigned int channel,
> +				 unsigned int delay)
> +{
> +	struct cc10001_adc_device *adc_dev = iio_priv(indio_dev);
> +	unsigned int poll_count = 0;
> +
> +	while (!(cc10001_adc_read_reg(adc_dev, CC10001_ADC_EOC) &
> +			CC10001_ADC_EOC_SET)) {
Matter of taste case here, and I understand that indenting it to align with cc10001_adc_read_reg would look like the indentation of the following subroutine. Then again, you left an empty line to show a certain distinction. Up to you, I just slightly prefer to align blocks with equal hierarchy levels.
> +
> +		ndelay(delay);
> +		if (poll_count++ == CC10001_MAX_POLL_COUNT)
> +			return CC10001_INVALID_SAMPLED_OUTPUT;
> +	}
> +
> +	poll_count = 0;
> +	while ((cc10001_adc_read_reg(adc_dev, CC10001_ADC_CHSEL_SAMPLED) &
> +			CC10001_ADC_CH_MASK) != channel) {
Same here.
> +
> +		ndelay(delay);
> +		if (poll_count++ == CC10001_MAX_POLL_COUNT)
> +			return CC10001_INVALID_SAMPLED_OUTPUT;
> +	}
> +
> +	/* Read the 10 bit output register */
> +	return cc10001_adc_read_reg(adc_dev, CC10001_ADC_DDATA_OUT) &
> +			       CC10001_ADC_DATA_MASK;
Here I feel stronger about alignment.
> +}
> +
> +static irqreturn_t cc10001_adc_trigger_h(int irq, void *p)
> +{
> +	struct cc10001_adc_device *adc_dev;
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev;
> +	unsigned int delay_ns;
> +	unsigned int channel;
> +	bool sample_invalid;
> +	u16 *data;
> +	int i;
> +
> +	indio_dev = pf->indio_dev;
> +	adc_dev = iio_priv(indio_dev);
> +	data = adc_dev->buf;
> +
> +	mutex_lock(&adc_dev->lock);
> +
> +	cc10001_adc_write_reg(adc_dev, CC10001_ADC_POWER_UP,
> +			      CC10001_ADC_POWER_UP_SET);
> +
> +	/* Wait for 8 (6+2) clock cycles before activating START */
> +	ndelay(adc_dev->start_delay_ns);
> +
> +	/* Calculate delay step for eoc and sampled data */
> +	delay_ns = adc_dev->eoc_delay_ns / CC10001_MAX_POLL_COUNT;
> +
> +	i = 0;
> +	sample_invalid = false;
These definitions could be done already during declaration.
> +	for_each_set_bit(channel, indio_dev->active_scan_mask,
> +				  indio_dev->masklength) {
Too much indentation, it should be aligned with channel.
> +
> +		cc10001_adc_start(adc_dev, channel);
> +
> +		data[i] = cc10001_adc_poll_done(indio_dev, channel, delay_ns);
> +		if (data[i] == CC10001_INVALID_SAMPLED_OUTPUT) {
> +			dev_warn(&indio_dev->dev,
> +				 "invalid sample on channel %d\n", channel);
> +			sample_invalid = true;
> +			goto done;
> +		}
> +		i++;
> +	}
> +
> +done:
> +	cc10001_adc_write_reg(adc_dev, CC10001_ADC_POWER_UP, 0);
> +
> +	mutex_unlock(&adc_dev->lock);
> +
> +	if (!sample_invalid)
> +		iio_push_to_buffers_with_timestamp(indio_dev, data,
> +						   iio_get_time_ns());
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static u16 cc10001_adc_read_raw_voltage(struct iio_dev *indio_dev,
> +					struct iio_chan_spec const *chan)
> +{
> +	struct cc10001_adc_device *adc_dev = iio_priv(indio_dev);
> +	unsigned int delay_ns;
> +	u16 val;
> +
> +	cc10001_adc_write_reg(adc_dev, CC10001_ADC_POWER_UP,
> +			      CC10001_ADC_POWER_UP_SET);
> +
> +	/* Wait for 8 (6+2) clock cycles before activating START */
> +	ndelay(adc_dev->start_delay_ns);
> +
> +	/* Calculate delay step for eoc and sampled data */
> +	delay_ns = adc_dev->eoc_delay_ns / CC10001_MAX_POLL_COUNT;
> +
> +	cc10001_adc_start(adc_dev, chan->channel);
> +
> +	val = cc10001_adc_poll_done(indio_dev, chan->channel, delay_ns);
> +
> +	cc10001_adc_write_reg(adc_dev, CC10001_ADC_POWER_UP, 0);
> +
> +	return val;
> +}
> +
> +static int cc10001_adc_read_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int *val, int *val2, long mask)
> +{
> +	struct cc10001_adc_device *adc_dev = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (iio_buffer_enabled(indio_dev))
> +			return -EBUSY;
> +		mutex_lock(&adc_dev->lock);
> +		*val = cc10001_adc_read_raw_voltage(indio_dev, chan);
> +		mutex_unlock(&adc_dev->lock);
> +
> +		if (*val == CC10001_INVALID_SAMPLED_OUTPUT)
> +			return -EIO;
> +		return IIO_VAL_INT;
Since C offers it:
		return (*val == CC10001_INVALID_SAMPLED_OUTPUT) ? -EIO : IIO_VAL_INT;
It would fit in one line if CC10001_INVALID_SAMPLED_OUTPUT was called CC10001_INVALID_SAMPLE ;-)
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = regulator_get_voltage(adc_dev->reg);
> +		if (ret)
> +			return ret;
> +
> +		*val = ret / 1000;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int cc10001_update_scan_mode(struct iio_dev *indio_dev,
> +				     const unsigned long *scan_mask)
Reduce indentation by one space.
> +{
> +	struct cc10001_adc_device *adc_dev = iio_priv(indio_dev);
> +
> +	kfree(adc_dev->buf);
> +	adc_dev->buf = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> +	if (!adc_dev->buf)
> +		return -ENOMEM;
> +
> +	return 0;
Save some lines:
	return (!adc_dev->buf) ? -ENOMEM : 0;
> +}
> +
> +static const struct iio_info cc10001_adc_info = {
> +	.driver_module = THIS_MODULE,
> +	.read_raw = &cc10001_adc_read_raw,
> +	.update_scan_mode = &cc10001_update_scan_mode,
> +};
> +
> +static int cc10001_adc_channel_init(struct iio_dev *indio_dev)
> +{
> +	struct cc10001_adc_device *adc_dev = iio_priv(indio_dev);
> +	struct iio_chan_spec *chan_array, *timestamp;
> +	unsigned int bit, idx = 0;
> +
> +	indio_dev->num_channels = bitmap_weight(&adc_dev->channel_map,
> +						CC10001_ADC_NUM_CHANNELS);
> +
> +	chan_array = devm_kcalloc(&indio_dev->dev, indio_dev->num_channels + 1,
> +				  sizeof(struct iio_chan_spec),
> +				  GFP_KERNEL);
> +	if (!chan_array)
> +		return -ENOMEM;
> +
> +	for_each_set_bit(bit, &adc_dev->channel_map,
> +			 CC10001_ADC_NUM_CHANNELS) {
No need to wrap, this fits exactly 80 chars.
> +		struct iio_chan_spec *chan = &chan_array[idx];
> +
> +		chan->type = IIO_VOLTAGE;
> +		chan->indexed = 1;
> +		chan->channel = bit;
> +		chan->scan_index = idx;
> +		chan->scan_type.sign = 'u';
> +		chan->scan_type.realbits = 10;
> +		chan->scan_type.storagebits = 16;
> +		chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
> +		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +		idx++;
> +	}
> +
> +	timestamp = &chan_array[idx];
> +	timestamp->type = IIO_TIMESTAMP;
> +	timestamp->channel = -1;
> +	timestamp->scan_index = idx;
> +	timestamp->scan_type.sign = 's';
> +	timestamp->scan_type.realbits = 64;
> +	timestamp->scan_type.storagebits = 64;
> +
> +	indio_dev->channels = chan_array;
> +
> +	return 0;
> +}
> +
> +static int cc10001_adc_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct cc10001_adc_device *adc_dev;
> +	unsigned long adc_clk_rate;
> +	struct resource *res;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc_dev));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
> +	adc_dev = iio_priv(indio_dev);
> +
> +	adc_dev->channel_map = CC10001_ADC_CH_MASK;
You certainly want adc_dev->channel_map to be something like GENMASK(CC10001_ADC_NUM_CHANNELS -1, 0).
> +	if (!of_property_read_u32(node, "cosmic,reserved-adc-channels", &ret))
> +		adc_dev->channel_map ^= ret;
Correct way is to mask out, not to XOR.
> +
> +	adc_dev->reg = devm_regulator_get(&pdev->dev, "vref");
> +	if (IS_ERR_OR_NULL(adc_dev->reg))
> +		return -EINVAL;
	if (IS_ERR(adc_dev->reg))
		return PTR_ERR(adc_dev->reg);
> +
> +	ret = regulator_enable(adc_dev->reg);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->name = dev_name(&pdev->dev);
> +	indio_dev->info = &cc10001_adc_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	adc_dev->reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(adc_dev->reg_base))
Need to put error code into ret.
> +		goto err_disable_reg;
> +
> +	adc_dev->adc_clk = devm_clk_get(&pdev->dev, "adc");
> +	if (IS_ERR(adc_dev->adc_clk)) {
> +		dev_err(&pdev->dev, "Failed to get the clock\n");
Need to put error code into ret.
> +		goto err_disable_reg;
> +	}
> +
> +	ret = clk_prepare_enable(adc_dev->adc_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to enable the clock\n");
> +		goto err_disable_reg;
> +	}
> +
> +	adc_clk_rate = clk_get_rate(adc_dev->adc_clk);
> +	if (!adc_clk_rate) {
> +		ret = -EINVAL;
> +		dev_err(&pdev->dev, "null clock rate!\n");
Start message with upper case?
> +		goto err_disable_clk;
> +	}
> +
> +	adc_dev->eoc_delay_ns = NSEC_PER_SEC / adc_clk_rate;
> +	adc_dev->start_delay_ns = adc_dev->eoc_delay_ns * CC10001_WAIT_CYCLES;
> +
> +	/* Setup the ADC channels available on the device */
> +	ret = cc10001_adc_channel_init(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Could not initialize the channels.\n");
> +		goto err_disable_clk;
> +	}
> +
> +	mutex_init(&adc_dev->lock);
> +
> +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +					 &cc10001_adc_trigger_h, NULL);
> +	if (ret < 0)
> +		goto err_disable_clk;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		goto err_cleanup_buffer;
> +
> +	platform_set_drvdata(pdev, indio_dev);
Move this above iio_device_register.
> +
> +	return 0;
> +
> +err_cleanup_buffer:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +err_disable_clk:
> +	clk_disable_unprepare(adc_dev->adc_clk);
> +err_disable_reg:
> +	regulator_disable(adc_dev->reg);
> +	return ret;
> +}
> +
> +static int cc10001_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct cc10001_adc_device *adc_dev = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
> +	clk_disable_unprepare(adc_dev->adc_clk);
> +	regulator_disable(adc_dev->reg);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id cc10001_adc_dt_ids[] = {
> +	{ .compatible = "cosmic,10001-adc", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, cc10001_adc_dt_ids);
> +
> +static struct platform_driver cc10001_adc_driver = {
> +	.driver = {
> +		.name   = "cc10001-adc",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = cc10001_adc_dt_ids,
> +	},
> +	.probe	= cc10001_adc_probe,
> +	.remove	= cc10001_adc_remove,
> +};
> +module_platform_driver(cc10001_adc_driver);
> +
> +MODULE_AUTHOR("Phani Movva <Phani.Movva@imgtec.com>");
> +MODULE_DESCRIPTION("Cosmic Circuits ADC driver");
> +MODULE_LICENSE("GPL v2");
> 
