Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35872 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbbKZJAm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 26 Nov 2015 04:00:42 -0500
Received: by wmww144 with SMTP id w144so12443494wmw.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2015 01:00:40 -0800 (PST)
Subject: Re: [PATCH 1/2] iio: ina2xx: add support for TI INA2xx Power Monitors
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1448450896-24387-1-git-send-email-mtitinger@baylibre.com>
 <1448450896-24387-2-git-send-email-mtitinger@baylibre.com>
 <alpine.DEB.2.02.1511251230170.11807@pmeerw.net>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Marc Titinger <mtitinger@baylibre.com>
Message-ID: <5656CA36.9000908@baylibre.com>
Date: Thu, 26 Nov 2015 10:00:38 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1511251230170.11807@pmeerw.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/11/2015 13:20, Peter Meerwald-Stadler wrote:
>
>> in SOFTWARE buffer mode, a kthread will capture the active scan_elements
>> into a kfifo, then compute the remaining time until the next capture tick
>> and do an active wait (udelay).
>
> minor comments below

Thanks Peter! All fixed in next iteration.

M.
...

>> +config INA2XX_IIO
>> +	tristate "Texas Instruments INA2xx Power Monitors IIO driver"
>> +	depends on I2C
>> +	select REGMAP_I2C
>> +	select IIO_BUFFER
>> +	help
>> +	  Say yes here to build support for TI INA2xx familly Power Monitors.
>
> family
>
>> +
>> +	  Note that this is not the existing hwmon interface for this device.
>
> this message not very clear

removed. This was fuel to discuss the RFC.
...

>> +
>> +/*
>> + * INA2XX registers definition
>> + */
>> +/* common register definitions */
>
> comment style; do we need both?

removed one.

>> +
>> +/*Integration Time for VShunt */
>
> time
>

ok


>> +	int itb; /* Bus voltage integration time uS */
>> +	int its; /* Shunt voltage integration tim uS */
>
> time
>

ok

ge_shift)
>> +			* chip->config->bus_voltage_lsb;
>> +		*val = *uval/1000000;
>
> whitespace around / please

ok



>> +
>> +static unsigned int ina226_set_average(struct ina2xx_chip_info *chip,
>
> retval should have type int

indeed!


>> +static const int ina226_conv_time_tab[] = { 140, 204, 332, 588, 1100,
>> +					    2116, 4156, 8244};
>
> maybe whitespace before }

ok

>> +}
>> +
>> +static unsigned int ina226_set_its(struct ina2xx_chip_info *chip,
>
> retval should have type int

ok


>> +	return 0;
>> +}
>> +
>
> drop dup newline
>

ok


>> +
>> +/*Sampling Freq is a consequence of the integration times of the V channels.*/
>
> whitespace after /* and before */ please
>

ok

>> +#define INA2XX_CHAN_VOLTAGE(_index, _address) { \
>> +	.type = IIO_VOLTAGE, \
>> +	.address = _address, \
>> +	.indexed = 1, \
>> +	.channel = (_index), \
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
>> +			      BIT(IIO_CHAN_INFO_INT_TIME), \
>> +	.scan_index = (_index), \
>> +	.scan_type = { \
>> +		.sign = 'u', \
>> +		.realbits = 16, \
>> +		.storagebits = 16, \
>> +	.endianness = IIO_BE, \
>> +	} \
>> +}
>> +
>
> drop dup newline
>

ok


>> +}
>> +
>> +/* frequencies matching the cummulated integration times for vshunt and vbus */
>
> cumulated

wrong comment anyway, fixed.

>> +	 * Set current LSB to 1mA, shunt is in uOhms
>> +	 * (equation 13 in datasheet). We hardcode a Current_LSB
>> +	 * of 1.0 x10-6. The only remaining parameter is RShunt
>
> full stop

ok

>> +	mutex_destroy(&chip->state_lock);
>
> needed?

removed.

>> +
>> +	iio_device_unregister(indio_dev);
>
> not needed since devm_iio_device_register() is used

ok


