Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A76443A8E
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827338; cv=none; b=QgQUBCLXL8FrTzPCFaraHZV7Rqm5waRgx9G5uTUlwGRHzVSm2st8eW9ngblSPTBALYmHKUfxTygDpFsxequqp+kI2f8xLi97NcacG1mGutJdmk5aAET5XRgcq9zMklcATbS80Ahk7u37WN9ND42cf6RKG7E0d3MZWt+VDCfFwxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827338; c=relaxed/simple;
	bh=t4AHcoN12B1QjSi/ljYwVA9bQFM5mM/AVbU8fVBPFfE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mKAo+HZ5I1C+yukpt9KqcIwUUcKRr3KvpERpDviVlf1ZVfID/5De6WpsJLpm1iblrrqq1VAZUn36kcMl09mGkknwKyPyJtnbCGcTXZSn+kZ8ObGr2gu0yk/CeHUpgB3ng5ahf1akwW5vxEQTttJOxWbSoIv8IFp2SbSVYjZlhDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tvP3YDKG; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tvP3YDKG"
Message-ID: <7b986215fe644da12c4bdab1abefbf43dbb3c3eb.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784827322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QtL7gszN3sM117kkbXH/EmXUyyGD0Xu3aTOGAdJZAY=;
	b=tvP3YDKG7fjwNsw8YnsOBxAAS05zxqKdzbstCyBkMcNTUQUPSgOOwsz6PpETGpP5S29B+t
	LZ6qwFvrHJmF336sAGoucVA3y8ITR5Y/B3w/LycDtoaF4hflDcde7EnprAfV7EPtBPsolk
	Oup920+5Njk3eUy/AAF7VA8IpojQ8ac=
Subject: Re: [PATCH v5 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Siratul Islam <siratul.islam@linux.dev>
To: Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, andy@kernel.org, 
	nuno.sa@analog.com, linux@roeck-us.net, robh@kernel.org,
 krzk+dt@kernel.org, 	conor+dt@kernel.org, dlechner@baylibre.com,
 ciprian.hegbeli@analog.com, 	u.kleine-koenig@baylibre.com
Date: Thu, 23 Jul 2026 23:21:16 +0600
In-Reply-To: <20260723065036.2683075-3-stefan.popa@analog.com>
References: <20260723065036.2683075-1-stefan.popa@analog.com>
	 <20260723065036.2683075-3-stefan.popa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Thu, 2026-07-23 at 09:50 +0300, Stefan Popa wrote:
> The MAX40080 is a bidirectional current-sense amplifier with an
> integrated 12-bit ADC and an I2C/SMBus interface. It measures the
> voltage across an external shunt resistor and the input bus voltage,
> storing the results in an internal FIFO.
>=20
...
> =C2=A0
> +MAXIM MAX40080 CURRENT SENSE AMPLIFIER DRIVER
> +M:	Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> +M:	Stefan Popa <stefan.popa@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
MAINTAINERS file entry for the binding should be added with the binding pat=
ch.
> +F:	drivers/iio/adc/max40080.c
> +
>=20
...
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * MAX40080 Digital Current-Sense Amplifier driver
> + *
> + * Copyright 2026 Analog Devices, Inc.
I'd also add the datasheet link here.
/* Datasheet: <https://www.analog.com/media/en/technical-documentation/data=
-sheets/MAX40080.pdf> */
> + */
> +
...
> +
> +/* CFG.mode field */
> +#define MAX40080_STDBY_MODE		0x00
> +#define MAX40080_SINGLE_MODE		0x02	/* one conversion per Quick Command *=
/
Make "o" in "One" uppercase to maintain consistency with your other comment=
s.
> +
> +/* FIFO_CFG.store_iv field */
> +#define MAX40080_STORE_I_V		0x02
Why I_V and not IV?
> +
> +#define MAX40080_ADC_RES		4096
> +#define MAX40080_INTER_VREF_MV		1250
Andy would usually suggest "mV"
> +#define MAX40080_V_BUFF_GAIN		30
> +#define MAX40080_CSA_50MV_GAIN		25
> +#define MAX40080_CSA_10MV_GAIN		125
Ditto.
> +
> +/*
...
> +
> +static int max40080_update_bits(struct max40080_state *st, u8 reg,
> +				u16 mask, u16 val)
> +{
> +	int ret;
> +	int tmp;
> +
> +	guard(mutex)(&st->lock);
> +
> +	tmp =3D i2c_smbus_read_word_data(st->client, reg);
> +	if (tmp < 0)
> +		return tmp;
> +
> +	tmp &=3D ~mask;
> +	tmp |=3D val & mask;
Could be done in one step? "tmp =3D (tmp & ~mask) | (val & mask)"
> +
> +	ret =3D i2c_smbus_write_word_data(st->client, reg, tmp);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int max40080_read_iv(struct max40080_state *st, u32 *iv)
> +{
> +	u32 tmp =3D 0;
> +	int ret, io_ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret =3D max40080_trigger_measurement(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Wait for the conversion to complete by polling the FIFO valid bit
> +	 * (or bail out on an I2C error). Polling the device's own status makes
> +	 * this independent of the actual conversion time, which varies with th=
e
> +	 * oversampling ratio and the bus speed. The timeout is only a safety
> +	 * ceiling: the worst case is the maximum 128x averaging on both the
> +	 * current and voltage channels at the slowest 15 ksps base rate plus t=
he
> +	 * inter-channel switching time, i.e. roughly 20 ms; 50 ms leaves ample
> +	 * margin.
> +	 */
> +	ret =3D read_poll_timeout(max40080_read_iv_once, io_ret,
> +				io_ret || (tmp & MAX40080_IV_VALID_MSK),
> +				500, 50000, false, st, &tmp);
> +	*iv =3D tmp;
Is "iv" intentionally being written even in error path? Ideally it would be=
=C2=A0
assigned after the check.
> +	if (ret)
> +		return ret;
> +
> +	return io_ret;
> +}
> +
> +/*
> + * max40080_oversampling_avail[] is ordered so that its index is the FIL=
TER
> + * field value (index 0 =3D no averaging, index 1 =3D 8x, ...). Return t=
hat index
> + * for an exact match, or -EINVAL for a value that is not on the list.
> + */
> +static int max40080_oversampling_to_filter(int val)
> +{
> +	int i;
> +
Just use for(unsigned int i =3D 0; i < ARRAY_SIZE(max40080_oversampling_ava=
il); i++);
No need to have a separate declaration of 'i' for "for"
> +	for (i =3D 0; i < ARRAY_SIZE(max40080_oversampling_avail); i++)
> +		if (max40080_oversampling_avail[i] =3D=3D val)
> +			return i;
I'd use scope here as it's technically multiline. "for(...) { }"
> +
> +	return -EINVAL;
> +}
> +
> +static int max40080_set_oversampling_ratio(struct max40080_state *st, in=
t val)
> +{
> +	int ret, filter =3D max40080_oversampling_to_filter(val);
Separate initialization from declaration.

int ret, filter;

filter =3D max40080_oversampling_to_filter(val);
> +
> +	if (filter < 0)
> +		return filter;
> +
> +	ret =3D max40080_update_bits(st, MAX40080_REG_CFG, MAX40080_FILTER_MSK,
> +				=C2=A0=C2=A0 FIELD_PREP(MAX40080_FILTER_MSK, filter));
> +	if (ret)
> +		return ret;
> +
> +	st->oversampling_ratio =3D val;
> +
> +	return 0;
> +}
> +
> +static int max40080_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 int *val,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 int *val2,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 long mask)
Put "int *val, int *val2, long mask" on the same line. i.e,
static int max40080_read_raw(struct iio_dev *indio_dev,
			     struct iio_chan_spec const *chan,
			     int *val, int *val2, long mask)

> +{
> +	struct max40080_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type =3D=3D IIO_CURRENT) {
> +			ret =3D max40080_get_current(st, val);
> +			if (ret)
> +				return ret;
> +		} else if (chan->type =3D=3D IIO_VOLTAGE) {
> +			ret =3D max40080_get_voltage(st, val);
> +			if (ret)
> +				return ret;
> +		}
> +
Either have this space before return on all of the paths in this "switch"=
=C2=A0
or none of them for consistency.
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type =3D=3D IIO_CURRENT) {
> +			/*
> +			 * The selectable current-sense range is exposed through
> +			 * scale: each RANGE setting has its own precomputed
> +			 * mA-per-code value. Userspace picks the range by writing
> +			 * the matching scale.
> +			 */
> +			*val =3D st->current_scale[st->range][0];
> +			*val2 =3D st->current_scale[st->range][1];
> +			return IIO_VAL_INT_PLUS_NANO;
> +		}
> +		/* voltage[mV] =3D raw * Vref[mV] * buffer_gain / ADC_RES */
> +		*val =3D MAX40080_INTER_VREF_MV * MAX40080_V_BUFF_GAIN;
> +		*val2 =3D MAX40080_ADC_RES;
> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret =3D max40080_get_oversampling_ratio(st, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max40080_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
> +{
> +	struct max40080_state *st =3D iio_priv(indio_dev);
> +	unsigned int i;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Only the current channel has a selectable range/scale. */
> +		if (chan->type !=3D IIO_CURRENT)
> +			return -EINVAL;
> +
> +		for (i =3D 0; i < MAX40080_NUM_RANGES; i++)
> +			if (val =3D=3D st->current_scale[i][0] &&
> +			=C2=A0=C2=A0=C2=A0 val2 =3D=3D st->current_scale[i][1])
> +				return max40080_set_range(st, i);
I'd add brackets to this "for" too like above.
> +
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret =3D max40080_set_oversampling_ratio(st, val);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max40080_reg_access(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int reg,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int write_val,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int *read_val)
> +{
> +	struct max40080_state *st =3D iio_priv(indio_dev);
> +
> +	if (read_val) {
> +		int val =3D i2c_smbus_read_word_data(st->client, reg);
Declare this "val" at the top.
> +
> +		if (val < 0)
> +			return val;
> +		*read_val =3D val;
Add blank lines above and below
"*read_val =3D val;"
> +		return 0;
> +	}
> +
> +	return i2c_smbus_write_word_data(st->client, reg, write_val);
> +}
> +
> +/*
> + * Configure the device from the cached state. The device powers up in s=
tandby
> + * with PEC enabled (CFG POR =3D 0x0060), so PEC is kept enabled through=
out.
> + */
> +static int max40080_init(struct max40080_state *st)
> +{
> +	u16 fifo_cfg, cfg;
> +	int ret, filter;
> +
> +	filter =3D max40080_oversampling_to_filter(st->oversampling_ratio);
> +	if (filter < 0)
> +		return filter;
> +
> +	/*
> +	 * Put the device in standby before (re)configuring the FIFO: the FIFO
> +	 * configuration register can only be written while the device is not
> +	 * converting.
> +	 */
> +	cfg =3D FIELD_PREP(MAX40080_MODE_MSK, MAX40080_STDBY_MODE) |
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(MAX40080_PEC_EN_MSK, 1);
I'd have a blank line before the "ret" assignments.
> +	ret =3D i2c_smbus_write_word_data(st->client, MAX40080_REG_CFG, cfg);
> +	if (ret)
> +		return ret;
> +
> +	/* Store a matched current+voltage pair per conversion. */
> +	fifo_cfg =3D FIELD_PREP(MAX40080_STORE_IV_MSK, MAX40080_STORE_I_V);
Here too.
> +	ret =3D i2c_smbus_write_word_data(st->client, MAX40080_REG_FIFO_CFG,
> +					fifo_cfg);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Use single-measurement mode: the device stays idle and converts once
> +	 * per SMBus Quick Command (see max40080_trigger_measurement()), so eac=
h
> +	 * read returns a fresh sample rather than a queued FIFO entry.
> +	 */
> +	cfg =3D FIELD_PREP(MAX40080_MODE_MSK, MAX40080_SINGLE_MODE) |
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(MAX40080_PEC_EN_MSK, 1) |
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(MAX40080_RANGE_MSK, st->range=
) |
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(MAX40080_FILTER_MSK, filter);
> +
Like you have here.
> +	ret =3D i2c_smbus_write_word_data(st->client, MAX40080_REG_CFG, cfg);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int max40080_probe(struct i2c_client *client)
> +{
> +
...
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
Is it used?
> +	st =3D iio_priv(indio_dev);
> +	st->client =3D client;
> +
> +	ret =3D devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D device_property_read_u32(dev, propname, &st->shunt_resistor_uoh=
m);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "can't read %s\n", propname);
Add a space here.
> +	if (!st->shunt_resistor_uohm)
> +		return dev_err_probe(dev, -EINVAL, "%s must be non-zero\n",
> +				=C2=A0=C2=A0=C2=A0=C2=A0 propname);
> +
> +	max40080_calc_current_scale(st);
> +
> +	/* Defaults: 50 mV range (index 0), no averaging. */
> +	st->range =3D 0;
> +	st->oversampling_ratio =3D 1;
> +
> +	indio_dev->name =3D "max40080";
> +	indio_dev->info =3D &max40080_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D max40080_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(max40080_channels);
> +
> +	ret =3D max40080_init(st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id max40080_i2c_ids[] =3D {
> +	{ "max40080" },
use named initializer. i.e,=20
{ .name =3D "max40080" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max40080_i2c_ids);
> +
>=20
...
> +MODULE_AUTHOR("Ciprian Hegbeli <ciprian.hegbeli@analog.com>");
> +MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices MAX40080 current-sense amplifier driv=
er");
> +MODULE_LICENSE("GPL");
