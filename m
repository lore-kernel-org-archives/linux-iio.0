Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B939890B
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266213; cv=none; b=hoIdPzqIzrzefBDJZf+0J+FFbYld/Y2R5XWExOJNJ0QIdLCu5sJZ5BubP1+xsjjo/6NwFzukgjOXoT09ujzqLa4U1Pajh+rPENM0YjAdcAdyQgPrz48L47++Jjo1+E4o7Kn4ijo1hYEz1/NJuK0Csl9wzgepPNHPcHZnw5pRHYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266213; c=relaxed/simple;
	bh=cMPLX0fh67+Fa6CiVDnaBcJ/BJUyqCW1+bQ8uj1pZbc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lgdx3tLJVhlSml5XGWvW9n4lgUKcu+3vaychVfC17o5Ucg5qs3TcJhfIMV1CqW1De3xBbGz0PH9f6N45Qur6x7PPHGiJCoAfEOeYJeFwSFz7cB5juS4sPKDE0KscO1mar2ub2FitG51fEes4Ma7s+0grKCbWY8gMMH7J/ilwphc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4wpyGYQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4wpyGYQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48704db565eso17584835e9.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 04:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774266204; x=1774871004; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bB+rKxPD1Kqj43Q7nwMeIeg+ZZIoPhDlV542kn9u7xk=;
        b=D4wpyGYQL/D6Q79pAabH0Yyxx4zEcvTyX1nK3hibixWPmrkHeJ/8KfCDPTWRKqwsQH
         d7QdZdXuwUlE2LTE4yPYp6Eeqz1aw6zew4/DlgqbAMPszmlb1eF1x0txaqXiyRKLntDW
         8sauWkBbL3LzVdCzuny/2F8gsYZdIuUTQ1hdNjEmDFAfg38Tde78GrdGiPfBnk6B1SHI
         ZEsIK617rrFGAzQeUNXPYEXOKXRrTWYnbCWJosnKMQ9Op+MqDxCvw9k0OoUlJ64ksWAM
         07EihrmnltI4UaRBHNiqHXtfFb6ZWaF28duKxG1pihxRFonDRzkF/7SYqR8mr5v52BA1
         IpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774266204; x=1774871004;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bB+rKxPD1Kqj43Q7nwMeIeg+ZZIoPhDlV542kn9u7xk=;
        b=U8Oe96W5SYL+1Zn07s7LDhEBwcV/moUXL5ff6SxC1otRrpWEjN+po2der3ineA1MiV
         5LWBuJlu9Wayk4VXEp7UuHHV1tzOesZFPmmKm37Rhg7ZRX6VQs+sNzHdbkRC3FRb42xw
         Q0c8dlbY2ES0+CqqQDDgRaydHyD0kqgweRMUPzbCjrIVf9NFeNkuWav/WUaQhho52E6P
         XBNHDzLmK1Qw8h2n1wqG538ca/R8E7FvApfX5r/45e29YIrxRyHMoqyvuVkpI1FQJ5Au
         E6tX4iSFyEZcSiQ/tNznPEczmHGwWHH0DLQ3yB1AZh+nf1jj0lZjhl9sBbWLLg7Ljcrn
         lNag==
X-Gm-Message-State: AOJu0YyP7PRjOHoyPPMsqYmoX8AVU2SFIV4a52i0zVsNfnuA39uey4Tf
	3ez41P0swHtbNxyMRZO/Of6kfomLpkOjER/HuwwcJG5jNkrkVu3znK1C
X-Gm-Gg: ATEYQzyi1pxoIkYLTzPAPJnpqyGJdtEzETrY7GZFmDCpsLfJ4OBo8dUUYUyBfGL+8bw
	p38N8KBT2LD/H/2ifyHhp6ndcE3Qjoc3hMARNeve7MPOuVv3yuJOdVwj7T/nOyHs7lZv9Nw6yBG
	XCm0xrP0v0kmxoTrHQwhwA+gZrM9Y1sNBmfjnAdBp6JAE3smPp5FgYhHScotGEMXoLhj4hMSUHD
	T8n3p69tPpHpGmSd60T6uAbsp7wATN2r9ptOfESlSZP44jli+YjqBPmlQw9r0zDZo634AfZSv4T
	oocsEh09kL5pramGCvVGWYKbyynzAwOY2G5zq9C5k/0ifGzrNcmt2Gs+C7LVV7s0I4jDSoQSU0B
	xaQsULbAh6PlpKowuEB/SeO9kqC8aevHCV1mLDKoziD11hgGPUANZk2yw9TaDmZMRReflOtmU4u
	4GMAEPafM6j183TqFdefRSg/+uiJ+0Ucs=
X-Received: by 2002:a05:600c:a402:b0:485:303b:c50a with SMTP id 5b1f17b1804b1-486fedb546amr127530805e9.13.1774266204084;
        Mon, 23 Mar 2026 04:43:24 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48700658441sm371204295e9.4.2026.03.23.04.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 04:43:23 -0700 (PDT)
Message-ID: <3f7cfb4baf2b92cf13b2d7f97f0e77027f4b917a.camel@gmail.com>
Subject: Re: [PATCH v4 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner	 <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,  Andy Shevchenko	
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown	 <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski	 <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Date: Mon, 23 Mar 2026 11:44:09 +0000
In-Reply-To: <20260320-ad4692-multichannel-sar-adc-driver-v4-2-052c1050507a@analog.com>
References: 
	<20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com>
	 <20260320-ad4692-multichannel-sar-adc-driver-v4-2-052c1050507a@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Radu,

minor comments on top of what was said already,

On Fri, 2026-03-20 at 13:03 +0200, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
>=20
> Add support for the Analog Devices AD4691 family of high-speed,
> low-power multichannel SAR ADCs: AD4691 (16-ch, 500 kSPS),
> AD4692 (16-ch, 1 MSPS), AD4693 (8-ch, 500 kSPS) and
> AD4694 (8-ch, 1 MSPS).
>=20
> The driver implements a custom regmap layer over raw SPI to handle the
> device's mixed 1/2/3/4-byte register widths and uses the standard IIO
> read_raw/write_raw interface for single-channel reads.
>=20
> The chip idles in Autonomous Mode so that single-shot read_raw can use
> the internal oscillator without disturbing the hardware configuration.
>=20
> Three voltage supply domains are managed: avdd (required), vio, and a
> reference supply on either the REF pin (ref-supply, external buffer)
> or the REFIN pin (refin-supply, uses the on-chip reference buffer;
> REFBUF_EN is set accordingly). Hardware reset is performed via
> the reset controller framework; a software reset through SPI_CONFIG_A
> is used as fallback when no hardware reset is available.
>=20
> Accumulator channel masking for single-shot reads uses ACC_MASK_REG via
> an ADDR_DESCENDING SPI write, which covers both mask bytes in a single
> 16-bit transfer.
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 11 +
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad4691.c | 686 ++++++++++++++++++++++++++++++++++++=
+++++++++++
> =C2=A04 files changed, 699 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 438ca850fa1c..24e4502b8292 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1490,6 +1490,7 @@ L:	linux-iio@vger.kernel.org
> =C2=A0S:	Supported
> =C2=A0W:	https://ez.analog.com/linux-software-drivers
> =C2=A0F:	Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
> +F:	drivers/iio/adc/ad4691.c
> =C2=A0

...

>=20
> +
> +struct ad4691_state {
> +	const struct ad4691_chip_info	*info;
> +	struct regmap			*regmap;
> +	int				vref_uV;
> +	bool				refbuf_en;
> +	bool				ldo_en;
> +	/*
> +	 * Synchronize access to members of the driver state, and ensure
> +	 * atomicity of consecutive SPI operations.
> +	 */
> +	struct mutex			lock;
> +};

I would not use tabs and align all the members. Makes thinks harder in the =
future if
an update is needed. I would just use a simple space.

> +
> +static int ad4691_reg_read(void *context, unsigned int reg, unsigned int=
 *val)
> +{
> +	struct spi_device *spi =3D context;
> +	u8 tx[2], rx[4];
> +	int ret;
> +
> +	put_unaligned_be16(0x8000 | reg, tx);
> +
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_SAT_OVR_REG(15):
> +		ret =3D spi_write_then_read(spi, tx, 2, rx, 1);
> +		if (ret)
> +			return ret;
> +		*val =3D rx[0];
> +		return 0;
> +	case AD4691_STD_SEQ_CONFIG:
> +	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
> +		ret =3D spi_write_then_read(spi, tx, 2, rx, 2);
> +		if (ret)
> +			return ret;
> +		*val =3D get_unaligned_be16(rx);
> +		return 0;
> +	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
> +	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
> +		ret =3D spi_write_then_read(spi, tx, 2, rx, 3);
> +		if (ret)
> +			return ret;
> +		*val =3D get_unaligned_be24(rx);
> +		return 0;
> +	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
> +		ret =3D spi_write_then_read(spi, tx, 2, rx, 4);
> +		if (ret)
> +			return ret;
> +		*val =3D get_unaligned_be32(rx);
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4691_reg_write(void *context, unsigned int reg, unsigned in=
t val)
> +{
> +	struct spi_device *spi =3D context;
> +	u8 tx[4];
> +
> +	put_unaligned_be16(reg, tx);
> +
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_MASK_REG - 1:
> +	case AD4691_ACC_MASK_REG + 1 ... AD4691_GPIO_MODE2_REG:
> +		if (val > 0xFF)
> +			return -EINVAL;
> +		tx[2] =3D val;
> +		return spi_write_then_read(spi, tx, 3, NULL, 0);
> +	case AD4691_ACC_MASK_REG:
> +	case AD4691_STD_SEQ_CONFIG:
> +		if (val > 0xFFFF)
> +			return -EINVAL;
> +		put_unaligned_be16(val, &tx[2]);
> +		return spi_write_then_read(spi, tx, 4, NULL, 0);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static bool ad4691_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case AD4691_STATUS_REG:
> +	case AD4691_CLAMP_STATUS1_REG:
> +	case AD4691_CLAMP_STATUS2_REG:
> +	case AD4691_GPIO_READ:
> +	case AD4691_ACC_STATUS_FULL1_REG ... AD4691_ACC_STATUS_SAT2_REG:
> +	case AD4691_ACC_SAT_OVR_REG(0) ... AD4691_ACC_SAT_OVR_REG(15):
> +	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
> +	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
> +	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
> +	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool ad4691_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_SAT_OVR_REG(15):
> +	case AD4691_STD_SEQ_CONFIG:
> +	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
> +	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
> +	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
> +	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool ad4691_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_STD_SEQ_CONFIG:
> +	case AD4691_SPARE_CONTROL ... AD4691_GPIO_MODE2_REG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config ad4691_regmap_config =3D {
> +	.reg_bits =3D 16,
> +	.val_bits =3D 32,
> +	.reg_read =3D ad4691_reg_read,
> +	.reg_write =3D ad4691_reg_write,
> +	.volatile_reg =3D ad4691_volatile_reg,
> +	.readable_reg =3D ad4691_readable_reg,
> +	.writeable_reg =3D ad4691_writeable_reg,
> +	.max_register =3D AD4691_ACC_STS_DATA(15),
> +	.cache_type =3D REGCACHE_MAPLE,
> +};
> +
> +static int ad4691_get_sampling_freq(struct ad4691_state *st, int *val)
> +{
> +	unsigned int reg_val;
> +	int ret;
> +
> +	ret =3D regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D ad4691_osc_freqs[FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val)];
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, int freq)
> +{
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +	unsigned int start =3D (st->info->max_rate =3D=3D HZ_PER_MHZ) ? 0 : 1;
> +	unsigned int i;
> +
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	for (i =3D start; i < ARRAY_SIZE(ad4691_osc_freqs); i++) {
> +		if ((int)ad4691_osc_freqs[i] =3D=3D freq)

maybe just make the array signed.

> +			return regmap_update_bits(st->regmap, AD4691_OSC_FREQ_REG,
> +						=C2=A0 AD4691_OSC_FREQ_MASK, i);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad4691_read_avail(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 const int **vals, int *type,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 int *length, long mask)
> +{
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +	unsigned int start =3D (st->info->max_rate =3D=3D HZ_PER_MHZ) ? 0 : 1;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals =3D (const int *)&ad4691_osc_freqs[start];
> +		*type =3D IIO_VAL_INT;
> +		*length =3D ARRAY_SIZE(ad4691_osc_freqs) - start;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4691_single_shot_read(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0 struct iio_chan_spec const *chan, int *val)
> +{
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/*
> +	 * Use AUTONOMOUS mode for single-shot reads. The chip always
> +	 * operates in AUTONOMOUS mode in this driver revision.
> +	 */
> +	ret =3D regmap_write(st->regmap, AD4691_STATE_RESET_REG,
> +			=C2=A0=C2=A0 AD4691_STATE_RESET_ALL);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +			=C2=A0=C2=A0 BIT(chan->channel));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4691_ACC_MASK_REG,
> +			=C2=A0=C2=A0 (u16)~BIT(chan->channel));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4691_OSC_EN_REG, 1);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Wait for at least 2 internal oscillator periods for the
> +	 * conversion to complete.
> +	 */
> +	fsleep(DIV_ROUND_UP(2 * USEC_PER_SEC,
> +			=C2=A0=C2=A0=C2=A0 ad4691_osc_freqs[FIELD_GET(AD4691_OSC_FREQ_MASK,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg_val)]));
> +
> +	ret =3D regmap_write(st->regmap, AD4691_OSC_EN_REG, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(st->regmap, AD4691_AVG_IN(chan->channel), &reg_val)=
;
> +	if (ret)
> +		return ret;
> +
> +	*val =3D reg_val;
> +
> +	ret =3D regmap_write(st->regmap, AD4691_STATE_RESET_REG, AD4691_STATE_R=
ESET_ALL);
> +	if (ret)
> +		return ret;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad4691_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0 struct iio_chan_spec const *chan, int *val,
> +			=C2=A0=C2=A0 int *val2, long info)
> +{
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW: {
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +
nit: I would drop the extra new line. The check below is related to the
above.

> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		return ad4691_single_shot_read(indio_dev, chan, val);
> +	}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad4691_get_sampling_freq(st, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D st->vref_uV / (MICRO / MILLI);
> +		*val2 =3D chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4691_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad4691_set_sampling_freq(indio_dev, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4691_reg_access(struct iio_dev *indio_dev, unsigned int reg=
,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int writeval, unsigned int *readval=
)
> +{
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +
> +	return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +static const struct iio_info ad4691_info =3D {
> +	.read_raw =3D &ad4691_read_raw,
> +	.write_raw =3D &ad4691_write_raw,
> +	.read_avail =3D &ad4691_read_avail,
> +	.debugfs_reg_access =3D &ad4691_reg_access,
> +};
> +
> +static int ad4691_regulator_setup(struct ad4691_state *st)
> +{
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	int ret;
> +
> +	ret =3D devm_regulator_get_enable(dev, "avdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get and enable AVDD\n");
> +
> +	ret =3D devm_regulator_get_enable(dev, "ldo-in");
> +	if (ret && ret !=3D -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get and enable LDO-IN\n");
> +	st->ldo_en =3D (ret =3D=3D -ENODEV);
> +
> +	ret =3D devm_regulator_get_enable(dev, "vio");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get and enable VIO\n");
> +
> +	st->vref_uV =3D devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (st->vref_uV >=3D 0) {
> +		st->refbuf_en =3D false;
> +	} else if (st->vref_uV =3D=3D -ENODEV) {
> +		st->vref_uV =3D devm_regulator_get_enable_read_voltage(dev, "refin");
> +		st->refbuf_en =3D true;
> +	}
> +	if (st->vref_uV < 0)
> +		return dev_err_probe(dev, st->vref_uV,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get reference supply\n");
> +
> +	if (st->vref_uV < AD4691_VREF_uV_MIN || st->vref_uV > AD4691_VREF_uV_MA=
X)
> +		return dev_err_probe(dev, -EINVAL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "vref(%d) must be in the range [%u...%u]\n"=
,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 st->vref_uV, AD4691_VREF_uV_MIN,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 AD4691_VREF_uV_MAX);
> +
> +	return 0;
> +}
> +
> +static int ad4691_reset(struct ad4691_state *st)
> +{
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	struct reset_control *rst;
> +
> +	rst =3D devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset\n");
> +
> +	if (!rst)
> +		/* No hardware reset available, fall back to software reset. */
> +		return regmap_write(st->regmap, AD4691_SPI_CONFIG_A_REG,
> +				=C2=A0=C2=A0=C2=A0 AD4691_SW_RESET);
> +
> +	reset_control_assert(rst);

Can't we ask for the reset in the asserted state already?

> +	/* Reset delay required. See datasheet Table 5. */
> +	fsleep(300);
> +	reset_control_deassert(rst);
> +
> +	return 0;
> +}
> +
> +static int ad4691_config(struct ad4691_state *st)
> +{
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	enum ad4691_ref_ctrl ref_val;
> +	int ret;
> +
> +	switch (st->vref_uV) {
> +	case AD4691_VREF_uV_MIN ... AD4691_VREF_2P5_uV_MAX:
> +		ref_val =3D AD4691_VREF_2P5;
> +		break;
> +	case AD4691_VREF_2P5_uV_MAX + 1 ... AD4691_VREF_3P0_uV_MAX:
> +		ref_val =3D AD4691_VREF_3P0;
> +		break;
> +	case AD4691_VREF_3P0_uV_MAX + 1 ... AD4691_VREF_3P3_uV_MAX:
> +		ref_val =3D AD4691_VREF_3P3;
> +		break;
> +	case AD4691_VREF_3P3_uV_MAX + 1 ... AD4691_VREF_4P096_uV_MAX:
> +		ref_val =3D AD4691_VREF_4P096;
> +		break;
> +	case AD4691_VREF_4P096_uV_MAX + 1 ... AD4691_VREF_uV_MAX:
> +		ref_val =3D AD4691_VREF_5P0;
> +		break;
> +	default:
> +		return dev_err_probe(dev, -EINVAL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Unsupported vref voltage: %d uV\n",
> +				=C2=A0=C2=A0=C2=A0=C2=A0 st->vref_uV);
> +	}
> +
> +	ret =3D regmap_write(st->regmap, AD4691_REF_CTRL,
> +			=C2=A0=C2=A0 FIELD_PREP(AD4691_REF_CTRL_MASK, ref_val) |
> +			=C2=A0=C2=A0 (st->refbuf_en ? AD4691_REFBUF_EN : 0));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write REF_CTRL\n");
> +
> +	ret =3D regmap_write(st->regmap, AD4691_DEVICE_SETUP,
> +			=C2=A0=C2=A0 st->ldo_en ? AD4691_LDO_EN : 0);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write DEVICE_SETUP\n");
> +
> +	/*
> +	 * Set the internal oscillator to the highest valid rate for this chip.
> +	 * Index 0 (1 MHz) is valid only for AD4692/AD4694; AD4691/AD4693 start
> +	 * at index 1 (500 kHz).
> +	 */
> +	ret =3D regmap_write(st->regmap, AD4691_OSC_FREQ_REG,
> +			=C2=A0=C2=A0 (st->info->max_rate =3D=3D HZ_PER_MHZ) ? 0 : 1);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write OSC_FREQ\n");
> +
> +	/* Device always operates in AUTONOMOUS mode. */

Kind of obvious from the code. Drop the comment please.


- Nuno S=C3=A1
