Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54033 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S977276AbdDXUFf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 24 Apr 2017 16:05:35 -0400
Message-ID: <1493064330.24567.180.camel@linux.intel.com>
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>
Date: Mon, 24 Apr 2017 23:05:30 +0300
In-Reply-To: <6e0f0b52-27a1-0ce5-c217-3aa941babe63@siemens.com>
References: <6e0f0b52-27a1-0ce5-c217-3aa941babe63@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 2017-04-24 at 21:28 +0200, Jan Kiszka wrote:
> This is an upstream port of an IIO driver for the TI ADC108S102 and
> ADC128S102. The former can be found on the Intel Galileo Gen2 and the
> Siemens SIMATIC IOT2000. For those boards, ACPI-based enumeration is
> included.
> 
> Original author: Bogdan Pricop <bogdan.pricop@emutex.com>
> Ported from Intel Galileo Gen2 BSP to Intel Yocto kernel:
> Todor Minchev <todor@minchev.co.uk>.

> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/platform_data/adc1x8s102.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/delay.h>
> +#include <linux/acpi.h>
> +#include <linux/property.h>
> +#include <linux/gpio.h>
> +
> +#include <linux/spi/pxa2xx_spi.h>

Perhaps alphabetical order?

> +
> +/* 16-bit SPI command format:
> + *   [15:14] Ignored
> + *   [13:11] 3-bit channel address
> + *   [10:0]  Ignored
> + */
> +#define ADC1x8S102_CMD(ch)		(((ch) << (8)) << (3))

I guess ((u16)(ch) << 11) would be slightly better.

> +
> +/*
> + * 16-bit SPI response format:
> + *   [15:12] Zeros
> + *   [11:0]  12-bit ADC sample (for ADC108S102, [1:0] will always be
> 0).
> + */

> +#define ADC1x8S102_RES_DATA(res)	(res & ((1 <<
> ADC1x8S102_BITS) - 1))

GENMASK() and to align with above

((u16)(res) & GENMASK(11, 0))

> +	/* SPI message buffers:
> +	 *  tx_buf: |C0|C1|C2|C3|C4|C5|C6|C7|XX|
> +	 *  rx_buf: |XX|R0|R1|R2|R3|R4|R5|R6|R7|tt|tt|tt|tt|
> +	 *
> +	 *  tx_buf: 8 channel read commands, plus 1 dummy command
> +	 *  rx_buf: 1 dummy response, 8 channel responses, plus 64-
> bit timestamp
> +	 */
> +	__be16				rx_buf[13]
> ____cacheline_aligned;
> +	__be16				tx_buf[9];

Would it be better to have tx_buf with ____cache_aligned? (IIUC it's
already by fact of above, though...)

> +};

> tatic int adc1x8s102_update_scan_mode(struct iio_dev *indio_dev,
> +		unsigned long const *active_scan_mask)
> +{
> +	struct adc1x8s102_state *st;
> +	int i, j;
> +
> +	st = iio_priv(indio_dev);
> +

> +	/* Fill in the first x shorts of tx_buf with the number of
> channels
> +	 * enabled for sampling by the triggered buffer
> +	 */

/*
 * Is it okay style for
 * multi-line comments?
 */

> +	for (i = 0, j = 0; i < ADC1x8S102_MAX_CHANNELS; i++) {
> +		if (test_bit(i, active_scan_mask)) {

for_each_set_bit() 

> +			st->tx_buf[j] =
> cpu_to_be16(ADC1x8S102_CMD(i));
> +			j++;
> +		}
> +	}
> +	/* One dummy command added, to clock in the last response */
> +	st->tx_buf[j] = 0x00;

> +}
> +

> +static int adc1x8s102_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,

> +			   int *val,
> +			   int *val2,
> +			   long m)

One line?

> +{
> +	int ret;
> +	struct adc1x8s102_state *st;
> +
> +	st = iio_priv(indio_dev);
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&indio_dev->mlock);
> +		if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
> {
> +			ret = -EBUSY;

> +			dev_warn(&st->spi->dev,
> +			 "indio_dev->currentmode is
> INDIO_BUFFER_TRIGGERED\n");

Indentation?

> +		} else {
> +			ret = adc1x8s102_scan_direct(st, chan-
> >address);
> +		}
> +		mutex_unlock(&indio_dev->mlock);
> +
> +		if (ret < 0)
> +			return ret;
> +		*val = ADC1x8S102_RES_DATA(ret);
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			if (st->reg)
> +				*val = regulator_get_voltage(st->reg) 
> / 1000;
> +			else
> +				*val = st->ext_vin;
> +
> +			*val2 = chan->scan_type.realbits;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		default:
> +			dev_warn(&st->spi->dev,
> +				 "Invalid channel type %u for channel
> %d\n",
> +				 chan->type, chan->channel);
> +			return -EINVAL;
> +		}
> +	default:
> +		dev_warn(&st->spi->dev, "Invalid IIO_CHAN_INFO:
> %lu\n", m);
> +		return -EINVAL;
> +	}
> +}

> +#ifdef CONFIG_ACPI
> +typedef int (*acpi_setup_handler)(struct spi_device *,
> +				  const struct
> adc1x8s102_platform_data **);
> +
> +static const struct adc1x8s102_platform_data int3495_platform_data =
> {
> +	.ext_vin = 5000,	/* 5 V */
> +};
> +

> +/* Galileo Gen 2 SPI setup */
> +static int
> +adc1x8s102_setup_int3495(struct spi_device *spi,
> +			 const struct adc1x8s102_platform_data
> **pdata)
> +{

> +	struct pxa2xx_spi_chip *chip_data;

This one is too big to waste memory on one member.

> +
> +	chip_data = devm_kzalloc(&spi->dev, sizeof(*chip_data),
> GFP_KERNEL);
> +	if (!chip_data)
> +		return -ENOMEM;
> +
> +	chip_data->gpio_cs = ADC1x8S102_GALILEO2_CS;
> +	spi->controller_data = chip_data;
> +	dev_info(&spi->dev, "setting GPIO CS value to %d\n",
> +		 chip_data->gpio_cs);
> +	spi_setup(spi);
> +
> +	*pdata = &int3495_platform_data;
> +
> +	return 0;
> +}

This is weird approach.
Moreover, please do not use platform data at all.

> +
> +static const struct acpi_device_id adc1x8s102_acpi_ids[] = {
> +	{ "INT3495",  (kernel_ulong_t)&adc1x8s102_setup_int3495 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, adc1x8s102_acpi_ids);
> +#endif
> +
> +static int adc1x8s102_probe(struct spi_device *spi)
> +{
> +	const struct adc1x8s102_platform_data *pdata = spi-
> >dev.platform_data;
> +	struct adc1x8s102_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +

> +#ifdef CONFIG_ACPI

No.

> +	if (ACPI_COMPANION(&spi->dev)) {
> +		acpi_setup_handler setup_handler;
> +		const struct acpi_device_id *id;
> +
> +		id = acpi_match_device(adc1x8s102_acpi_ids, &spi-
> >dev);
> +		if (!id)
> +			return -ENODEV;
> +

> +		setup_handler = (acpi_setup_handler)id->driver_data;
> +		if (setup_handler) {
> +			ret = setup_handler(spi, &pdata);
> +			if (ret)
> +				return ret;
> +		}

No way.

> +	}
> +#endif
> +
> +	if (!pdata) {
> +		dev_err(&spi->dev, "Cannot get adc1x8s102 platform
> data\n");
> +		return -ENODEV;
> +	}
> +

> +error_cleanup_ring:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +error_disable_reg:
> +	regulator_disable(st->reg);

Does devm_() help to get rid of these?

> +
> +	return ret;
> +}

> +
> +static int adc1x8s102_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct adc1x8s102_state *st = iio_priv(indio_dev);
> +

> +	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
> +
> +	regulator_disable(st->reg);

Ditto.

> +
> +	return 0;
> +}
> +

> +++ b/include/linux/platform_data/adc1x8s102.h

It must be no such file at all!
Please, remove it completely.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
