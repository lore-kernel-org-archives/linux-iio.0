Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A96348C7B;
	Wed, 20 May 2026 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293101; cv=none; b=S676rAivlJ1wBigT7eyoqBkzHp+jP4HG/Wihrb1eAfU+05e0bGJ2R2KIpIIpu0xuwRRAiR5vjy6F/6QHU+/ZfF4bvJesGuCpkZdNJVysF2XqV8YyPuQk2emt4Hxniyn9ipFepz99QiCccr0xIptAcUJfu26IukkePNMtBMfciEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293101; c=relaxed/simple;
	bh=FQ2VHJp9HxZASVDoe7GsKO/X1YHNlaV8xlEYtJ1YJvM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0g9bXYsZgtexCAi3CSYSRg04JtZlX8mhdd2OQz+KjmHyFmvdRc/il5cW/eC8wiViOLJ14VWvfS/ioxCws9+ADzbyXFG7NPGJ7PJCJEF4X4FqeoGc7aMMacNnGvCte2qnkMtJqEB1WqwioDvkgoyLtS1e0vXBIGRKG6v2daw5Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilCe9+6J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilCe9+6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72B51F00894;
	Wed, 20 May 2026 16:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779293096;
	bh=dHDWDLJuOopuHJEjRyQG0Nr7eCjc1k4j5jy1mR1hzD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ilCe9+6J8Gc11pkLOZrDF4QyxW9/2XiPZvQtqss07/djRpkG8w/1nrRC7lGbzRtTH
	 hC+jv9qlkzmuCWpoqpgWBxmBvq14D6I9Czw2sfJcLyBqx0WzrJALrQkXZJP9FZ4MnV
	 TRIPKQg3GT/GLE9jdqW/bWZhVWmvFaV+Soa9PzrGH5+8EK/XXV45PJsSrm/JnrdGtw
	 FjiAFI7+d73LSAh1vZpfl+SpZ/Kx04ybivqFQQYLpUkF77DHGbIubdqpJFqyIgaC5G
	 QfgtFqoOJsErkWX+irJaFx5F3+Vjl5SCPnlr8Sw95J7935rtSXp5vNZGscUTNCjjBM
	 upFYR6NIJnJjg==
Date: Wed, 20 May 2026 17:04:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 2/4] iio: adc: Add support for LTC2378-20 and similar
 ADCs
Message-ID: <20260520170446.2cf31639@jic23-huawei>
In-Reply-To: <301e4fc7544a485b56e7a8b91c3b66f5ac98e842.1779117444.git.marcelo.schmitt1@gmail.com>
References: <cover.1779117444.git.marcelo.schmitt1@gmail.com>
	<301e4fc7544a485b56e7a8b91c3b66f5ac98e842.1779117444.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 12:21:33 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> From: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> Initial support for LTC2378-20 and similar analog-to-digital converters.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> The data union for the sample data and the filling of IIO channel scan_type
> struct could probably have been avoided and postponed. Though, that would
> probably imply larger git diffs in the buffer patches so I added those earlier
> to minimize diff size in the buffer patches.

Could we set the SPI word size larger? That would then make normal SPI
controllers provide the data in CPU Endian form as well.

I've no idea what percentage of SPI controllers will do both 16 and 32 bit
words though but if it simplifies the driver and you don't have a customer
right now with a rubbish SPI controller, I'd prefer this route.

> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 707dd708912f..1814fb78dde3 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -81,6 +81,7 @@ obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>  obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
>  obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
>  obj-$(CONFIG_LTC2309) += ltc2309.o
> +obj-$(CONFIG_LTC2378) += ltc2378.o
>  obj-$(CONFIG_LTC2471) += ltc2471.o
>  obj-$(CONFIG_LTC2485) += ltc2485.o
>  obj-$(CONFIG_LTC2496) += ltc2496.o ltc2497-core.o
> diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> new file mode 100644
> index 000000000000..7916500c470c
> --- /dev/null
> +++ b/drivers/iio/adc/ltc2378.c
> @@ -0,0 +1,352 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Analog Devices LTC2378 ADC series driver
> + *
> + * Copyright (C) 2026 Analog Devices Inc.
> + * Author: Ioan-Daniel Pop <pop.ioan-daniel@analog.com>
> + * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>

That's a very short list.

dev_printk.h seems to be missing - please check in general against
IWYU principles. We shouldn't really be relying on anything included
in ltc2378.h either.

> +
> +#include "ltc2378.h"
> +
> +enum ltc2378_supported_device_ids {
...

> +	ID_LTC2380_16,
Whilst we used to do this enum thing and array we are moving
away from it - mostly because it makes it far too easy for people
to use it for the wrong things.  Names structures are neater and
tend to give shorter line lengths.
> +};
> +
> +static const struct ltc2378_chip_info ltc2378_chip_info[] = {
> +	[ID_LTC2338_18] = {
> +		.name = "ltc2338-18",
> +		.resolution = 18,
> +		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
> +	},
That is break this up into
static const struct ltc2378_chip_info ltc2338_18_chip_info = {
};
etc

> +	[ID_LTC2364_16] = {
> +		.name = "ltc2364-16",
> +		.resolution = 16,
> +		.out_format = IIO_SCAN_FORMAT_UNSIGNED_INT,

> +
> +static int ltc2378_convert_and_acquire(struct ltc2378_state *st)
> +{
> +	int ret;
> +
> +	/* Cause a rising edge of CNV to initiate a new ADC conversion */
> +	gpiod_set_value_cansleep(st->cnv_gpio, 1);

There is a note from sashiko on whether this needs a short delay.

> +	ret = spi_sync_transfer(st->spi, &st->xfer, 1);
> +	gpiod_set_value_cansleep(st->cnv_gpio, 0);
> +
> +	return ret;
> +}
> +
> +static int ltc2378_channel_single_read(const struct iio_chan_spec *chan,
> +				       struct ltc2378_state *st, int *val)
> +{
> +	const struct iio_scan_type *scan_type = &chan->scan_type;
> +	u32 sample;
> +	int ret;
> +
> +	ret = ltc2378_convert_and_acquire(st);
> +	if (ret)
> +		return ret;
> +
> +	if (scan_type->endianness == IIO_BE) {

This smells overly flexible given for now at least we only have IIO_BE.
The word size suggestion might resolve this moer simplly.


> +		if (scan_type->realbits > 16)
> +			sample = be32_to_cpu(st->scan.data.sample_buf32_be);
> +		else
> +			sample = be16_to_cpu(st->scan.data.sample_buf16_be);
> +	} else {
> +		if (scan_type->realbits > 16)
> +			sample = st->scan.data.sample_buf32;
> +		else
> +			sample = st->scan.data.sample_buf16;
> +	}
> +
> +	sample >>= scan_type->shift;
> +
> +	if (scan_type->format == IIO_SCAN_FORMAT_SIGNED_INT)
> +		*val = sign_extend32(sample, scan_type->realbits - 1);
> +	else
> +		*val = sample;
> +
> +	return 0;
> +}
> +
> +static int ltc2378_read_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan,
> +			int *val, int *val2, long info)
> +{
> +	struct ltc2378_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:

Scope missing.  The next bit declares a local variable under the hood.

> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		ret = ltc2378_channel_single_read(chan, st, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->ref_uV / MILLI;
> +		/*
> +		 * For all LTC2378-like devices, the amount of bits that express
> +		 * voltage magnitude depend on the output code format:
> +		 * - straight binary: All precision/resolution bits are used.
> +		 * - 2's complement: One of the precision bits is used for sign.
> +		 */
> +		if (st->info->out_format == IIO_SCAN_FORMAT_SIGNED_INT)
> +			*val2 = st->info->resolution - 1;
> +		else
> +			*val2 = st->info->resolution;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ltc2378_iio_info = {
> +	.read_raw = &ltc2378_read_raw,
> +};
> +
> +static int ltc2378_probe(struct spi_device *spi)
> +{
> +	struct iio_chan_spec *ltc2378_chan;
> +	struct device *dev = &spi->dev;
> +	unsigned int num_iio_chans = 1;
> +	struct iio_dev *indio_dev;
> +	struct ltc2378_state *st;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	st->ref_uV = devm_regulator_get_enable_read_voltage(dev, "ref");
I missed this but sashiko is better than me :)
This eats return value which might be EPROBE_DEFER.

> +	if (st->ref_uV < 0)
> +		return dev_err_probe(dev, -ENODEV, "failed to read ref regulator\n");
> +
> +	st->info = spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -EINVAL;
> +
> +	indio_dev->name = st->info->name;
> +	indio_dev->info = &ltc2378_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	st->cnv_gpio = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
> +	if (st->cnv_gpio && IS_ERR(st->cnv_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
> +				     "failed to get CNV GPIO");
> +
> +	ltc2378_chan = devm_kzalloc(&spi->dev, sizeof(struct iio_chan_spec), GFP_KERNEL);

Embed it in the iio_priv(). Saves us one allocation and that has effectively the
same lifetime as this.

> +	if (!ltc2378_chan)
> +		return -ENOMEM;
> +
> +	*ltc2378_chan = (struct iio_chan_spec) {
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_type = {
> +			.format = st->info->out_format,
> +			.realbits = st->info->resolution,
> +			.storagebits = st->info->resolution > 16 ? 32 : 16,
> +			.shift = st->info->resolution > 16 ? 8 : 0,
There is a comment from Sashiko on this. It's definitely suspicious given
the different resolutions + sign extend.

> +			.endianness = IIO_BE,
> +		},
> +	};

There are a reasonable number of options I suppose though my gut instinct
would still be to have them all as data and point to that from the structure
in st->info.   Little bit of bloat but puts avoids a level of indirection
in how this is being created.  Maybe this is worth it given the multiple
modes. Not sure yet.




> +	st->xfer.rx_buf = &st->scan.data;
> +	st->xfer.len = BITS_TO_BYTES(ltc2378_chan->scan_type.storagebits);
> +
> +	indio_dev->channels = ltc2378_chan;
> +	indio_dev->num_channels = num_iio_chans;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct of_device_id ltc2378_of_match[] = {
> +	{ .compatible = "adi,ltc2338-18", .data = &ltc2378_chip_info[ID_LTC2338_18] },
> +	{ .compatible = "adi,ltc2364-16", .data = &ltc2378_chip_info[ID_LTC2364_16] },
> +	{ .compatible = "adi,ltc2364-18", .data = &ltc2378_chip_info[ID_LTC2364_18] },
> +	{ .compatible = "adi,ltc2367-16", .data = &ltc2378_chip_info[ID_LTC2367_16] },
> +	{ .compatible = "adi,ltc2367-18", .data = &ltc2378_chip_info[ID_LTC2367_18] },
> +	{ .compatible = "adi,ltc2368-16", .data = &ltc2378_chip_info[ID_LTC2368_16] },
> +	{ .compatible = "adi,ltc2368-18", .data = &ltc2378_chip_info[ID_LTC2368_18] },
> +	{ .compatible = "adi,ltc2369-18", .data = &ltc2378_chip_info[ID_LTC2369_18] },
> +	{ .compatible = "adi,ltc2370-16", .data = &ltc2378_chip_info[ID_LTC2370_16] },
> +	{ .compatible = "adi,ltc2376-16", .data = &ltc2378_chip_info[ID_LTC2376_16] },
> +	{ .compatible = "adi,ltc2376-18", .data = &ltc2378_chip_info[ID_LTC2376_18] },
> +	{ .compatible = "adi,ltc2376-20", .data = &ltc2378_chip_info[ID_LTC2376_20] },
> +	{ .compatible = "adi,ltc2377-16", .data = &ltc2378_chip_info[ID_LTC2377_16] },
> +	{ .compatible = "adi,ltc2377-18", .data = &ltc2378_chip_info[ID_LTC2377_18] },
> +	{ .compatible = "adi,ltc2377-20", .data = &ltc2378_chip_info[ID_LTC2377_20] },
> +	{ .compatible = "adi,ltc2378-16", .data = &ltc2378_chip_info[ID_LTC2378_16] },
> +	{ .compatible = "adi,ltc2378-18", .data = &ltc2378_chip_info[ID_LTC2378_18] },
> +	{ .compatible = "adi,ltc2378-20", .data = &ltc2378_chip_info[ID_LTC2378_20] },
> +	{ .compatible = "adi,ltc2379-18", .data = &ltc2378_chip_info[ID_LTC2379_18] },
> +	{ .compatible = "adi,ltc2380-16", .data = &ltc2378_chip_info[ID_LTC2380_16] },

As above, split the array into separate named structure instances.

> +	{ },

No trailing comma on a 'terminator' like this.

> +};
> +MODULE_DEVICE_TABLE(of, ltc2378_of_match);
> +
> +static const struct spi_device_id ltc2378_spi_id[] = {
> +	{ "ltc2338-18", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2338_18] },
> +	{ "ltc2364-16", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2364_16] },
> +	{ "ltc2364-18", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2364_18] },
> +	{ "ltc2367-16", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2367_16] },
> +	{ "ltc2367-18", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2367_18] },
> +	{ "ltc2368-16", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2368_16] },
> +	{ "ltc2368-18", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2368_18] },
> +	{ "ltc2369-18", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2369_18] },
> +	{ "ltc2370-16", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2370_16] },
> +	{ "ltc2376-16", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2376_16] },
> +	{ "ltc2376-18", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2376_18] },
> +	{ "ltc2376-20", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2376_20] },
> +	{ "ltc2377-16", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2377_16] },
> +	{ "ltc2377-18", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2377_18] },
> +	{ "ltc2377-20", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2377_20] },
> +	{ "ltc2378-16", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2378_16] },
> +	{ "ltc2378-18", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2378_18] },
> +	{ "ltc2378-20", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2378_20] },
> +	{ "ltc2379-18", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2379_18] },
> +	{ "ltc2380-16", (kernel_ulong_t)&ltc2378_chip_info[ID_LTC2380_16] },
> +	{ },

No trailing comma, plus for new code lets use named intializers to make the
work Uwe is doing easier in the long run.

> +};
> +MODULE_DEVICE_TABLE(spi, ltc2378_spi_id);

> diff --git a/drivers/iio/adc/ltc2378.h b/drivers/iio/adc/ltc2378.h
> new file mode 100644
> index 000000000000..515f7e8a4f2e
> --- /dev/null
> +++ b/drivers/iio/adc/ltc2378.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Analog Devices LTC2378 and similar ADCs common definitions and properties
> + * Copyright (C) 2026 Analog Devices, Inc.
> + * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> + */
> +
> +#ifndef __DRIVERS_IIO_ADC_LTC2378_H__
> +#define __DRIVERS_IIO_ADC_LTC2378_H__
> +
> +#include <linux/iio/iio.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#define LTC2378_TDSDOBUSYL_NS		5
> +#define LTC2378_TBUSYLH_NS		13
> +#define LTC2378_TCNV_HIGH_NS		20
> +
> +struct ltc2378_chip_info {
> +	const char *name;
> +	int resolution;
> +	const char out_format;
This feels like it should have some documentation.
I'm going to guess it is really bipolar / unipolar?
If so I'd have a bool bipolar flag.

Using a format char is a bit too flexible for my liking.

> +};
> +
> +struct ltc2378_state {
> +	const struct ltc2378_chip_info *info;
> +	struct gpio_desc *cnv_gpio;
> +	struct spi_device *spi;
> +	struct spi_transfer xfer;
> +	int ref_uV;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	struct {
> +		union {
> +			__be16 sample_buf16_be;
> +			__be32 sample_buf32_be;
> +			u16 sample_buf16;
> +			u32 sample_buf32;
> +		} data;
> +		aligned_s64 timestamp;
> +	} scan __aligned(IIO_DMA_MINALIGN);
> +};
> +
> +#endif /* __DRIVERS_IIO_ADC_LTC2378_H__ */

