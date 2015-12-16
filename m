Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52738 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934413AbbLPRqM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 Dec 2015 12:46:12 -0500
Subject: Re: [PATCH v3 1/2] iio: ina2xx: add support for TI INA2xx Power
 Monitors
To: Marc Titinger <mtitinger@baylibre.com>, <jic23@kernel.org>,
	<knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
	<linux@roeck-us.net>, <jdelvare@suse.com>
References: <1449479375-4061-1-git-send-email-mtitinger@baylibre.com>
 <1449479375-4061-2-git-send-email-mtitinger@baylibre.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lm-sensors@lm-sensors.org>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <5671A329.1040306@ti.com>
Date: Wed, 16 Dec 2015 11:45:13 -0600
MIME-Version: 1.0
In-Reply-To: <1449479375-4061-2-git-send-email-mtitinger@baylibre.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/07/2015 03:09 AM, Marc Titinger wrote:
> +#define INA2XX_CHAN(_type, _index, _address) { \
> +	.type = (_type), \
> +	.address = (_address), \
> +	.indexed = 1, \
> +	.channel = (_index), \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> +				   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> +	.scan_index = (_index), \
> +	.scan_type = { \
> +		.sign = 'u', \
> +		.realbits = 16, \
> +		.storagebits = 16, \
> +		.endianness = IIO_BE, \

^^^^ See below.

> +	} \
> +}
> +
> +/*
> + * Sampling Freq is a consequence of the integration times of
> + * the Voltage channels.
> + */
> +#define INA2XX_CHAN_VOLTAGE(_index, _address) { \
> +	.type = IIO_VOLTAGE, \
> +	.address = (_address), \
> +	.indexed = 1, \
> +	.channel = (_index), \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +			      BIT(IIO_CHAN_INFO_INT_TIME), \
> +	.scan_index = (_index), \
> +	.scan_type = { \
> +		.sign = 'u', \
> +		.realbits = 16, \
> +		.storagebits = 16, \
> +		.endianness = IIO_BE, \
> +	} \
> +}
> +
> +static const struct iio_chan_spec ina2xx_channels[] = {
> +	INA2XX_CHAN_VOLTAGE(0, INA2XX_SHUNT_VOLTAGE),
> +	INA2XX_CHAN_VOLTAGE(1, INA2XX_BUS_VOLTAGE),
> +	INA2XX_CHAN(IIO_CURRENT, 2, INA2XX_CURRENT),
> +	INA2XX_CHAN(IIO_POWER, 3, INA2XX_POWER),
> +	IIO_CHAN_SOFT_TIMESTAMP(4),
> +};
> +
> +static int ina2xx_work_buffer(struct iio_dev *indio_dev)
> +{
> +	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
> +	unsigned short data[8];
> +	int bit, ret, i = 0;
> +	unsigned long buffer_us, elapsed_us;
> +	s64 time_a, time_b;
> +	unsigned int alert;
> +
> +	time_a = iio_get_time_ns();
> +
> +	/*
> +	 * Because the timer thread and the chip conversion clock
> +	 * are asynchronous, the period difference will eventually
> +	 * result in reading V[k-1] again, or skip V[k] at time Tk.
> +	 * In order to resync the timer with the conversion process
> +	 * we check the ConVersionReadyFlag.
> +	 * On hardware that supports using the ALERT pin to toggle a
> +	 * GPIO a triggered buffer could be used instead.
> +	 * For now, we pay for that extra read of the ALERT register
> +	 */
> +	do {
> +		ret = regmap_read(chip->regmap, INA226_ALERT_MASK,
> +				  &alert);
> +		if (ret < 0)
> +			return ret;
> +
> +		alert &= INA266_CVRF;
> +		trace_printk("Conversion ready: %d\n", !!alert);
> +
> +	} while (!alert);
> +
> +	/*
> +	 * Single register reads: bulk_read will not work with ina226
> +	 * as there is no auto-increment of the address register for
> +	 * data length longer than 16bits.
> +	 */
> +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		unsigned int val;
> +
> +		ret = regmap_read(chip->regmap,
> +				  INA2XX_SHUNT_VOLTAGE + bit, &val);
> +		if (ret < 0)
> +			return ret;
> +
> +		data[i++] = val;

The read above seems to fill the buffer in CPU order, but above
IIO_BE is specified, this should probably be IIO_CPU to avoid
confusion for programs that check for IIO buffer endianness.

I'll push this in a fixup patch later. Just wanted to give a
heads up if you run into problems with some program.
