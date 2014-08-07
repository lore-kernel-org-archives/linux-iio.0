Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36270 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647AbaHGKI0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Aug 2014 06:08:26 -0400
Message-ID: <53E35018.1000900@kernel.org>
Date: Thu, 07 Aug 2014 11:08:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: balbi@ti.com, Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [RFC/PATCH] iio: light: add support for TI's opt3001 ligth sensor
References: <1407341409-30284-1-git-send-email-balbi@ti.com> <alpine.DEB.2.01.1408061815140.29646@pmeerw.net> <20140806214222.GB3556@saruman.home>
In-Reply-To: <20140806214222.GB3556@saruman.home>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/08/14 22:42, Felipe Balbi wrote:
> On Wed, Aug 06, 2014 at 11:11:52PM +0200, Peter Meerwald wrote:
>> Hello Felipe,
>> 
>> in subject: light sensor
>> 
>> please see my minor comments below
>> 
>> p.
>> 
>>> TI's opt3001 light sensor is a simple and yet powerful little device. The device provides 99% IR rejection, 
>>> Automatic full-scale, very low power consumption and measurements from 0.01 to 83k lux.
>>> 
>>> This patch adds support for that device using the IIO framework.
>>> 
>>> Signed-off-by: Felipe Balbi <balbi@ti.com> ---
>>> 
>>> Jonathan, I have a few doubts on how can I test buffered mode properly. I can see my IRQs triggering now
>>> problem, but where is the data pushed ? Can it be read from sysfs or /dev somehwere ?
>> 
>> there should be /dev/iio:deviceX
>> 
>>> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig index bf05ca5..e4582d7 100644 ---
>>> a/drivers/iio/light/Kconfig +++ b/drivers/iio/light/Kconfig @@ -128,6 +128,18 @@ config LTR501 This driver can
>>> also be built as a module.  If so, the module will be called ltr501.
>>> 
>>> +config OPT3001 +	tristate "Texas Instruments OPT3001 Light Sensor" +	depends on I2C +	select IIO_BUFFER +
>>> select IIO_TRIGGERED_BUFFER +	help +	  If you say Y or M here, you get support for Texas Instruments +
>>> OPT3001 Ambient Light Sensor. + +	  If built as a dynamically linked module, it will be called +	  opt3001. + 
>>> config TCS3414 tristate "TAOS TCS3414 digital color sensor" depends on I2C diff --git
>>> a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile index 8b8c09f..898ef13 100644 ---
>>> a/drivers/iio/light/Makefile +++ b/drivers/iio/light/Makefile @@ -13,6 +13,7 @@ obj-$(CONFIG_HID_SENSOR_PROX)
>>> += hid-sensor-prox.o obj-$(CONFIG_ISL29125)		+= isl29125.o obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o 
>>> obj-$(CONFIG_LTR501)		+= ltr501.o +obj-$(CONFIG_OPT3001)		+= opt3001.o obj-$(CONFIG_SENSORS_TSL2563)	+=
>>> tsl2563.o obj-$(CONFIG_TCS3414)		+= tcs3414.o obj-$(CONFIG_TCS3472)		+= tcs3472.o diff --git
>>> a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c new file mode 100644 index 0000000..1d925fd1 ---
>>> /dev/null +++ b/drivers/iio/light/opt3001.c @@ -0,0 +1,765 @@ +/** + * opt3001.c - Texas Instruments OPT3001
>>> Light Sensor + * + * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com + * + * Author:
>>> Felipe Balbi <balbi@ti.com> + * + * This program is free software: you can redistribute it and/or modify it + *
>>> under the terms of the GNU General Public License version 2 of the License + * as published by the Free
>>> Software Foundation. + * + * This program is distributed in the hope that it will be useful, but WITHOUT + *
>>> ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or + * FITNESS FOR A PARTICULAR PURPOSE.
>>> See the GNU General Public License for + * more details. + */ + +#include <linux/bitops.h> +#include
>>> <linux/delay.h> +#include <linux/device.h> +#include <linux/i2c.h> +#include <linux/interrupt.h> +#include
>>> <linux/irq.h> +#include <linux/kernel.h> +#include <linux/module.h> +#include <linux/mutex.h> +#include
>>> <linux/slab.h> +#include <linux/types.h> + +#include <linux/iio/events.h> +#include <linux/iio/iio.h> +#include
>>> <linux/iio/sysfs.h> + +#define OPT3001_RESULT		0x00 +#define OPT3001_CONFIGURATION	0x01 +#define
>>> OPT3001_LOW_LIMIT	0x02 +#define OPT3001_HIGH_LIMIT	0x03 +#define OPT3001_MANUFACTURER_ID	0x7e +#define
>>> OPT3001_DEVICE_ID	0x7f + +#define OPT3001_CONFIGURATION_RN_MASK (0xf << 12) +#define
>>> OPT3001_CONFIGURATION_RN_AUTO (0xc << 12) + +#define OPT3001_CONFIGURATION_CT	(1 << 11)
>> 
>> could use BIT() from bitops.h
> 
> sure, easy enough.
> 
>>> +static int opt3001_read(const struct opt3001 *opt, u8 reg) +{ +	return
>>> i2c_smbus_read_word_swapped(opt->client, reg); +} + +static int opt3001_write(const struct opt3001 *opt, u8
>>> reg, u16 value) +{ +	return i2c_smbus_write_word_swapped(opt->client, reg, value); +} +
>> 
>> many small helper function; worth it to wrap a one-liner?
> 
> why not ? I think it looks better and it'll get inlined anyway. It also helps a lot when using kernel function
> tracer.
> 
>>> +		.scan_type = { +			.sign = 'u',
>> 
>> .realbits / .storagebits missing?
> 
> yeah, couldn't figure this out. The HW gives me a 16-bit value where 12-bits are the mantissa and 4-bits are for
> the exponent. Should I call realbits 16 and storagebits 32 ?
Only relevant if you are doing buffered mode. Unless we extend the bufferred
data description futher you'll need to unwind the format into a more
conventional form in kernel anyway.  With a 4 bit mantissa and 16 bit value
you'll need to have a

> 
>> 
>>> +			.endianness = IIO_BE, +		}, +		.scan_index = 0, +		.event_spec = opt3001_event_spec, +		.num_event_specs =
>>> ARRAY_SIZE(opt3001_event_spec), +	}, +	IIO_CHAN_SOFT_TIMESTAMP(1), +}; + +static int opt3001_get_lux(struct
>>> opt3001 *opt, int *val, int *val2) +{ +	int ret; +	u16 mantissa; +	u16 reg; +	u8 exponent; + +	ret =
>>> opt3001_read(opt, OPT3001_CONFIGURATION); +	if (ret < 0) { +		dev_err(opt->dev, "failed to read register
>>> %02x\n", +				OPT3001_CONFIGURATION); +		return ret; +	} + +	reg = ret; +	opt3001_set_mode(opt, &reg,
>>> OPT3001_CONFIGURATION_M_SINGLE); + +	ret = opt3001_write(opt, OPT3001_CONFIGURATION, reg); +	if (ret < 0) { +
>>> dev_err(opt->dev, "failed to read register %02x\n",
>> 
>> "failed to write register ..."
> 
> yeah thanks. copy&paste error.
> 
>>> +				OPT3001_CONFIGURATION); +		return ret; +	} + +	/* wait for conversion and give it an extra 5ms */ +
>>> usleep_range(opt->int_time + 5000, opt->int_time + 10000); + +	ret = opt3001_read(opt, OPT3001_CONFIGURATION); 
>>> +	if (ret < 0) { +		dev_err(opt->dev, "failed to read register %02x\n", +				OPT3001_CONFIGURATION); +		return
>>> ret; +	} + +	reg = ret; +	if (!(reg & OPT3001_CONFIGURATION_CRF)) +		return -EPIPE; + +	ret = opt3001_read(opt,
>>> OPT3001_RESULT); +	if (ret < 0) { +		dev_err(opt->dev, "failed to read register %02x\n", +				OPT3001_RESULT); 
>>> +		return ret; +	} + +	exponent = OPT3001_REG_EXPONENT(ret); +	mantissa = OPT3001_REG_MANTISSA(ret); + +
>>> opt3001_to_iio_ret(opt, exponent, mantissa, val, val2); + +	return IIO_VAL_INT_PLUS_MICRO; +} + +static int
>>> opt3001_get_scale(struct opt3001 *opt, int *val, int *val2) +{ +	int ret; +	u8 exponent; +
>> 
>> I guess OPT3001_RESULT is only valid AFTER performing opt3001_get_lux()
> 
> right. I'm only interested in the exponent part. It'll latch the exponent from last conversion, 0 being default.
Given you unwind the scale anyway in your read raw, I'd not bother
having a scale interface at all (assuming I'm right in thinking your
read raw is returning the value in lux?)  Also as you are in lux, it
should be the processed form not the raw one to indicate the scale
does not need to be applied to the value to convert to lux.

For a light sensor, the conversion here is actually fairly straight
forward. Almost all of them have to use the processed interface
as they are horribly non linear.
> 
>>> +static int opt3001_read_raw(struct iio_dev *iio, +		struct iio_chan_spec const *chan, int *val, int *val2, +
>>> long mask) +{ +	struct opt3001 *opt = iio_priv(iio); +	int ret = 0;
>> 
>> initialization not needed
> 
> I'll drop
> 
>>> +static int opt3001_write_raw(struct iio_dev *iio, +		struct iio_chan_spec const *chan, int val, int val2, +
>>> long mask) +{ +	struct opt3001 *opt = iio_priv(iio); +	int ret = 0;
>> 
>> initialization not needed
> 
> I'll drop
> 
>>> + +	if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS) +		return -EBUSY; + +	if (chan->type != IIO_LIGHT) +
>>> return -EINVAL; + +	mutex_lock(&opt->lock); + +	switch (mask) {
>> 
>> is there no way to control the scale?
> 
> yeah, but the HW does auto-scaling which works pretty well. Why would you want to control the scale manually ?
On a slow device like this you probably wouldn't but for quicker devices
the overhead of converting into a standard form in kernel might be
excessive.
> 
>>> +static int opt3001_write_event_value(struct iio_dev *iio, +		const struct iio_chan_spec *chan, enum
>>> iio_event_type type, +		enum iio_event_direction dir, enum iio_event_info info, +		int val, int val2) +{ +
>>> struct opt3001 *opt = iio_priv(iio); +	int ret = 0; + +	u16 *thresh_mantissa; +	u16 mantissa; +	u16 value; +
>>> u16 reg; + +	u8 *thresh_exp;
>> 
>> why extra newlines?
> 
> why not ? I generally separate the types as it aids readability.
> 
>>> +static int opt3001_remove(struct i2c_client *client) +{ +	/* nothing to do here */
>> 
>> shutdown the device probably?
> 
> it's always in shutdown unless it's doing a transfer. The only exception being if we enable continuous mode and
> remove the module. Might be better to check that and shut it down, sure.
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJT41AYAAoJEFSFNJnE9BaIge0QAJr/w1JYg8hdIO+sWbzqK6Ps
ifGSlbXbE0u14CCKovkjUytPxGVjddq/7EOJZlTq+P28j9x9YuAD8MXsKXF0G8Cb
rk1fwdty82WBdf1/IO5F752irmlJyO80oQlrqQjeN8xvbRYG9dIN7wiLYyyKSMBg
Nv9Ipl3m7q6Sk22R0rcwTmGaESKHUsGLh2OvujOZd81gTpeOp456mTaWUC6Dbkvs
BkxGZrC/xJsOYYBcjPfEvP5BT0tSLizRybL5UvFTgeagjP8E8LoBvIjoj9fr0Z+e
5nuJbfWnhAtWisHh/jzyyEyqdKL3RaZmM1sY7+9k6bhN7rRwheAe7mqk4dYTRMMq
DrwL8bIU6RyTEJlW1lwTL6fzQFGYqurR34+JqTwxnpcESCfle4SSnbRUaOnLpRff
VQIcN/SVXBKsp6y+h80wEmihjdxEHp42h0X8srke91rGm3cmqC+rWzizCM9/vsEh
Dwih+UeLlh5npk4AZyoVkPc+sFRYCFMd+HKvqB35QjLVhcIKg5eYCSSsRNuVaQc5
WJd5G/Gn7l2K8UyAiQg7m5+IqYlSgCbJurtuFznlK07SIX7lkGcmZC4VCWimv1H6
rzROP6b61VAeUCJPjp5uu5ItWIhmPcaMHJlZAFsGWoI637OgPEUYYyQHRU9m+4Po
lKg90ctYuwP4ja4d8rhR
=3RvV
-----END PGP SIGNATURE-----
