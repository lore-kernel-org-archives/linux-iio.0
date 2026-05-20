Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B45373BE0;
	Wed, 20 May 2026 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294472; cv=none; b=sOh7zfboKFAGZDceqECjBoyFN1JuwYjq8hU7EGaktc1dArTI+D9CWWgJdN8AK9WQnLtl78dMtHBr32jWv9GMlG63HZ4Krvaok7ipZtCToStIw7rchlIbgTmUcXQd289WtuMNrcaMLl3tzhUXa2TAxW3XciMN99g2maihT2C3xuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294472; c=relaxed/simple;
	bh=3k5NQVBscbPO0hzd69GrqrYqIag+H1bPAk5UbnKR1TU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8K+6EaZ27HuO5wujLxfWDgT6Fqnga86iteXalYRiwdm9Xu+k6WZYOgJjkrlhBTEIVuG3wiIlr9ff1l/vueh/RG/hb80N56wRQbPKsGUw2HBXuv2bfjDHCE9Mmk1lB4AjQXIMrI3wlPZv96o33Zu4RF9b3E9TTMVUm3N+Swst9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWFsUXNT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWFsUXNT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C831F000E9;
	Wed, 20 May 2026 16:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779294470;
	bh=1onfJDQ+AkM2HFiEk4l2GMIwF4xIqGXA2MKZagHkvBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fWFsUXNTLA0353/mvRryoFHoJYjjYuoE6M2dmI4mjP52JPL2GTAP/tQdct+nXUQnD
	 f/Nb4/PRi+K7wrDet4rsH73W/bLLCGj4ikl+ESIeehD8wrYoopqG30vsPk/UgRiC5b
	 ghAwrN4lFx3DmDmllFV4/NPHavg00WIw3TDH/V0VvWk1GhWiydEcnz+5wjMI6ZSoHf
	 TeH6k+EtZuI57vELI77m+hRAWIgo1Bcd6BLWC9mm0m03pSnTruWxAOHh1IbdxM3ZI/
	 xsjZKcDqJ44RBZzaMOH3p5YIyY7Y4zecJk1lEMXZ4mP67qWBdL2TkM++GXHnBRMUGd
	 RHqmDwJPN30QQ==
Date: Wed, 20 May 2026 17:27:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 3/4] iio: adc: ltc2378: Enable high-speed data
 capture
Message-ID: <20260520172740.783c8866@jic23-huawei>
In-Reply-To: <580ce8e03cdbda8ec20fed2e26f2226872ffcef3.1779117444.git.marcelo.schmitt1@gmail.com>
References: <cover.1779117444.git.marcelo.schmitt1@gmail.com>
	<580ce8e03cdbda8ec20fed2e26f2226872ffcef3.1779117444.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 12:22:03 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> From: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> Make use of SPI transfer offloading to speed up data capture, enabling data
> acquisition at faster sample rates (up to 2 MSPS).
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Various comments inline. Some from me, some from sashiko (with my comments on top)

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig                  |  12 +
>  drivers/iio/adc/Makefile                 |   1 +
>  drivers/iio/adc/ltc2378-offload-buffer.c | 297 +++++++++++++++++++++++
>  drivers/iio/adc/ltc2378.c                |  62 +++++
>  drivers/iio/adc/ltc2378.h                |  34 +++
>  5 files changed, 406 insertions(+)
>  create mode 100644 drivers/iio/adc/ltc2378-offload-buffer.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 70fec8e3e891..b5368ee783f7 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -944,6 +944,7 @@ config LTC2378
>  	depends on SPI
>  	depends on GPIOLIB || PWM
>  	select IIO_BUFFER
> +	imply LTC2378_OFFLOAD_BUFFER
>  	help
>  	  Say yes here to build support for Analog Devices LTC2378-20 and
>  	  similar analog to digital converters.
> @@ -951,6 +952,17 @@ config LTC2378
>  	  This driver can also be built as a module. If so, the module will
>  	  be called ltc2378.
>  
> +config LTC2378_OFFLOAD_BUFFER
> +	bool "Offloaded data capture with LTC2378"
> +	depends on SPI && LTC2378
> +	depends on SPI_OFFLOAD=y
> +	depends on PWM=y
> +	depends on SPI_OFFLOAD_TRIGGER_PWM=y
> +	depends on IIO_BUFFER_DMA=y
> +	depends on IIO_BUFFER_DMAENGINE=y

why do all these have to be built in?  In general I think we need to jusitfy
why this driver needs to work on systems with out this stuff being built.
I.e. why do we need the separate optional file at all?


> +	help
> +	  Say yes here to build support for high speed data capture with LTC2378
> +
>  config LTC2471
>  	tristate "Linear Technology LTC2471 and LTC2473 ADC driver"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 1814fb78dde3..2fa5dce0ceea 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -82,6 +82,7 @@ obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
>  obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
>  obj-$(CONFIG_LTC2309) += ltc2309.o
>  obj-$(CONFIG_LTC2378) += ltc2378.o
> +obj-$(CONFIG_LTC2378_OFFLOAD_BUFFER) += ltc2378-offload-buffer.o

Hmm. This is odd. The driver can be modular but not this and it's build seperately
rather than as part of the module. I think these bit needs a redesign.
We definitely want this extra support to be part of the module.  See how something
like the ADIS IMU library in iio/imu/Makefile is done.


>  obj-$(CONFIG_LTC2471) += ltc2471.o
>  obj-$(CONFIG_LTC2485) += ltc2485.o
>  obj-$(CONFIG_LTC2496) += ltc2496.o ltc2497-core.o
> diff --git a/drivers/iio/adc/ltc2378-offload-buffer.c b/drivers/iio/adc/ltc2378-offload-buffer.c
> new file mode 100644
> index 000000000000..ed09f9a55f93
> --- /dev/null
> +++ b/drivers/iio/adc/ltc2378-offload-buffer.c
> @@ -0,0 +1,297 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Analog Devices, Inc.
> + * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/buffer-dmaengine.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/types.h>
We are somewhat standarizing on having the iio headers in their own
bock after the more generic other ones you have here.

> +#include <linux/kstrtox.h>
> +#include <linux/limits.h>
> +#include <linux/linkage.h>
> +#include <linux/math.h>
> +#include <linux/math64.h>
> +#include <linux/minmax.h>
> +#include <linux/pwm.h>
> +#include <linux/spi/offload/consumer.h>
> +#include <linux/spi/offload/types.h>
> +#include <linux/time64.h>
> +
> +#include "ltc2378.h"
> +
> +/*
> + * SPI offload wiring schema
> + *
> + *     +-------------+         +-------------+
> + *     |         CNV |<-----+--| GPIO        |
> + *     |             |      +--| PWM0        |
> + *     |             |         |             |
> + *     |             |      +--| PWM1        |
> + *     |             |      |  +-------------+
> + *     |             |      +->| TRIGGER     |
> + *     |             |         |             |
> + *     |     ADC     |         |    SPI      |
> + *     |             |         | controller  |
> + *     |             |         |             |
> + *     |         SDI |<--------| SDO         |
> + *     |         SDO |-------->| SDI         |
> + *     |        SCLK |<--------| SCLK        |
> + *     +-------------+         +-------------+
> + *
> + */
> +static int ltc2378_update_conversion_rate(struct ltc2378_state *st, int freq_Hz)
> +{
> +	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
> +	unsigned int min_read_offset, offload_period_ns;
> +	struct pwm_waveform cnv_wf = { };
> +	u64 target = LTC2378_TCNV_HIGH_NS;
> +	u64 offload_offset_ns;
> +	int ret;
> +
> +	if (freq_Hz == 0)
> +		return -EINVAL;
> +
> +	if (freq_Hz < 1 || freq_Hz > st->info->max_sample_rate_hz)
> +		return -ERANGE;
> +
> +	/* Configure CNV PWM waveform */
> +	cnv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq_Hz);
> +
> +	/*
> +	 * Ensure CNV high time meets minimum requirement (20ns).
> +	 * The PWM hardware may round the duty cycle, so iterate
> +	 * until we get at least the minimum required high time.

wrap is a bit short. I'd go nearer the 80 char standard.

> +	 */
> +	do {
> +		cnv_wf.duty_length_ns = target;
> +		ret = pwm_round_waveform_might_sleep(st->cnv_trigger, &cnv_wf);
> +		if (ret)
> +			return ret;
> +		target += 10;  /* Increment by PWM duty cycle period */
> +	} while (cnv_wf.duty_length_ns < LTC2378_TCNV_HIGH_NS);
> +
> +	/*
> +	 * Configure SPI offload PWM trigger.
> +	 * The trigger should fire after tBUSYLH + tCONV + tDSDOBUSYL.
> +	 * Minimum time needed: TBUSYLH (13ns) + TCONV (part-specific) + TDSDOBUSYL (5ns)
> +	 *
> +	 * Use the same period as CNV PWM to avoid timing issues.
> +	 * Convert back from period to frequency for the SPI offload API.
> +	 */
> +	offload_period_ns = cnv_wf.period_length_ns;
> +	config->periodic.frequency_hz = DIV_ROUND_UP(HZ_PER_GHZ, offload_period_ns);
> +	min_read_offset = LTC2378_TBUSYLH_NS + st->info->tconv_ns + LTC2378_TDSDOBUSYL_NS;
> +	offload_offset_ns = min_read_offset;
> +	do {
> +		config->periodic.offset_ns = offload_offset_ns;
> +		ret = spi_offload_trigger_validate(st->offload_trigger, config);
> +		if (ret)
> +			return ret;
> +		offload_offset_ns += 10;
> +	} while (config->periodic.offset_ns < min_read_offset);
> +
> +	st->cnv_wf = cnv_wf;
> +	st->cnv_Hz = DIV_ROUND_CLOSEST_ULL(HZ_PER_GHZ, cnv_wf.period_length_ns);
> +
> +	return 0;
> +}

> +
> +static IIO_DEVICE_ATTR_RO(sampling_frequency_available, 0);
> +
> +static struct attribute *ltc2378_offload_attributes[] = {
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL,
If this was staying, no trailing comma.
> +};
> +
> +const struct attribute_group ltc2378_offload_attribute_group = {
These are standard properties - do them via the chan_spec and read_raw()
read_avail()

> +	.attrs = ltc2378_offload_attributes,
> +};
> +EXPORT_SYMBOL_NS_GPL(ltc2378_offload_attribute_group, "IIO_LTC2378");
> +
> +static int ltc2378_prepare_offload_message(struct device *dev,
> +					   struct ltc2378_state *st)
> +{
> +	st->offload_xfer.bits_per_word = st->info->resolution;
> +	/*
> +	 * Ideally, we would ask the offload provider what data word sizes are
> +	 * supported so we could use smaller words for less precise ADCs.
> +	 * Though, the currently available SPI offloading hardware only supports
> +	 * pushing 32-bit sized data elements to DMA memory. Because of that,
> +	 * we hardcode set 4 byte sized transfers.
> +	 */
> +	st->offload_xfer.len = 4;
> +	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;

There is a question form sashiko on whether the channel spec description for
smaller resolution parts is correct as you don't update storage bits and it
might be 16.

> +
> +	/* Initialize message with offload */
> +	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
> +	st->offload_msg.offload = st->offload;
> +
> +	return devm_spi_optimize_message(dev, st->spi, &st->offload_msg);
> +}

> +
> +int ltc2378_offload_buffer_setup(struct iio_dev *indio_dev, struct spi_device *spi)
> +{
> +	struct ltc2378_state *st = iio_priv(indio_dev);
> +	struct device *dev = &spi->dev;
> +	int ret;
> +
> +	st->offload = devm_spi_offload_get(dev, spi, &ltc2378_offload_config);
> +	ret = PTR_ERR_OR_ZERO(st->offload);
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to get offload\n");
> +

If it was -ENODEV, why does the rest make sense?  Add a comment if it does.


> +	ret = ltc2378_spi_offload_setup(indio_dev, st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to setup SPI offload\n");
> +
> +	ret = ltc2378_pwm_get(st);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Start with a slower sampling rate so there is some room for
> +	 * adjusting the sampling frequency without hitting the maximum
> +	 * conversion rate.
Not sure of that logic.  Can just adjust it down if we started with maximum.

It's a random choice so I wouldn't bother justifying it ;)

> +	 */
> +	ret = ltc2378_update_conversion_rate(st, st->info->max_sample_rate_hz >> 4);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to sampling frequency\n");
> +
> +	ret = ltc2378_prepare_offload_message(&spi->dev, st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to optimize SPI message\n");
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(ltc2378_offload_buffer_setup, "IIO_LTC2378");
> +
> +MODULE_IMPORT_NS("IIO_LTC2378");
> diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> index 7916500c470c..fdbe919d45d5 100644
> --- a/drivers/iio/adc/ltc2378.c
> +++ b/drivers/iio/adc/ltc2378.c

>  	[ID_LTC2378_16] = {
>  		.name = "ltc2378-16",
>  		.resolution = 16,
> +		.max_sample_rate_hz = HZ_PER_MHZ,
> +		.tconv_ns = 527,
>  		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
>  	},
>  	[ID_LTC2378_18] = {
>  		.name = "ltc2378-18",
>  		.resolution = 18,
> +		.max_sample_rate_hz = HZ_PER_MHZ,
>  		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
> +		.tconv_ns = 527,
Keep ordering the same.
>  	},
>  	[ID_LTC2378_20] = {
>  		.name = "ltc2378-20",
>  		.resolution = 20,
> +		.max_sample_rate_hz = HZ_PER_MHZ,
> +		.tconv_ns = 675,
>  		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
>  	},
>  	[ID_LTC2379_18] = {
>  		.name = "ltc2379-18",
>  		.resolution = 18,
> +		.max_sample_rate_hz = 1600 * HZ_PER_KHZ,
> +		.tconv_ns = 412,
>  		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
>  	},
>  	[ID_LTC2380_16] = {
>  		.name = "ltc2380-16",
>  		.resolution = 16,
> +		.max_sample_rate_hz = 2 * HZ_PER_MHZ,
> +		.tconv_ns = 322,
>  		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
>  	},
>  };
> @@ -226,6 +266,9 @@ static int ltc2378_read_raw(struct iio_dev *indio_dev,
>  }
>  
>  static const struct iio_info ltc2378_iio_info = {
> +#ifdef CONFIG_LTC2378_OFFLOAD_BUFFER

Can we stub that in the header? Might be a little fiddly.
Basic rule is no ifdefs in c files if we can avoid it
as they are a paint to read.

Proabbly wants an is_visible anyway in case we get this built
but not useable due to lack of spi offload hardware.

> +	.attrs = &ltc2378_offload_attribute_group,
> +#endif
>  	.read_raw = &ltc2378_read_raw,
>  };
>  
> @@ -236,6 +279,7 @@ static int ltc2378_probe(struct spi_device *spi)
>  	unsigned int num_iio_chans = 1;
>  	struct iio_dev *indio_dev;
>  	struct ltc2378_state *st;
> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
> @@ -280,6 +324,23 @@ static int ltc2378_probe(struct spi_device *spi)
>  	st->xfer.rx_buf = &st->scan.data;
>  	st->xfer.len = BITS_TO_BYTES(ltc2378_chan->scan_type.storagebits);
>  
> +	ret = ltc2378_offload_buffer_setup(indio_dev, spi);
> +	if (ret == -ENODEV) {
> +		/* SPI offloading is unavailable. Fall back to triggered buffer. */
> +		dev_notice(dev, "buffered data capture not supported\n");

Is that not obvious for other reasons?  Demote to dev_dbg() probably.

> +	} else if (ret) {
> +		return dev_err_probe(dev, ret, "error on SPI offload setup\n");
> +	} else {
> +		/*
> +		 * Currently, the available offload hardware + DMA configuration
> +		 * only supports pushing data to IIO buffers in CPU endianness.

If it's cpu endian that implies a larger word size.  Can we just encode that
in the request and not worry about it?

> +		 * That also requires we apply no shift to scan elements to
> +		 * correctly read ADC sample data.
> +		 */
> +		ltc2378_chan->scan_type.shift = 0;
> +		ltc2378_chan->scan_type.endianness = IIO_CPU;

Can we move the main init of scan_type down here and do it in the if  / else
so as to avoid setting it to the wrong thing then updating?

> +	}
> +
>  	indio_dev->channels = ltc2378_chan;
>  	indio_dev->num_channels = num_iio_chans;
>  
> @@ -350,3 +411,4 @@ MODULE_AUTHOR("Ioan-Daniel Pop <pop.ioan-daniel@analog.com>");
>  MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices LTC2378 ADC series driver");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_LTC2378");
> diff --git a/drivers/iio/adc/ltc2378.h b/drivers/iio/adc/ltc2378.h
> index 515f7e8a4f2e..17c329b18333 100644
> --- a/drivers/iio/adc/ltc2378.h
> +++ b/drivers/iio/adc/ltc2378.h
> @@ -9,7 +9,14 @@
>  #define __DRIVERS_IIO_ADC_LTC2378_H__
>  
>  #include <linux/iio/iio.h>
> +#ifdef CONFIG_LTC2378_OFFLOAD_BUFFER

Not keen on these ifdefs. What harm does including these do if
they functionality isn't in use?  I suspect nothing, in which
case drop the guarding.

> +#include <linux/pwm.h>
> +#endif
>  #include <linux/spi/spi.h>
> +#ifdef CONFIG_LTC2378_OFFLOAD_BUFFER
> +#include <linux/spi/offload/consumer.h>
> +#include <linux/spi/offload/types.h>
> +#endif
>  #include <linux/types.h>
>  #include <linux/units.h>
>  
> @@ -20,6 +27,8 @@
>  struct ltc2378_chip_info {
>  	const char *name;
>  	int resolution;
> +	unsigned int max_sample_rate_hz;
> +	unsigned int tconv_ns;
>  	const char out_format;
>  };
>  
> @@ -29,6 +38,16 @@ struct ltc2378_state {
>  	struct spi_device *spi;
>  	struct spi_transfer xfer;
>  	int ref_uV;
> +#ifdef CONFIG_LTC2378_OFFLOAD_BUFFER
> +	unsigned int cnv_Hz;
> +	struct pwm_waveform cnv_wf;
> +	struct spi_offload *offload;
> +	struct spi_offload_trigger *offload_trigger;
> +	struct spi_message offload_msg;
> +	struct spi_transfer offload_xfer;
> +	struct spi_offload_trigger_config offload_trigger_config;
> +	struct pwm_device *cnv_trigger;
> +#endif
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> @@ -45,4 +64,19 @@ struct ltc2378_state {
>  	} scan __aligned(IIO_DMA_MINALIGN);
>  };
>  
> +#ifdef CONFIG_LTC2378_OFFLOAD_BUFFER
> +extern const struct attribute_group ltc2378_offload_attribute_group;
> +#endif
> +
> +#ifdef CONFIG_LTC2378_OFFLOAD_BUFFER
> +int ltc2378_offload_buffer_setup(struct iio_dev *indio_dev, struct spi_device *spi);
> +#else
> +static inline int ltc2378_offload_buffer_setup(struct iio_dev *indio_dev,
> +					       struct spi_device *spi)
> +{
> +	might_sleep();

Seems pretty unlikely ;)  How useful is this marking in code that
isn't running?  I'd hope build tests will trigger on the the version
where this is built and sleeps.

> +	return -ENODEV;
> +}
> +#endif
> +
>  #endif /* __DRIVERS_IIO_ADC_LTC2378_H__ */

