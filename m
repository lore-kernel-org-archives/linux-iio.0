Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-031.synserver.de ([212.40.185.31]:1124 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751865AbcAERUu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jan 2016 12:20:50 -0500
Subject: Re: [PATCH v3] iio: add ad5761 DAC driver
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1452013261-19096-1-git-send-email-ricardo.ribalda@gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <568BFB6F.2020705@metafoo.de>
Date: Tue, 5 Jan 2016 18:20:47 +0100
MIME-Version: 1.0
In-Reply-To: <1452013261-19096-1-git-send-email-ricardo.ribalda@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/05/2016 06:01 PM, Ricardo Ribalda Delgado wrote:
> ad5761 is a 1-channel DAC with configurable output range.
> The driver uses the regulator interface for its voltage ref.
> 
> It shares its register layout with ad5761r, ad5721 and ad5721r.
> 
> Differences:
> ad5761* are 16 bit, ad5721* are 12 bits.
> ad57*1r have an internal reference.
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Hi,

Thanks for the driver. Looks pretty good, a few comments inline.

[...]
> +enum ad5761_range_ids {
> +	MODE_M10V_10V,
> +	MODE_0V_10V,
> +	MODE_M5V_5V,
> +	MODE_0V_5V,
> +	MODE_M2V5_7V5,
> +	MODE_M3V_3V,
> +	MODE_0V_16V,
> +	MODE_0V_20V,

Those should have the AD5761 prefix to avoid name conflicts.

> +};
> +
> +static int ad5761_spi_set_range(struct ad5761_state *st,
> +				enum ad5761_voltage_range range)
> +{
> +	u16 aux;
> +	int ret;
> +
> +	aux = range | AD5761_CTRL_ETS;
> +
> +	if (st->use_intref)
> +		aux |= AD5761_CTRL_USE_INTVREF;
> +
> +	ret = ad5761_spi_write(st, AD5761_ADDR_CTRL_WRITE_REG, aux);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad5761_spi_write(st, AD5761_ADDR_SW_DATA_RESET, 0);
> +	if (ret)
> +		return ret;

The datasheet says:

	When the DAC output range is reconfigured during operation, a
	software full reset command (see Table 26) must be written to the
	device before writing to the control register.

This is just the data reset and it should be moved before the range change.

> +
> +	st->range = range;
> +
> +	return 0;
> +}
> +
> +static int ad5761_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val,
> +			   int *val2,
> +			   long mask)
> +{
> +	struct ad5761_state *st = iio_priv(indio_dev);
> +	int ret;
> +	u16 aux;

You'll need locking here to avoid concurrent access to the data field in the
state struct.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ad5761_spi_read(st, AD5761_ADDR_DAC_READ, &aux);
> +		if (ret)
> +			return ret;
> +		*val = aux >> chan->scan_type.shift;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->vref * ad5761_range_params[st->range].m;
> +		*val /= 10;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = -(1 << chan->scan_type.realbits);
> +		*val *=	ad5761_range_params[st->range].c;
> +		*val /=	ad5761_range_params[st->range].m;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad5761_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val,
> +			    int val2,
> +			    long mask)
> +{
> +	struct ad5761_state *st = iio_priv(indio_dev);
> +	u16 aux;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	aux = val << chan->scan_type.shift;
> +

Same here.

> +	return ad5761_spi_write(st, AD5761_ADDR_DAC_WRITE, aux);
> +}
> +
[...]
> +	if (IS_ERR(st->vref_reg)) {
> +		dev_err(&st->spi->dev,
> +			"Error getting voltage reference regulator\n");
> +		return -EIO;

This needs to propagate the original error, otherwise things like probed
deferring wont work.

> +	}
> +
> +	ret = regulator_enable(st->vref_reg);
> +	if (ret) {
> +		dev_err(&st->spi->dev,
> +			 "Failed to enable voltage reference\n");
> +		return -EIO;

Return the original error code here as well.

> +	}
> +
> +	ret = regulator_get_voltage(st->vref_reg);
> +	if (ret < 0) {
> +		dev_err(&st->spi->dev,
> +			 "Failed to get voltage reference value\n");
> +		goto disable_regulator_vref;
> +	}
> +
> +	if (ret < 2000000 || ret > 3000000) {
> +		dev_warn(&st->spi->dev,
> +			 "Invalid external voltage ref. value %d uV\n", ret);
> +		goto disable_regulator_vref;
> +	}
> +
> +	st->vref = ret / 1000;
> +	st->use_intref = false;
> +
> +	return 0;
> +
> +disable_regulator_vref:
> +	regulator_disable(st->vref_reg);
> +	st->vref_reg = NULL;
> +	return -EIO;

and here.

> +}
> +
> +static int ad5761_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *iio_dev;
> +	struct ad5761_state *st;
> +	int ret;
> +	const struct ad5761_chip_info *chip_info =
> +		&ad5761_chip_infos[spi_get_device_id(spi)->driver_data];
> +	enum ad5761_voltage_range voltage_range = MODE_0V_5V;
> +	struct ad5761_platform_data *pdata = dev_get_platdata(&spi->dev);
> +
> +	iio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(iio_dev);
> +
> +	st->spi = spi;
> +	spi_set_drvdata(spi, iio_dev);
> +
> +	ret = ad5761_get_vref(st, chip_info);
> +	if (ret)
> +		return ret;
> +
> +	if (pdata)
> +		voltage_range = pdata->voltage_range & 0x7;

What is encoded in the upper bits of pdata->voltage_range?

> +
> +	ret = ad5761_spi_set_range(st, voltage_range);
> +	if (ret)
> +		goto disable_regulator_err;
> +
> +	iio_dev->dev.parent = &spi->dev;
> +	iio_dev->info = &ad5761_info;
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +	iio_dev->channels = &chip_info->channel;
> +	iio_dev->num_channels = 1;
> +	iio_dev->name = spi_get_device_id(st->spi)->name;
> +	ret = iio_device_register(iio_dev);
> +	if (ret)
> +		goto disable_regulator_err;
> +
> +	return ret;
> +
> +disable_regulator_err:
> +	if (!IS_ERR_OR_NULL(st->vref_reg))
> +		regulator_disable(st->vref_reg);
> +
> +	return ret;
> +}
> +
> +static int ad5761_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *iio_dev = spi_get_drvdata(spi);
> +	struct ad5761_state *st = iio_priv(iio_dev);
> +
> +	if (!IS_ERR_OR_NULL(st->vref_reg))
> +		regulator_disable(st->vref_reg);
> +	iio_device_unregister(iio_dev);

First unregister, then regulator disable.

> +
> +	return 0;
> +}
[...]
> +static struct spi_driver ad5761_driver = {
> +	.driver = {
> +		   .name = "ad5761",
> +		   .owner = THIS_MODULE,

This is no longer necessary. spi_register_driver() takes care of
initializing the owner field.

> +		   },
> +	.probe = ad5761_probe,
> +	.remove = ad5761_remove,
> +	.id_table = ad5761_id,
> +};
> +module_spi_driver(ad5761_driver);
[...]

