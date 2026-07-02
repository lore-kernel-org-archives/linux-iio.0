Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE3E1E8826;
	Thu,  2 Jul 2026 01:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956307; cv=none; b=S66FD9kb0SorTo4V/4j4avyMOVQBiNyp7Xl56o0x9fsK3bEXu0aNNlOIWfjgwke06gkMq0Si11k4FPn7WEHwn3M9r9tSO6WxdLhqYvSU3+wmC7vKjrNkeaOJEOvnPK8ITVZGqPz/dqiYmLiUF8xyuQ39EpI7FgM74WW/tUaTIpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956307; c=relaxed/simple;
	bh=23wQm/z4BTU1G3N1gEHM+8NEEsK+rJzmYV8XekMPodk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpvWmwe27moL2u1Mr+v9GyOZB2MUHr1S0BGrowYC8Hfa6eGjZK4dVgJfel5mCu4ts00p/Vjhv2pzoEJtdU69fVBuhk6IKMjfmrQR1Dm11G6z1CInGvtlLXqdNqw81e24PFGMcosQHKI1cFCAvd/1ZiMvP2m0oRtIq/j25PDzPzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMoqaxyi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMoqaxyi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AD01F000E9;
	Thu,  2 Jul 2026 01:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782956306;
	bh=Xn5Sl4Qo8XjM43mME8t8pKuZ6Ch0271o365ihDpWNdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IMoqaxyiX4HWSI0DEfWT739u17MW6qYcXFlHIU1bDi4Lv8O+gGTDW+cyi/siHUH1q
	 bacn8ncfKK25w4T/pnuTzQOnDQFbLb6+li0ZCDk214A6OY5gD91s8yW87pq9Y3OhJR
	 aoFWtleyZYwMRtG6ecY3imUR+/BfZTrmCLaMkNQoJmDc1R8ePTumALeSmNqGUr19lP
	 ySZvHjxU0MKMEfQxAmhZXqtPE0XodXRz2ATRxiEVj+DPrvWukVfnfvAohctT5cU+pT
	 9rQgMVSnFPDjILJcooEmW10M4jUIQ0xkr2ptilKkoKCqPnune4Ztkl7gJzPgDjGiVu
	 Igr/uyfpi/O5g==
Date: Thu, 2 Jul 2026 02:38:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Siratul Islam <siratul.islam@linux.dev>
Cc: lukas.metz@gmx.net, andy@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, robh@kernel.org
Subject: Re: [PATCH 1/2] iio: dac: dac8163: Add driver for DAC8163
Message-ID: <20260702023819.21cffbb7@jic23-huawei>
In-Reply-To: <36ffe80feb5a521c28b1a6d10bf1338dc39ddef1.camel@linux.dev>
References: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
	<20260623-dac8163-work-v1-1-5b508158faa0@gmx.net>
	<36ffe80feb5a521c28b1a6d10bf1338dc39ddef1.camel@linux.dev>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Jun 2026 00:56:15 +0600
Siratul Islam <siratul.islam@linux.dev> wrote:

> On Tue, 2026-06-23 at 18:07 +0200, Lukas Metz wrote:
> > The DAC756x, DAC816x, and DAC856x devices are low-power, voltage-output,
> > dual-channel, 12-, 14-, and 16-bit digital-to-analog converters (DACs),
> > respectively. These devices include a 2.5-V, 4-ppm/=C2=B0C internal
> > reference, giving a full-scale output voltage range of 2.5 V or 5 V.
> >=20
> > Signed-off-by: Lukas Metz <lukas.metz@gmx.net>
> > ---
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
> > =C2=A0drivers/iio/dac/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 =
++
> > =C2=A0drivers/iio/dac/Makefile=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/iio/dac/ti-dac8163.c | 339 ++++++++++++++++++++++++++++++=
+++++++++++++
> > =C2=A04 files changed, 356 insertions(+) =20
> Hi! I took a quick look, and probably missed a lot of stuff. But here are=
 my thoughts.

Good review. I added a few things on top (reduces duplication as you didn't=
 crop
- fair enough given distribution of comments!)

> > diff --git a/MAINTAINERS b/MAINTAINERS =20


> > +enum dacxx6x_supported_device_ids {
> > +	ID_DAC7562,
> > +	ID_DAC7563,
> > +	ID_DAC8162,
> > +	ID_DAC8163,
> > +	ID_DAC8562,
> > +	ID_DAC8563
> > +};

This enum provides too tempting a way to indicate devices.
hence just drop it ;)  Named structures as below will be neater.

> > + =20
> Here too.
> >=20
> > +struct dacxx6x_state { =20
> Since the filename is dac8163.c, how about naming the functions/structs/o=
ther symbols that as well instead of dacxx6x?
> > +	struct spi_device *spi;
> > + =20
> How about use regmap?
> > +	struct regulator *vref;
> > +	struct gpio_desc *loaddacs;
> > +
> > +	bool internal_ref;
> > +	int vref_uv;
> > +
> > +	unsigned int cached[2];
Maybe rename to make it entirely obvious what is cached.=20

> > +
> > +#define DACXX6X_CHAN(id, resolution)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +	{=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +		.type =3D IIO_VOLTAGE, .channel =3D (id), .output =3D 1,=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +		.indexed =3D 1, .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> > +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +		.scan_type =3D { .realbits =3D (resolution),=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .shift =3D 16 - (resolution) }=
,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
> > +	}
Format this as one entry per line.
	{
		.type =3D IIO_VOLTAGE,					\
		.channel =3D (id),					\
		...
		.scan_type =3D {
			.real_bits =3D (...

etc

> > +
> > +static const struct dacxx6x_chip_info dacxx6x_chip_info_table[6] =3D {
> > +	[ID_DAC7562] =3D {
As below and in other reviews - separate structures is going to be neater.
> > +static int dacxx6x_read_raw(struct iio_dev *indio_dev,
> > +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, int *val,
> > +			=C2=A0=C2=A0=C2=A0 int *val2, long mask)
> > +{
> > +	struct dacxx6x_state *st;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		st =3D iio_priv(indio_dev); =20
> Could this be assigned  before the switch?

Might as well do it at declaration.

> > +		mutex_lock(&st->lock);
> > +		*val =3D st->cached[chan->channel];
> > +		mutex_unlock(&st->lock);
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		st =3D iio_priv(indio_dev);
> > +		*val =3D st->vref_uv / MILLI; /* vref in mV */
> > +		*val2 =3D chan->scan_type.realbits;
> > +		return IIO_VAL_FRACTIONAL_LOG2;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int dacxx6x_write_reg(struct dacxx6x_state *st, int reg, int ad=
dr,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int val)
> > +{
> > +	u8 tx[3];

There was a comment on DMA - look into dma safety requirements for SPI
and how we solve them.  Here you might just want to use spi_write_then_read=
()
but make sure you understand why that helps.

> > +
> > +	tx[0] =3D COMMAND_SET(reg, addr);
> > +	tx[1] =3D (val >> 8) & 0xff; =20
> How about put_unaligned_be16?
> >=20
> > +	tx[2] =3D val & 0xff;
> > +
> > +	return spi_write(st->spi, tx, sizeof(tx));
> > +}
> > +
> > +static int dacxx6x_write_raw(struct iio_dev *indio_dev,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, int val,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 int val2, long mask)
> > +{
> > +	struct dacxx6x_state *st =3D iio_priv(indio_dev);
> > +	struct device *dev =3D &st->spi->dev;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
Comment on scope below menas
	case IIO_CHAN_INFO_RAW: {
		int ret;

		if (val2 !=3D 0) ...

> > +		dev_dbg(dev, "%s: val=3D%d val2=3D%d\n", __func__, val, val2);
> > +		if (val2 !=3D 0)
> > +			return -EINVAL;
> > +
> > +		if (val < 0 || val >=3D BIT(chan->scan_type.realbits))
> > +			return -EINVAL;
> > +
> > +		mutex_lock(&st->lock);
> > +		int ret =3D dacxx6x_write_reg(st, CMD_WRITE_UPDATE, chan->channel,

For normal variables we still use old style c in the kernel, so declaration=
 at
top of scope (I suggest adding more local scope anyway)

> > +					=C2=A0=C2=A0=C2=A0 (unsigned int)val
> > +						=C2=A0=C2=A0=C2=A0 << chan->scan_type.shift); =20
> This case should be enclosed { }. Also, Use guard() from "cleanup.h" inst=
ead of manual mutex lock/unlock. Here and in
> other places.
> > +
> > +		if (!ret)
> > +			st->cached[chan->channel] =3D val;

Style of this can be made more readable using some newish toys.

Include cleanup.h

Add scope to the case with {} and then
		guard(mutex)(&st->lock);
		ret =3D dac8163_write_reg(st, CMD_WRITE_UPDATE, chan->channel,
					(u32)val << cabn->scan_type.shift);
		if (ret)
			return ret;
	=09
		st->cached[chan->channel] =3D val;
		return 0;
	}
	=09
> > +		mutex_unlock(&st->lock);
> > +		return ret;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}

> > +static int dacxx6x_probe(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct dacxx6x_state *st;
> > +	const struct dacxx6x_chip_info *info;
> > +	int ret; =20
> Sort these in a reverse christmas tree order.
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st =3D iio_priv(indio_dev);
> > +	st->spi =3D spi;
> > +	spi_set_drvdata(spi, indio_dev);
> > +
> > +	st->loaddacs =3D devm_gpiod_get_optional(&spi->dev, "ti,loaddacs",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GPIOD_OUT_LOW); =20
> Vendor prefixes are not needed here.
> > +	if (IS_ERR(st->loaddacs))
> > +		return PTR_ERR(st->loaddacs);
> > +
> > +	st->internal_ref =3D
> > +		device_property_read_bool(&spi->dev, "ti,internal-ref");
> > +
> > +	if (!st->internal_ref) {
> > +		st->vref =3D devm_regulator_get(&spi->dev, "vref");

David covered how to cleanly get the voltage and not keep a reference
to the regulator around + that auto disables on error return from probe
or on remove of driver.

> > +		if (IS_ERR(st->vref))
> > +			return PTR_ERR(st->vref); =20
> Maybe use return dev_err_probe?

...

> > +
> > +#define DACXX6X_COMPATIBLE(of_compatible, id)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
> > +	{=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +		.compatible =3D of_compatible,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> > +		.data =3D &dacxx6x_chip_info_table[id] \

> > +	}
This macro saves a few lines but I think it would clearer
just done long hand instead.  The macro would get messier
anyway when you move away from an array + enum.

> > +

...

> > +static const struct spi_device_id dacxx6x_id_table[] =3D {
> > +	{ "dac7562", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC7562] },
> > +	{ "dac7563", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC7563] },
> > +	{ "dac8162", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8162] },
> > +	{ "dac8163", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8163] },
> > +	{ "dac8562", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8562] },
> > +	{ "dac8563", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8563] },

Using an array and an enum is something we used to do but it scales badly.
So now days we use named structures instead (I think David raised this)

> > +	{} =20
> Same here
> > +};
> > +

No blank line here either. Convention rather than a hard rule but
nice to be consistent.

> > +MODULE_DEVICE_TABLE(spi, dacxx6x_id_table);
