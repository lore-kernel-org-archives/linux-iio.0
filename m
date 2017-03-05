Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60650 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbdCEOko (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 09:40:44 -0500
Subject: Re: [PATCH] iio: adc: add max1117/max1118/max1119 ADC driver
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1488717210-25151-1-git-send-email-akinobu.mita@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <dba84b94-e398-4362-2a7b-1f5dcfa9e5a0@kernel.org>
Date: Sun, 5 Mar 2017 14:31:59 +0000
MIME-Version: 1.0
In-Reply-To: <1488717210-25151-1-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/03/17 12:33, Akinobu Mita wrote:
> This adds max1117/max1118/max1119 8-bit, dual-channel ADC driver.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
Hi Akinobu,

The SPI usage is 'unusual' enough that I'd like Mark Brown to take a quick
look and give a view on whether it will always work or not.
cc'd Mark and linux-spi.

A few other comments inline.

Thanks,

Jonathan
> ---
>  .../devicetree/bindings/iio/adc/max1118.txt        |  21 ++
>  drivers/iio/adc/Kconfig                            |  12 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/max1118.c                          | 310 +++++++++++++++++++++
>  4 files changed, 344 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/max1118.txt
>  create mode 100644 drivers/iio/adc/max1118.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/max1118.txt b/Documentation/devicetree/bindings/iio/adc/max1118.txt
> new file mode 100644
> index 0000000..cf33d0b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/max1118.txt
> @@ -0,0 +1,21 @@
> +* MAX1117/MAX1118/MAX1119 8-bit, dual-channel ADCs
> +
> +Required properties:
> + - compatible: Should be one of
> +	* "maxim,max1117"
> +	* "maxim,max1118"
> +	* "maxim,max1119"
> + - reg: spi chip select number for the device
> + - (max1118 only) vref-supply: The regulator supply for ADC reference voltage
> +
> +Recommended properties:
> + - spi-max-frequency: Definition as per
> +		Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Example:
> +adc@0 {
> +	compatible = "maxim,max1118";
> +	reg = <0>;
> +	vref-supply = <&vdd_supply>;
> +	spi-max-frequency = <1000000>;
> +};
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index dedae7a..66262d1 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -335,6 +335,18 @@ config MAX11100
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called max11100.
>  
> +config MAX1118
> +	tristate "Maxim max1117/max1118/max1119 ADCs driver"
> +	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to build support for Maxim max1117/max1118/max1119
> +	  8-bit, dual-channel ADCs.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called max1118.
> +
>  config MAX1363
>  	tristate "Maxim max1363 ADC driver"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d001262..5ef3470 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
>  obj-$(CONFIG_LTC2485) += ltc2485.o
>  obj-$(CONFIG_MAX1027) += max1027.o
>  obj-$(CONFIG_MAX11100) += max11100.o
> +obj-$(CONFIG_MAX1118) += max1118.o
>  obj-$(CONFIG_MAX1363) += max1363.o
>  obj-$(CONFIG_MCP320X) += mcp320x.o
>  obj-$(CONFIG_MCP3422) += mcp3422.o
> diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
> new file mode 100644
> index 0000000..f2597b7
> --- /dev/null
> +++ b/drivers/iio/adc/max1118.c
> @@ -0,0 +1,310 @@
> +/*
> + * MAX1117/MAX1118/MAX1119 8-bit, dual-channel ADCs driver
> + *
> + * Copyright (c) 2017 Akinobu Mita <akinobu.mita@gmail.com>
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX1117-MAX1119.pdf
> + *
> + * SPI interface connections
> + *
> + * SPI                MAXIM
> + * Master  Direction  MAX1117/8/9
> + * ------  ---------  -----------
> + * nCS        -->     CNVST
> + * SCK        -->     SCLK
> + * MISO       <--     DOUT
> + * ------  ---------  -----------
> + */
> +
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/regulator/consumer.h>
> +
> +enum max1118_id {
> +	max1117,
> +	max1118,
> +	max1119,
> +};
> +
> +struct max1118 {
> +	struct spi_device *spi;
> +	struct mutex lock;
> +	struct regulator *reg;
> +
> +	u8 data ____cacheline_aligned;
> +};
> +
> +#define MAX1118_CHANNEL(ch)						\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.channel = (ch),					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.scan_index = ch,					\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = 8,					\
> +			.storagebits = 8,				\
> +		},							\
> +	}
> +
> +static const struct iio_chan_spec max1118_channels[] = {
> +	MAX1118_CHANNEL(0),
> +	MAX1118_CHANNEL(1),
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
> +};
> +
> +static int max1118_read(struct spi_device *spi, int channel)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct max1118 *adc = iio_priv(indio_dev);
> +	struct spi_transfer xfers[] = {
> +		/*
> +		 * To select CH1 for conversion, CNVST pin must be brought high
> +		 * and low for a second time.
> +		 */
> +		{
> +			.len = 0,
> +			.delay_usecs = 1,	/* > CNVST Low Time 100 ns */
> +			.cs_change = 1,
> +		},
> +		/*
> +		 * The acquisition interval begins with the falling edge of
> +		 * CNVST.  The total acquisition and conversion process takes
> +		 * <7.5us.
> +		 */
> +		{
> +			.len = 0,
Is this guaranteed to actually work?  I've no idea what the spi core
does with a zero length transfer.
> +			.delay_usecs = 8,
> +		},
> +		{
> +			.rx_buf = &adc->data,
> +			.len = 1,
> +		},
> +	};
> +	int ret;
> +
> +	if (channel == 0)
> +		ret = spi_sync_transfer(spi, xfers + 1, 2);
> +	else
> +		ret = spi_sync_transfer(spi, xfers, 3);
> +
> +	if (ret)
> +		return ret;
> +
> +	return adc->data;
> +}
> +
> +static int max1118_get_vref_mV(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct max1118 *adc = iio_priv(indio_dev);
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	int vref_uV;
> +
> +	switch (id->driver_data) {
> +	case max1117:
> +		return 2048;
> +	case max1119:
> +		return 4096;
> +	case max1118:
> +		if (IS_ERR_OR_NULL(adc->reg))
> +			return -EINVAL;
Again, make it non optional and drop it.

If it really is optional, you should have two iio_info structures and
not have the scale available on one of them...
> +
> +		vref_uV = regulator_get_voltage(adc->reg);
> +		if (vref_uV < 0)
> +			return vref_uV;
> +		return vref_uV / 1000;
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static int max1118_read_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			int *val, int *val2, long mask)
> +{
> +	struct max1118 *adc = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&adc->lock);
> +		*val = max1118_read(adc->spi, chan->channel);
> +		mutex_unlock(&adc->lock);
> +		if (*val < 0)
> +			return *val;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = max1118_get_vref_mV(adc->spi);
> +		if (*val < 0)
> +			return *val;
> +		*val2 = 8;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info max1118_info = {
> +	.read_raw = max1118_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int max1118_remove(struct spi_device *spi)
Code ordering is a little unusual.  Please move this to after the probe.
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct max1118 *adc = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
> +	if (!IS_ERR_OR_NULL(adc->reg))
The regulator isn't optional so to have gotten here you have succesfully
acquired it or been passed a fake one.
> +		return regulator_disable(adc->reg);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t max1118_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct max1118 *adc = iio_priv(indio_dev);
> +	u8 data[16] = { }; /* 2x 8-bit ADC data + padding + 8 bytes timestamp */
> +	int scan_index;
> +	int i = 0;
> +
> +	mutex_lock(&adc->lock);
> +
> +	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
> +			indio_dev->masklength) {
> +		const struct iio_chan_spec *scan_chan =
> +				&indio_dev->channels[scan_index];
> +		int ret = max1118_read(adc->spi, scan_chan->channel);
> +
> +		if (ret < 0) {
> +			dev_warn(&adc->spi->dev,
> +				"failed to get conversion data\n");
> +			goto out;
> +		}
> +
> +		data[i] = ret;
> +		i++;
> +	}
> +	iio_push_to_buffers_with_timestamp(indio_dev, data,
> +					   iio_get_time_ns(indio_dev));
> +out:
> +	mutex_unlock(&adc->lock);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int max1118_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct max1118 *adc;
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(indio_dev);
> +	adc->spi = spi;
> +	mutex_init(&adc->lock);
> +
> +	adc->reg = devm_regulator_get(&spi->dev, "vref");
> +	if (PTR_ERR(adc->reg) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
> +	if (IS_ERR_OR_NULL(adc->reg) && id->driver_data == max1118) {
> +		dev_warn(&spi->dev, "max1118 requires vref-supply\n");
Not a warning as it's not optional.  Error out on this.
If one isn't specified, the regulator framework will feed you a fake
one anyway..

Looking further up, this should only be requested for the max1118, but
should be required for that one part.
> +	} else {
> +		ret = regulator_enable(adc->reg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->info = &max1118_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = max1118_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max1118_channels);
> +
> +	/*
> +	 * To reinitiate a conversion on CH0, it is necessary to allow for a
> +	 * conversion to be complete and all of the data to be read out.  Once
> +	 * a conversion has been completed, the MAX1117/MAX1118/MAX1119 will go
> +	 * into AutoShutdown mode until the next conversion is initiated.
> +	 */
> +	max1118_read(spi, 0);
> +
> +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +					max1118_trigger_handler, NULL);
> +	if (ret)
> +		goto err_reg_disable;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto err_buffer_cleanup;
> +
> +	return 0;
> +
> +err_buffer_cleanup:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +err_reg_disable:
Clean this up once you have made a failure to get the regulator drop out.
Needs to be dependent on the device type not whether there is a regulator
or not.
> +	if (!IS_ERR_OR_NULL(adc->reg))
> +		regulator_disable(adc->reg);
> +
> +	return ret;
> +}
> +
> +static const struct spi_device_id max1118_id[] = {
> +	{ "max1117", max1117 },
> +	{ "max1118", max1118 },
> +	{ "max1119", max1119 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, max1118_id);
> +
> +#ifdef CONFIG_OF
> +
> +static const struct of_device_id max1118_dt_ids[] = {
> +	{ .compatible = "maxim,max1117" },
> +	{ .compatible = "maxim,max1118" },
> +	{ .compatible = "maxim,max1119" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, max1118_dt_ids);
> +
> +#endif
> +
> +static struct spi_driver max1118_spi_driver = {
> +	.driver = {
> +		.name = "max1118",
> +		.of_match_table = of_match_ptr(max1118_dt_ids),
> +	},
> +	.probe = max1118_probe,
> +	.remove = max1118_remove,
> +	.id_table = max1118_id,
> +};
> +module_spi_driver(max1118_spi_driver);
> +
> +MODULE_AUTHOR("Akinobu Mita <akinobu.mita@gmail.com>");
> +MODULE_DESCRIPTION("MAXIM MAX1117/MAX1118/MAX1119 ADCs driver");
> +MODULE_LICENSE("GPL v2");
> 

