Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53827 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932126AbcA3Q7R (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2016 11:59:17 -0500
Subject: Re: [PATCH] iio: adc: add support for ADC0832 8-bit ADC chips
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-iio@vger.kernel.org
References: <1453998392-562-1-git-send-email-akinobu.mita@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56ACEBDF.4020108@kernel.org>
Date: Sat, 30 Jan 2016 16:59:11 +0000
MIME-Version: 1.0
In-Reply-To: <1453998392-562-1-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/01/16 16:26, Akinobu Mita wrote:
> This adds ADC0832 8-bit ADC driver.  This can also support
> ADC0831, ADC0834, and ADC0838 chips easily.  But I currently don't
> have these chips except ADC0832 and untested, so MODULE_DEVICE_TABLE
> for these are disabled for now.

Don't let lack of hardware stop you on that front ;)
I only have two of the parts supported by the max1363 driver for instance.

The only time that it really matters is for parts that are significantly
different in less than predictable ways.

Of course, if you are more diligent than me feel free to test them all.
The 0831 is different enough with that slightly odd timing that perhaps
you will want to test that one.

Anyhow, various bits inline, but mostly looking good.

Jonathan
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> ---
>  .../devicetree/bindings/iio/adc/ti-adc083x.txt     |  15 ++
>  drivers/iio/adc/Kconfig                            |  10 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/ti-adc083x.c                       | 296 +++++++++++++++++++++
Usually best to not use wild cards in device naming.  Marketting or whoever
had a horrible habit of not keeping nicely defined part number ranges.

Hence pick a part and name everything after that.
>  4 files changed, 322 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc083x.txt
>  create mode 100644 drivers/iio/adc/ti-adc083x.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc083x.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc083x.txt
> new file mode 100644
> index 0000000..caace65
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc083x.txt
> @@ -0,0 +1,15 @@
> +* Texas Instruments' ADC0832 ADC chip
> +
> +Required properties:
> + - compatible: Should be "ti,adc0832"
> + - reg: spi chip select number for the device
> + - vref-supply: The regulator supply for ADC reference voltage
> + - spi-max-frequency: Max SPI frequency to use (< 400000)
> +
> +Example:
> +adc@0 {
> +	compatible = "ti,adc0832";
> +	reg = <0>;
> +	vref-supply = <&vdd_supply>;
> +	spi-max-frequency = <200000>;
> +};
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index e421030..387f8df 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -333,6 +333,16 @@ config TI_ADC081C
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-adc081c.
>  
> +config TI_ADC083X
> +	tristate "Texas Instruments ADC0832"
> +	depends on SPI
> +	help
> +	  If you say yes here you get support for Texas Instruments ADC0832
> +	  ADC chips.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called ti-adc083x.
> +
>  config TI_ADC128S052
>  	tristate "Texas Instruments ADC128S052/ADC122S021"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 9d09b44..9815021 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
>  obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
>  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
> +obj-$(CONFIG_TI_ADC083X) += ti-adc083x.o
>  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>  obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
> diff --git a/drivers/iio/adc/ti-adc083x.c b/drivers/iio/adc/ti-adc083x.c
> new file mode 100644
> index 0000000..894e9cc
> --- /dev/null
> +++ b/drivers/iio/adc/ti-adc083x.c
> @@ -0,0 +1,296 @@
> +/*
> + * ADC0831/ADC0832/ADC0834/ADC0838 8-bit ADC driver
> + *
> + * Copyright (c) 2016 Akinobu Mita <akinobu.mita@gmail.com>
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * Datasheet: http://www.ti.com/lit/ds/symlink/adc0832-n.pdf
> + */
> +
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/iio/iio.h>
> +#include <linux/regulator/consumer.h>
> +
> +enum {
> +	adc0831,
> +	adc0832,
> +	adc0834,
> +	adc0838,
> +};
> +
> +struct adc083x {
> +	struct spi_device *spi;
> +	struct regulator *reg;
> +	struct mutex lock;
> +	u8 mux_bits;
> +
> +	u8 tx_buf[2] ____cacheline_aligned;
> +	u8 rx_buf[2];
> +};
> +
> +#define ADC083X_VOLTAGE_CHANNEL(chan)					\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.channel = chan,					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE)	\
> +	}
> +
> +#define ADC083X_VOLTAGE_CHANNEL_DIFF(chan1, chan2)			\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.channel = (chan1),					\
> +		.channel2 = (chan2),					\
> +		.differential = 1,					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE)	\
> +	}
> +
> +static const struct iio_chan_spec adc0831_channels[] = {
> +	ADC083X_VOLTAGE_CHANNEL_DIFF(0, 1),
> +};
> +
> +static const struct iio_chan_spec adc0832_channels[] = {
> +	ADC083X_VOLTAGE_CHANNEL(0),
> +	ADC083X_VOLTAGE_CHANNEL(1),
> +	ADC083X_VOLTAGE_CHANNEL_DIFF(0, 1),
> +	ADC083X_VOLTAGE_CHANNEL_DIFF(1, 0),
> +};
> +
> +static const struct iio_chan_spec adc0834_channels[] = {
> +	ADC083X_VOLTAGE_CHANNEL(0),
> +	ADC083X_VOLTAGE_CHANNEL(1),
> +	ADC083X_VOLTAGE_CHANNEL(2),
> +	ADC083X_VOLTAGE_CHANNEL(3),
> +	ADC083X_VOLTAGE_CHANNEL_DIFF(0, 1),
> +	ADC083X_VOLTAGE_CHANNEL_DIFF(1, 0),
> +	ADC083X_VOLTAGE_CHANNEL_DIFF(2, 3),
> +	ADC083X_VOLTAGE_CHANNEL_DIFF(3, 2),
> +};
> +
> +static const struct iio_chan_spec adc0838_channels[] = {
> +	ADC083X_VOLTAGE_CHANNEL(0),
> +	ADC083X_VOLTAGE_CHANNEL(1),
> +	ADC083X_VOLTAGE_CHANNEL(2),
> +	ADC083X_VOLTAGE_CHANNEL(3),
> +	ADC083X_VOLTAGE_CHANNEL(4),
> +	ADC083X_VOLTAGE_CHANNEL(5),
> +	ADC083X_VOLTAGE_CHANNEL(6),
> +	ADC083X_VOLTAGE_CHANNEL(7),
> +	ADC083X_VOLTAGE_CHANNEL_DIFF(0, 1),
> +	ADC083X_VOLTAGE_CHANNEL_DIFF(1, 0),
> +	ADC083X_VOLTAGE_CHANNEL_DIFF(2, 3),
> +	ADC083X_VOLTAGE_CHANNEL_DIFF(3, 2),
> +	ADC083X_VOLTAGE_CHANNEL_DIFF(4, 5),
> +	ADC083X_VOLTAGE_CHANNEL_DIFF(5, 4),
> +	ADC083X_VOLTAGE_CHANNEL_DIFF(6, 7),
> +	ADC083X_VOLTAGE_CHANNEL_DIFF(7, 6),
> +};
> +
> +static int adc0831_adc_conversion(struct adc083x *adc)
> +{
> +	struct spi_device *spi = adc->spi;
> +	int ret;
> +
> +	ret = spi_read(spi, &adc->rx_buf, 2);
> +	if (ret)
> +		return ret;
> +
> +	return (adc->rx_buf[0] << 2) | (adc->rx_buf[1] >> 6);
> +}
> +
> +static int adc083x_adc_conversion(struct adc083x *adc, int channel,
> +				bool differential)
> +{
> +	struct spi_device *spi = adc->spi;
> +	struct spi_transfer xfer = {
> +		.tx_buf = adc->tx_buf,
> +		.rx_buf = adc->rx_buf,
> +		.len = 2,
> +	};
> +	int ret;
> +
> +	if (!adc->mux_bits)
> +		return adc0831_adc_conversion(adc);
> +
> +	/* start bit */
Hmm.. This takes some getting one's head around!
As far as I can see you got it right.

One slight curiosity to my mind is that the diagramss all show an extra
pair of clock samples after the read out.  You explicitly do that
for the 8031 but not the other parts that I can see.  There is a cryptic
not 'LSB first output not available on 0831' which might be relevant
but I have no idea what it means!
> +	adc->tx_buf[0] = 1 << (adc->mux_bits + 1);
> +	/* single-ended or differential */
> +	adc->tx_buf[0] |= differential ? 0 : (1 << adc->mux_bits);
> +	/* odd / sign */
> +	adc->tx_buf[0] |= (channel % 2) << (adc->mux_bits - 1);
> +	/* select */
> +	if (adc->mux_bits > 1)
> +		adc->tx_buf[0] |= channel / 2;
> +
> +	/* align Data output BIT7 (MSB) to 8-bit boundary */
> +	adc->tx_buf[0] <<= 1;
> +
> +	ret = spi_sync_transfer(spi, &xfer, 1);
> +	if (ret)
> +		return ret;
> +
> +	return adc->rx_buf[1];
> +}
> +
> +static int adc083x_read_raw(struct iio_dev *iio,
> +			struct iio_chan_spec const *channel, int *value,
> +			int *shift, long mask)
> +{
> +	struct adc083x *adc = iio_priv(iio);
> +	int ret;
> +
I'd move the lock in a bit as it will simplify your program flow
somewhat.  Only needs to be held around the adc_conversion call
(I think)
> +	mutex_lock(&adc->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = adc083x_adc_conversion(adc, channel->channel,
> +						channel->differential);
> +		if (ret < 0)
> +			break;
> +
> +		*value = ret;
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = regulator_get_voltage(adc->reg);
> +		if (ret < 0)
> +			break;
> +
> +		/* convert regulator output voltage to mV */
> +		*value = ret / 1000;
> +		*shift = 8;
> +		ret = IIO_VAL_FRACTIONAL_LOG2;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	mutex_unlock(&adc->lock);
> +
> +	return ret;
> +}
> +
> +static const struct iio_info adc083x_info = {
> +	.read_raw = adc083x_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int adc083x_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct adc083x *adc;
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
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->info = &adc083x_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	switch (spi_get_device_id(spi)->driver_data) {
> +	case adc0831:
> +		adc->mux_bits = 0;
> +		indio_dev->channels = adc0831_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(adc0831_channels);
> +		break;
> +	case adc0832:
> +		adc->mux_bits = 1;
> +		indio_dev->channels = adc0832_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(adc0832_channels);
> +		break;
> +	case adc0834:
> +		adc->mux_bits = 2;
> +		indio_dev->channels = adc0834_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(adc0834_channels);
> +		break;
> +	case adc0838:
> +		adc->mux_bits = 3;
> +		indio_dev->channels = adc0838_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(adc0838_channels);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	adc->reg = devm_regulator_get(&spi->dev, "vref");
> +	if (IS_ERR(adc->reg))
> +		return PTR_ERR(adc->reg);
> +
> +	ret = regulator_enable(adc->reg);
> +	if (ret)
> +		return ret;
> +
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
> +	if (ret)
> +		regulator_disable(adc->reg);
> +
> +	return ret;
> +}
> +
> +static int adc083x_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct adc083x *adc = iio_priv(indio_dev);
> +
> +	regulator_disable(adc->reg);
The key thing to note here is that the unwinding of all managed
elements occurs after anything in remove.  Hence, in this case
you have turned the regulator off, before the iio_device_unregister
function gets called by the managed tear down.  That call is responsible
for removing the userspace and in kernel interfaces to the driver.

So, rule of thumb - the first time you hit a non devm call of significance
in your probe function is the point at which all futher calls cannot be done
as managed ones.  e.g. you need to do explicit iio_device_register
/ iio_device_unregister in this driver.
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +
> +static const struct of_device_id adc083x_dt_ids[] = {
> +	{ .compatible = "ti,adc0832", },
> +/* THESE CHIPS ARE NOT TESTED
> +	{ .compatible = "ti,adc0831", },
> +	{ .compatible = "ti,adc0834", },
> +	{ .compatible = "ti,adc0838", },
> +*/
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, adc083x_dt_ids);
> +
> +#endif
> +
> +static const struct spi_device_id adc083x_id[] = {
> +	{ "adc0832", adc0832 },
> +/* THESE CHIPS ARE NOT TESTED
Leave them in anyway.  It's not a part that is going to
break anything permanently if you have missed some small reason why
they don't work.  (more intesting with multirange DACs where they
might burn components!)
> +	{ "adc0831", adc0831 },
> +	{ "adc0834", adc0834 },
> +	{ "adc0838", adc0838 },
> +*/
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, adc083x_id);
> +
> +static struct spi_driver adc083x_driver = {
> +	.driver = {
> +		.name = "adc083x",
> +		.of_match_table = of_match_ptr(adc083x_dt_ids),
> +	},
> +	.probe = adc083x_probe,
> +	.remove = adc083x_remove,
> +	.id_table = adc083x_id,
> +};
> +module_spi_driver(adc083x_driver);
> +
> +MODULE_AUTHOR("Akinobu Mita <akinobu.mita@gmail.com>");
> +MODULE_DESCRIPTION("ADC0831/ADC0832/ADC0834/ADC0838 driver");
> +MODULE_LICENSE("GPL v2");
> 

