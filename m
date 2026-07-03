Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDBE28488F
	for <linux-iio@vger.kernel.org>; Fri,  3 Jul 2026 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783107796; cv=none; b=OMCuB6pq0pjno+xbdvCVYlxyB6YfCQKoZlJEy25TjHfvkvDBBXFxLiSxRk4eBb/IZLV1qGaIHBGmu/FTyTptDCe1BhoVqZNXVAgJuJULTfj065ReTjlypEu4rt1gmk+EKtuMkV8z7kx8luCm0wZWAZ6Ui5WDCWaWODcxAVkZTss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783107796; c=relaxed/simple;
	bh=b0GF0Br8yanUhjxYGdPnTvzJRVaR6Wg2hft+j3NEYfY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IC9Ro2vikZrJ2USUwBU/VmuaEVbZj8m/7Fxg8sqZnZ8mSiYphkLgbPuVTEFe8hWFvonBZYLIuUnR/lyRMwZW17MJM7A8W9MPhH0EPseSdbq817rO9s9znLVeJ4V7emz/B7SoyJCsBi7hFLg6ZW2VvgLAT+y0c1dZW2JYSbgAdH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dXM1TfMJ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dXM1TfMJ"
Message-ID: <9878f042f424bfbd7fab24175298224b58e87779.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783107782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uZO1sX8QbjOMl063nzq/2Es6qmjh1VUaSD7dIek0KBs=;
	b=dXM1TfMJOVV+eFjwie5jESveDPenwpqM1E7utBLzbiEQTaQhNaoaqs07WIfWpV2C+ocdH7
	IlL5uV/56J4tlCQ7kfUHeWIXFXsJ1hwrtIQB6JQqTpqSaI6ZhMplJKdpvG0yZCkntDkVwT
	+0/okuDEhvwcTdOh9q6aDRa6tiRSW7Y=
Subject: Re: [PATCH v1 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Siratul Islam <siratul.islam@linux.dev>
To: Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Ciprian Hegbeli <ciprian.hegbeli@analog.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 04 Jul 2026 01:42:39 +0600
In-Reply-To: <20260703102941.1141341-3-stefan.popa@analog.com>
References: <20260703102941.1141341-1-stefan.popa@analog.com>
	 <20260703102941.1141341-3-stefan.popa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Fri, 2026-07-03 at 13:29 +0300, Stefan Popa wrote:
> The MAX40080 is a bidirectional current-sense amplifier with an
> integrated 12-bit ADC and an I2C/SMBus interface. It measures the
> voltage across an external shunt resistor and the input bus voltage,
> storing the results in an internal FIFO.
>=20
>=20
Hi! I already looked at Andy's review and decided to add a few more stuff.
...
> =C2=A0
> +MAXIM MAX40080 CURRENT SENSE AMPLIFIER DRIVER
> +M:	Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> +M:	Stefan Popa <stefan.popa@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
The Maintainer entry for binding should be in the binding patch,
> +F:	drivers/iio/adc/max40080.c
With the driver entry added in this patch.
> +
...
+ array_size.h
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/i2c.h>
> +#include <linux/iopoll.h>
> +#include <linux/math64.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define MAX40080_REG_CFG		0x00
> +#define=C2=A0 MAX40080_MODE_MSK		GENMASK(2, 0)
> +#define=C2=A0 MAX40080_PEC_EN_MSK		BIT(5)
> +#define=C2=A0 MAX40080_RANGE_MSK		BIT(6)
> +#define=C2=A0 MAX40080_FILTER_MSK		GENMASK(14, 12)
Should be one space after #define, like the first one.
> +
> +#define MAX40080_REG_FIFO_CFG		0x0A
Here too
> +#define=C2=A0 MAX40080_STORE_IV_MSK		GENMASK(1, 0)
> +
> +#define MAX40080_REG_IV			0x10
> +/* Current is a 13-bit two's-complement value (magnitude + sign bit). */
> +#define=C2=A0 MAX40080_IV_I_MSK		GENMASK(12, 0)
> +#define=C2=A0 MAX40080_IV_I_SIGN_BIT		12
> +#define=C2=A0 MAX40080_IV_V_MAG_MSK		GENMASK(27, 16)
> +#define=C2=A0 MAX40080_IV_VALID_MSK		BIT(31)
> +
> +/* CFG.mode field */
> +#define MAX40080_STDBY_MODE		0x00
> +#define MAX40080_SINGLE_MODE		0x02	/* one conversion per Quick Command *=
/
> +
> +/* FIFO_CFG.store_iv field */
> +#define MAX40080_STORE_I_V		0x02
> +
> +#define MAX40080_ADC_RES		4096
> +#define MAX40080_INTER_VREF_MV		1250
> +#define MAX40080_V_BUFF_GAIN		30
Maybe sort by value? just a nit.
> +#define MAX40080_CSA_50MV_GAIN		25
> +#define MAX40080_CSA_10MV_GAIN		125
> +
> +/*
> + * The RANGE field (CFG bit 6) selects one of two current-sense full-sca=
le
> + * ranges (the MAX40080 supports exactly two: +/-50 mV and +/-10 mV). Or=
dered
> + * so that the array index equals the RANGE field value: index 0 =3D 50 =
mV range
> + * (gain 25 V/V), index 1 =3D 10 mV range (gain 125 V/V).
> + */
> +static const int max40080_csa_gain[] =3D {
> +	MAX40080_CSA_50MV_GAIN, MAX40080_CSA_10MV_GAIN,
Maybe 1 item per line since it's a macro?=20
> +};
> +
> +#define MAX40080_NUM_RANGES	ARRAY_SIZE(max40080_csa_gain)
> +
> +struct max40080_state {
> +	struct i2c_client *client;
> +	/* Serializes read-modify-write access to the CFG register. */
> +	struct mutex lock;
> +	u32 shunt_resistor_uohm;
> +	/*
> +	 * Precomputed current scale (mA per code) for each RANGE setting, as
> +	 * {integer, nano} pairs for IIO_VAL_INT_PLUS_NANO. The range is
> +	 * selected by writing the corresponding scale.
> +	 */
> +	int current_scale[MAX40080_NUM_RANGES][2];
> +};
> +
> +static const int max40080_oversampling_avail[] =3D { 1, 8, 16, 32, 64, 1=
28 };
> +
> +static int max40080_update_bits(struct max40080_state *st, u8 reg,
> +				u16 mask, u16 val)
This can fit in 1 line.
static int max40080_update_bits(struct max40080_state *st, u8 reg, u16 mask=
, u16 val)

> +{
> +	int ret;
> +	int tmp;
> +
> +	guard(mutex)(&st->lock);
> +
...
> + */
> +static int max40080_read_iv_once(struct max40080_state *st, u32 *iv)
> +{
> +	u8 buf[4];
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_i2c_block_data(st->client, MAX40080_REG_IV,
> +					=C2=A0=C2=A0=C2=A0 sizeof(buf), buf);
This also fits in 1 line but it would go 92 cols, so not sure which one is =
preferred.
> +	if (ret < 0)
> +		return ret;
> +	if (ret !=3D sizeof(buf))
> +		return -EIO;
> +
> +	*iv =3D get_unaligned_le32(buf);
> +
> +	return 0;
> +}
> +
>=20
...
> +
> +static int max40080_get_current(struct max40080_state *st, int *val)
> +{
> +	u32 iv;
> +	int ret;
> +
> +	ret =3D max40080_read_iv(st, &iv);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D sign_extend32(FIELD_GET(MAX40080_IV_I_MSK, iv),
> +			=C2=A0=C2=A0=C2=A0=C2=A0 MAX40080_IV_I_SIGN_BIT);
This can also be 1 line if you are going for that.
> +
> +	return 0;
> +}
> +
> +static int max40080_get_voltage(struct max40080_state *st, int *val)
> +{
> +	u32 iv;
> +	int ret;
> +
> +	ret =3D max40080_read_iv(st, &iv);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D FIELD_GET(MAX40080_IV_V_MAG_MSK, iv);
> +
> +	return 0;
> +}
> +
> +static int max40080_get_range(struct max40080_state *st, unsigned int *r=
ange)
> +{
> +	int tmp;
> +
> +	tmp =3D i2c_smbus_read_word_data(st->client, MAX40080_REG_CFG);
I think tmp can be initialized, since it is only assigned once.
> +	if (tmp < 0)
> +		return tmp;
> +
> +	*range =3D FIELD_GET(MAX40080_RANGE_MSK, tmp);
> +
> +	return 0;
> +}
> +
...
> +
> +/*
> + * The FILTER field selects digital averaging of N consecutive conversio=
ns
> + * (no averaging, 8, 16, 32, 64 or 128), which maps directly to the IIO
> + * oversampling ratio. Averaging reduces the effective output data rate =
by the
> + * same factor; the conversion rate itself is set by the separate ADC_RA=
TE
> + * field.
> + */
> +static int max40080_get_oversampling_ratio(struct max40080_state *st, in=
t *val)
> +{
> +	int tmp;
> +	u8 filter;
Reverse xmas tree.
+ u8 filter;
+ int tmp;
While you are at it, and since you are already using u8, tmp can be s32.
> +
> +	tmp =3D i2c_smbus_read_word_data(st->client, MAX40080_REG_CFG);
> +	if (tmp < 0)
> +		return tmp;
> +
> +	filter =3D FIELD_GET(MAX40080_FILTER_MSK, tmp);
> +	*val =3D (filter =3D=3D 0) ? 1 : (8 << (filter - 1));
> +
> +	return 0;
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
> +	for (i =3D 0; i < ARRAY_SIZE(max40080_oversampling_avail); i++)
> +		if (max40080_oversampling_avail[i] =3D=3D val)
> +			return i;
Since this for is multiline, it could use scope, {}.
> +
> +	return -EINVAL;
> +}
> +
...
> +}
> +
> +static int max40080_read_avail(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan=
,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const int **vals, int *type, int=
 *length,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long info)
> +{
> +	struct max40080_state *st =3D iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type !=3D IIO_CURRENT)
> +			return -EINVAL;
> +
> +		*vals =3D (int *)st->current_scale;
> +		*length =3D MAX40080_NUM_RANGES * 2;
> +		*type =3D IIO_VAL_INT_PLUS_NANO;
I think a space between the assignments and the return would read better. P=
ersonal preference. Your call.
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals =3D max40080_oversampling_avail;
> +		*length =3D ARRAY_SIZE(max40080_oversampling_avail);
> +		*type =3D IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
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
> +
> +		if (val < 0)
> +			return val;
> +		*read_val =3D val;
Here too.
> +		return 0;
> +	}
> +
> +	return i2c_smbus_write_word_data(st->client, reg, write_val);
> +}
...
>=20
> +}
> +
> +static const struct i2c_device_id max40080_i2c_ids[] =3D {
> +	{ "max40080" },
.name =3D "max40080"
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max40080_i2c_ids);
> +
> +static const struct of_device_id max40080_of_match[] =3D {
> +	{ .compatible =3D "maxim,max40080" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max40080_of_match);
> +
> +static struct i2c_driver max40080_driver =3D {
> +	.driver =3D {
> +		.name =3D "max40080",
> +		.of_match_table =3D max40080_of_match,
> +	},
> +	.probe =3D max40080_probe,
> +	.id_table =3D max40080_i2c_ids,
> +};
> +module_i2c_driver(max40080_driver);
> +
> +MODULE_AUTHOR("Ciprian Hegbeli <ciprian.hegbeli@analog.com>");
> +MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices MAX40080 current-sense amplifier driv=
er");
> +MODULE_LICENSE("GPL");
