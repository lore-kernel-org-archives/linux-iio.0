Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BDA1F151C;
	Sun, 21 Jun 2026 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782067966; cv=none; b=WBs/VfcBQtLvQvf9zYh1Jeci8y9UO+wuxOjJul0jxFCSCHeYzYJzqVZg+0nOCzduhc0mL8PC+DUtUBpwcDD6+4qagPxIcm7DEXGLNpW/9RADREi0ZivECgMGqdesZAxaIMA82rA0xbaiVypydGmMwqPYLdpWRm0X3YXD2wFovc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782067966; c=relaxed/simple;
	bh=QXGAp7/qopcvnINyWpmCtrxynZfvefV0kQ8/fEVT1Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGPAKI/AOtypxmque3gvLDl1xQjTuyGKt30HFzTk2xKjUAbYX9UzcV2f68J4oshoWDq80n1maxG/WkwsE/JZzNkLkSCypPc9fX7PX9iWytjXmNG1Gqxvy9zkCYOrXkvG2koWHbNmj9GL5rhHXaakyoEfm1JrLLT0kAhwN7yjxDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpJ4BI66; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpJ4BI66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017881F000E9;
	Sun, 21 Jun 2026 18:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782067965;
	bh=5XIMKU3x+LMAfV2T2IE6YFUmN+0cy6jfeZAdnfEZyGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DpJ4BI66kZKkGaJjUKKjLN1duh1STj0+ObyhU7C33576CyjRR+6OMFhEJ48+BYvEo
	 30Dn58i3A/CJNqcT3TIvkGBDHHHhFDvMXNrme70Mq7/KGrIgKjiJL6H4i6Zajfes3d
	 y5wXC02ukQ5saXS4dvKZJKHNrLiBgdilYzbmJOjQ3dD5m1JpOauDZQ2jV7V7ekGF0x
	 cOirP1cjIy4WuXSNLX0yqKadDnvSa9V6TNpAya9gyQBJ9QTIG996GspCAuyztpnwe2
	 ivD6Rnrk1fC2yYbzGhQA45CPg9ZasfvIU4/Lzip1E/7BOEOynWEpIea2hvlZU2ZkQK
	 iXH/qs6LiMGaw==
Date: Sun, 21 Jun 2026 19:52:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kurt Borja
 <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: adc: add ti-ads112c14 driver
Message-ID: <20260621195235.25dc27ac@jic23-huawei>
In-Reply-To: <20260615-iio-adc-ti-ads122c14-v1-2-e6bdadf7cb2b@baylibre.com>
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
	<20260615-iio-adc-ti-ads122c14-v1-2-e6bdadf7cb2b@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Jun 2026 17:00:00 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add a new driver for the TI ADS112C14/ADS122C14 ADC chips.
>=20
> This first step is adding a very basic driver that only supports power
> on/reset and reading the system monitor channels.
>=20
> ADS112C14_SYS_MON_CHANNEL_SHORT is the last channel rather than being in
> logical order by address to keep the voltage channels together and in
> case we find we need to add variants of this channel with different
> voltage reference later.
>=20
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
>=20
> A few other notes for review that didn't seem worth putting in the
> commit message:
> * I intentionally did not use bulk regmap because later we may need to
>   get the voltage of the avdd supply.
> * I left some comments in the code where the code might look funny (e.g.
>   to reduce future diff) or does not exactly match the datasheet, in
>   which case later changes will address that.

A few really small things inline.

> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c1=
4.c
> new file mode 100644
> index 000000000000..97097ae2a487
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads112c14.c
> @@ -0,0 +1,536 @@

> +
> +#define ADS112C14_REG_IDAC_MUX_CFG			0x0E
> +#define ADS112C14_IDAC_MUX_CFG_IUNIT			BIT(7)
> +#define ADS112C14_IDAC_MUX_CFG_I2MUX			GENMASK(6, 4)
> +#define ADS112C14_IDAC_MUX_CFG_I1MUX			GENMASK(2, 0)

Maybe tweak the indent so the register vs fields is slightly easier
to see.
#define ADS112C14_REG_IDAC_MUX_CFG			0x0E
#define   ADS112C14_IDAC_MUX_CFG_IUNIT			BIT(7)
#define   ADS112C14_IDAC_MUX_CFG_I2MUX			GENMASK(6, 4)
#define   ADS112C14_IDAC_MUX_CFG_I1MUX			GENMASK(2, 0)

And deeper still for values where appropriate.

> +static const struct reg_default ads112c14_reg_defaults[] =3D {
> +	{ ADS112C14_REG_DEVICE_CFG, 0x00 },
> +	{ ADS112C14_REG_DATA_RATE_CFG, 0x00 },
> +	{ ADS112C14_REG_MUX_CFG, 0x00 },
> +	{ ADS112C14_REG_GAIN_CFG, 0x01 },
> +	{ ADS112C14_REG_REFERENCE_CFG, 0x00 },
> +	{ ADS112C14_REG_DIGITAL_CFG, 0x00 },
> +	{ ADS112C14_REG_GPIO_CFG, 0x00 },
> +	{ ADS112C14_REG_GPIO_DATA_OUTPUT, 0x00 },
> +	{ ADS112C14_REG_IDAC_MAG_CFG, 0x00 },
> +	{ ADS112C14_REG_IDAC_MUX_CFG, 0x10 },

If it is plausible to define these in terms of fields that make them
up I'd prefer that.  It isn't always sensible to do so though as
they can get very messy.

> +};
>

> +
> +static int ads112c14_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int *val,
> +			      int *val2, long mask)
> +{
> +	struct ads112c14_data *data =3D iio_priv(indio_dev);
> +	u32 vref_uV, fsr_bits;
> +
> +	/* Selecting V_REF source is not implemented yet. */
> +	vref_uV =3D ads112c14_internal_ref_uV[ADS112C14_REFERENCE_CFG_REF_VAL_2=
_5V];
> +
> +	/* Currently, everything is using signed data. */
> +	fsr_bits =3D data->chip_info->resolution_bits - 1;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		u8 buf[3];
> +		int ret;
> +
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +
> +		ret =3D ads112c14_single_conversion(data, chan, buf);
> +		iio_device_release_direct(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +
> +		switch (data->chip_info->resolution_bits) {
> +		case 16:
> +			*val =3D get_unaligned_be16(buf);
> +			break;
> +		case 24:
> +			*val =3D get_unaligned_be24(buf);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		*val =3D sign_extend32(*val, fsr_bits);
> +
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type =3D=3D IIO_TEMP) {
> +			/* TS_TC (typical) =3D 405 uV/=C2=B0C */
> +			*val =3D MILLI * vref_uV / 405;
> +			*val2 =3D fsr_bits;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		}
> +
> +		*val =3D vref_uV / (MICRO / MILLI);
> +		/*
> +		 * Last 3 SYS_MON channels (ext ref, AVDD, DVDD) need to be
> +		 * multiplied by 8 to account for internal attenuation of / 8.
> +		 */
> +		*val2 =3D fsr_bits - (chan->address >=3D 3 ? 3 : 0);
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OFFSET:
> +		/* Only the temperature channel has an offset. */
> +		if (chan->type !=3D IIO_TEMP)
> +			return -EINVAL;
> +		/* Die temperature [=C2=B0C] =3D 25=C2=B0C + (Measured voltage =E2=80=
=93 TS_Offset) / TS_TC */
> +		/* TS_TC (typical) =3D 405 uV/=C2=B0C */
> +		/* TS_Offset (typical) =3D 119.5 mV */

Trivial but make that a multiline comment block given it is all related stu=
ff.

> +		*val =3D div_s64((s64)(25 * 405 - 119500) * BIT(fsr_bits), vref_uV);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +
> +static int ads112c14_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	const struct ads112c14_chip_info *info;
> +	struct iio_dev *indio_dev;
> +	struct ads112c14_data *data;
> +	u32 reg_val;
> +	int ret;
> +
> +	info =3D i2c_get_match_data(client);

We currently (I think) still need to protect against a manual driver
override and that being NULL. Just error out if that happens as we
don't care about trying to support that.

> +
> +	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)

