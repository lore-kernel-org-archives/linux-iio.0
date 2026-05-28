Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739953E1231;
	Thu, 28 May 2026 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779967375; cv=none; b=RmhUMK7vqq3ROJOd4VOTnegLFGmMp7PYNp2soKZ4hp146f/luqzhtl4Pi3gS+RB6dztF0Smy2JmWtncO+Xq4taPTcLWDGnnYqrkEVY8xcnX0YNUktT4bEg0GC5Mfp0L8DezQOoEhwALHS+7sArcedLPPKYuFvbzKQCUQDjPQ/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779967375; c=relaxed/simple;
	bh=o57KCrQaOcbqzyH+seGr7LLP+j2H4xw8x0SSewVo/SY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0U1dWMvtFhqSUFA5jtWGeugUBoWAKanGOIv31Dr8XZB1OmMUeCuZZwHDV3Bduw1RY5UAesC51HRpa0TrIxSQzA21jN9Yh/NpPt6lbkdfDFBJ3zrlIMclbv4YnhhBN4ZwwRXl/qwz98MIVw+UYcBtdK73/3qZ0/ay/tiXxOWYmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nI2387Fr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nI2387Fr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B401F000E9;
	Thu, 28 May 2026 11:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779967373;
	bh=t6nnBcVx6zH2ywacYtDReDsrezM2E3GwiJ9142LfKRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nI2387Fr4riG+cQhdtIlcJQ9p8fa8JYl6Y6eYRwfQw4UBkYr8NhZwcpopza/R6w50
	 zjuRbluOlNaBgbtu2Dnm/16uAXnspKd/PQ9doHtgDq1CJvCk4HOhaAFKiCf1YLalN8
	 BqZ5lofn9nPSW8t4KaAaZpkJPzFNfkNCAuiUds/syBNoCvyFQaGZYa7I9Ye4nxaV61
	 pRUSRgrOlrRWk29Xg5jZX2hsGlCrZHgVSsHsaLGnttvSgiqCFAERRvAz/n4Y7Une5P
	 wuZlH8AD1oKO3EkocfbgCWKnrW6x8QMImBz2FfVmmVEUnoFkgB6/nT6ehX01mYu2Rc
	 12ozgBjB6lZgg==
Date: Thu, 28 May 2026 12:22:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Maxwell Doose
 <m32285159@gmail.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Jean Delvare
 <jdelvare@suse.com>, Andreas Klinger <ak@it-klinger.de>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-hwmon@vger.kernel.org, Rodrigo Alencar
 <rodrigo.alencar@analog.com>
Subject: Re: [PATCH v2 3/3] iio: flow: add Sensirion SLF3S liquid flow
 sensor driver
Message-ID: <20260528122244.2e408dd3@jic23-huawei>
In-Reply-To: <20260527184257.141635-4-wafgo01@gmail.com>
References: <20260524205112.26638-1-wafgo01@gmail.com>
	<20260527184257.141635-1-wafgo01@gmail.com>
	<20260527184257.141635-4-wafgo01@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 20:42:54 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> Add a driver for the Sensirion SLF3S family of digital liquid-flow
> sensors (SLF3S-0600F, SLF3S-1300F and SLF3S-4000B).  The sensors
> communicate over I2C and return a 16-bit signed flow value, a 16-bit
> signed temperature reading and a status word - each protected by a
> CRC-8 byte - in every measurement frame.
> 
> The driver exposes:
> 
>   in_volumeflow_raw     - signed raw counts
>   in_volumeflow_scale   - litres per second per LSB (per variant)
>   in_temp_raw           - signed raw counts
>   in_temp_scale         - millidegrees Celsius per LSB
> 
> The variant is auto-detected from the product-info word read at
> probe time.  All three SLF3S devices are factory-calibrated for both
> water and isopropyl alcohol; the calibration medium is selected via
> the sensirion,medium device property and defaults to water.
> 
> Scale factors are taken from the respective datasheets (Table 16
> for SLF3S-0600F, Table 15 for SLF3S-1300F and SLF3S-4000B):
> 
>   SLF3S-0600F:  10 (ul/min)^-1  -> 1/600 000 000 (l/s)/LSB
>   SLF3S-1300F: 500 (ml/min)^-1  -> 1/30 000 000  (l/s)/LSB
>   SLF3S-4000B:  32 (ml/min)^-1  -> 1/1 920 000   (l/s)/LSB
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Andreas Klinger <ak@it-klinger.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-hwmon@vger.kernel.org
> Cc: Maxwell Doose <m32285159@gmail.com>

A few fairly minor things inline. Also check out sashiko's review
https://sashiko.dev/#/patchset/20260527184257.141635-1-wafgo01%40gmail.com
(Note the DMA buffers stuff is wrong for I2C so ignore that)

> diff --git a/drivers/iio/flow/slf3s.c b/drivers/iio/flow/slf3s.c
> new file mode 100644
> index 000000000..f971a2dc2
> --- /dev/null
> +++ b/drivers/iio/flow/slf3s.c
> @@ -0,0 +1,345 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sensirion SLF3S liquid flow sensor driver.
> + *
> + * Supports the SLF3S-0600F, SLF3S-1300F and SLF3S-4000B liquid-flow
> + * sensors over I2C.  Each measurement frame returns a 16-bit signed
> + * flow value, a 16-bit signed temperature value and a status word,
> + * each protected by a CRC-8 byte.
> + *
> + * Datasheet: https://sensirion.com/products/catalog/SLF3S-0600F/
> + *
> + * Copyright (C) 2026 CMBlu Energy GmbH
> + * Author: Wadim Mueller <wafgo01@gmail.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>

Check these.  I'd expect dev_printk.h for instance.
Follow IWYU (approximately) for includes.

> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/unaligned.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define SLF3S_CRC8_POLY			0x31
> +#define SLF3S_CRC8_INIT			0xff
> +
> +#define SLF3S_PRODUCT_ID_LEN		18
> +#define SLF3S_PRODUCT_FAMILY_BYTE	1
> +#define SLF3S_PRODUCT_SUBTYPE_BYTE	3
> +#define SLF3S_PRODUCT_FAMILY_ID		0x03
> +
> +#define SLF3S_MEAS_LEN			9

I don't think this constant being a define is that useful. I'd push
the value down to where you set how big the buffer is then use ARRAY_SIZE()
for the loop

> +#define SLF3S_MEAS_START_DELAY_US	12000
> +
> +/*
> + * Temperature LSB equals 1/200 degC.  IIO_TEMP uses milli-degrees,
> + * therefore the scale exposed to userspace is 1000 / 200 = 5.
> + */
> +#define SLF3S_TEMP_SCALE_MILLIC		5

I'd put this value inline with the comment. It's only used in one
place and that is where people will look for information on scale.


> +
> +static const struct slf3s_variant slf3s_variants[] = {
> +	[0] = {
> +		.sub_type	= 0x03,
> +		.name		= "slf3s-0600f",
> +		.scale_num	= 1,
> +		.scale_den	= 600000000,

Probably more readable with 600 * MICRO 

> +	},
> +	[1] = {
> +		.sub_type	= 0x02,
> +		.name		= "slf3s-1300f",
> +		.scale_num	= 1,
> +		.scale_den	= 30000000,

30 * MICRO

> +	},
> +	[2] = {
> +		.sub_type	= 0x05,
> +		.name		= "slf3s-4000b",
> +		.scale_num	= 1,
> +		.scale_den	= 1920000,

1920 * MILLI or leave this one as is. 4 zeros are easy to count ;)

> +	},
> +};
> +
> +/**
> + * struct slf3s_data - per-device state
> + * @client:	I2C client this instance is bound to
> + * @variant:	pointer into @slf3s_variants for the detected device
> + * @crc_table:	pre-computed CRC-8 lookup table for SLF3S_CRC8_POLY
> + */
> +struct slf3s_data {
> +	struct i2c_client *client;
> +	const struct slf3s_variant *variant;
> +	u8 crc_table[CRC8_TABLE_SIZE];
> +};
> +
> +static bool slf3s_crc_valid(const struct slf3s_data *sf, const u8 *block)

I'd be consistent and have const u8 block[at_least 3]
the make it clear how big that is expected to be.

> +{
> +	return crc8(sf->crc_table, block, 2, SLF3S_CRC8_INIT) == block[2];
> +}
> +
> +static int slf3s_send_cmd(struct i2c_client *client, const u8 cmd[static 2])

Use at_least, not static for kernel code as it makes it much more obvious what
is going on.

Note the sashiko report on this memory potentially being used for DMA is wrong.
The i2c subsystem only does that if you opt in.

> +{
> +	int ret = i2c_master_send(client, cmd, 2);
> +
> +	if (ret == 2)
> +		return 0;
> +	return ret < 0 ? ret : -EIO;
> +}
> +
> +/*
> + * Read the product-info block and update @sf->variant.  The kernel

wrap at 80 chars. This is a bit short in places.

> + * trusts the DT compatible (or i2c id_table .data) above all else; the
> + * sub-type byte is a sanity hint.  This means:
> + *
> + *   - bus / CRC failures are real errors and must fail probe;
> + *   - if the caller already picked a variant (specific compatible), the
> + *     PID is logged for diagnostics but mismatches do not fail probe;
> + *   - if the caller has no variant (generic "sensirion,slf3s" fallback),
> + *     the sub-type byte is used to pick one; unknown sub-type fails.
This is interesting approach, but lets discuss it in the dt-binding  thread.

> + */
> +static int slf3s_detect_variant(struct slf3s_data *sf)
> +{
> +	struct i2c_client *client = sf->client;
> +	u8 buf[SLF3S_PRODUCT_ID_LEN];
> +	int ret;
> +
> +	ret = slf3s_send_cmd(client, slf3s_cmd_prep_pid);
> +	if (ret)
> +		return ret;
> +
> +	ret = slf3s_send_cmd(client, slf3s_cmd_read_pid);
> +	if (ret)
> +		return ret;
> +
> +	ret = i2c_master_recv(client, buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(buf))
> +		return -EIO;
> +
> +	for (unsigned int i = 0; i < SLF3S_PRODUCT_ID_LEN; i += 3) {
> +		if (!slf3s_crc_valid(sf, &buf[i]))
> +			return -EIO;
> +	}
> +
> +	if (buf[SLF3S_PRODUCT_FAMILY_BYTE] != SLF3S_PRODUCT_FAMILY_ID)
> +		dev_dbg(&client->dev,
> +			"unexpected family byte 0x%02x (expected 0x%02x)\n",
> +			buf[SLF3S_PRODUCT_FAMILY_BYTE],
> +			SLF3S_PRODUCT_FAMILY_ID);
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(slf3s_variants); i++) {
> +		if (buf[SLF3S_PRODUCT_SUBTYPE_BYTE] !=
> +		    slf3s_variants[i].sub_type)
I'd go slightly long and have that one line.
		if (buf[SLF3S_PRODUCT_SUBTYPE_BYTE] != slf3s_variants[i].sub_type)
We are a bit flexible on the 80 chars where it helps readabilty.


> +			continue;
> +
> +		if (sf->variant && sf->variant != &slf3s_variants[i])
> +			dev_dbg(&client->dev,
> +				"DT compatible says %s but sub-type 0x%02x suggests %s\n",
> +				sf->variant->name,
> +				buf[SLF3S_PRODUCT_SUBTYPE_BYTE],
> +				slf3s_variants[i].name);
> +		else if (!sf->variant)

If this happens I'd go with the detection over the dt provided. And dev_info
for the mismatch as we want people to know wrong sensor is described.

> +			sf->variant = &slf3s_variants[i];
> +		return 0;
> +	}
> +
> +	if (sf->variant) {
> +		dev_dbg(&client->dev,
> +			"unknown SLF3S sub-type 0x%02x, trusting DT compatible %s\n",
> +			buf[SLF3S_PRODUCT_SUBTYPE_BYTE], sf->variant->name);
> +		return 0;
> +	}
> +
> +	dev_dbg(&client->dev, "unknown SLF3S sub-type 0x%02x\n",
> +		buf[SLF3S_PRODUCT_SUBTYPE_BYTE]);
As below. I'd have a blank line here

> +	return -ENODEV;
> +}
> +
> +static int slf3s_read_sample(struct slf3s_data *sf, int *flow, int *temp)
> +{
> +	u8 buf[SLF3S_MEAS_LEN];
> +	int ret;
> +
> +	ret = i2c_master_recv(sf->client, buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(buf))
> +		return -EIO;
> +
> +	for (unsigned int i = 0; i < SLF3S_MEAS_LEN; i += 3) {
> +		if (!slf3s_crc_valid(sf, &buf[i]))
> +			return -EIO;
> +	}
> +
> +	*flow = sign_extend32(get_unaligned_be16(&buf[0]), 15);
> +	*temp = sign_extend32(get_unaligned_be16(&buf[3]), 15);

Trivial but good to have a blank line before simple return statements like
this. Just makes the code a tiny bit more readable.

> +	return 0;
> +}

> +
> +static int slf3s_read_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan, int *val,
> +			  int *val2, long mask)
> +{
> +	struct slf3s_data *sf = iio_priv(indio_dev);
> +	int flow, temp, ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +
> +		ret = slf3s_read_sample(sf, &flow, &temp);
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		*val = (chan->type == IIO_VOLUMEFLOW) ? flow : temp;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_VOLUMEFLOW) {
> +			*val = sf->variant->scale_num;
> +			*val2 = sf->variant->scale_den;

Sashiko (probably correctly) identifies that the formatting that the IIO core
does for an IIO_VAL_FRACTIONAL only goes to 9 decimal places.  That means
in some cases the scale is truncated to 1 digit losing much of its usefulness.
https://sashiko.dev/#/patchset/20260527184257.141635-1-wafgo01%40gmail.com

As such we need to increase the number of digits or maybe switch to using
https://lore.kernel.org/all/20260524-adf41513-iio-driver-v14-6-06824d9c15f4@analog.com/

Which defines IIO_VAL_DECIMAL64_PICO

+CC Rodrigo


> +			return IIO_VAL_FRACTIONAL;
> +		}
> +		*val = SLF3S_TEMP_SCALE_MILLIC;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int slf3s_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct slf3s_data *sf;
> +	const u8 *start_cmd = slf3s_cmd_start_water;
> +	const char *medium;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*sf));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	sf = iio_priv(indio_dev);
> +	sf->client = client;
> +	sf->variant = i2c_get_match_data(client);
> +	crc8_populate_msb(sf->crc_table, SLF3S_CRC8_POLY);
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable vdd supply\n");

More than likely we need some level of sleep here for the device to wake up.
Is there anything in the datasheet?

> +
> +	ret = slf3s_detect_variant(sf);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "product info read failed\n");

> +
> +static const struct of_device_id slf3s_of_match[] = {
> +	{ .compatible = "sensirion,slf3s-0600f", .data = &slf3s_variants[0] },
> +	{ .compatible = "sensirion,slf3s-1300f", .data = &slf3s_variants[1] },
> +	{ .compatible = "sensirion,slf3s-4000b", .data = &slf3s_variants[2] },
> +	{ .compatible = "sensirion,slf3s" },

This came up in the dt review, so I'll assume you'll address it there. How useful
is the generic compatible?

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, slf3s_of_match);
> +
> +static struct i2c_driver slf3s_driver = {
> +	.driver = {
> +		.name		= "slf3s",
> +		.of_match_table	= slf3s_of_match,
> +	},
> +	.probe		= slf3s_probe,
> +	.id_table	= slf3s_id,
> +};
> +module_i2c_driver(slf3s_driver);
> +
> +MODULE_AUTHOR("Wadim Mueller <wafgo01@gmail.com>");
> +MODULE_DESCRIPTION("Sensirion SLF3S liquid flow sensor driver");
> +MODULE_LICENSE("GPL");

